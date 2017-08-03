package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbMap;
import com.hs.util.DateUtil;
import com.hs.web.Global;
import com.hs.web.PathManager;
import com.hs.web.RequestMap;
import com.hs.web.mapper.HealthMapper;
import com.hs.web.mapper.NoticeMapper;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Service
public class FileService {
    private static final Logger logger = LoggerFactory.getLogger(FileService.class);

    private String file_id;

    @Autowired
    private PathManager pathManager;
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private HealthMapper healthMapper;

    //업로드
    public String uploadFile(HttpServletRequest request, RequestMap req) throws Exception {
        String inputName = req.get("inputName") + "";
        File pageFile;
        String dbFilePath;
        String organizedFilePath;
        String organizedThumbnaiFilePath;
        String randomName;

        if (Global.isDev) logger.info("[FileService uploadFile] inputName={}" + inputName);

        notMultipart(request);

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;

        MultipartFile file = mrequest.getFile(inputName);

        notFile(file);

        String fileName = file.getName();
        String originalFilename = file.getOriginalFilename();

        String contentType = file.getContentType();
        long fileSize = file.getSize();

        String[] randomStr = getRandomString();


        fileSizeCheck(fileSize, 320000000);


        String fileExtention = getFileExtention(originalFilename);


        //임시저장위치
        File tempFile = pathManager.getTempFile();

        String middleName = null;

        String fileIndexStr = null;

        int fileIndex;

        /**
         * todo : 광고관리 파일저장 1:1
         */
        if (inputName.equals("filename")) {//광고관리 파일
            String adindex = (String) req.get("adindex");
            if (adindex == null) {
                fileIndex = 1;
            } else {
                fileIndex = Integer.parseInt(adindex);
            }

            fileIndexStr = String.format("%010d", fileIndex);
            middleName = "adinfo";


        /**
         * todo : 전문가사진 파일저장 1:1
         */
        } else if (inputName.equals("picturename")) { //

            fileIndexStr = req.get("specialid") + "";
            middleName = "special_member";


        /**
         * todo : 공지사항 파일저장 1:N
         **/
        } else if (inputName.equals("notice_filename")) {//공지사항

            int sequencenum;

            DbMap lastFileIndex = noticeMapper.getLastFileIndex(req);

            if (lastFileIndex == null) {
                sequencenum = 1;

            } else {
                sequencenum = Integer.parseInt(lastFileIndex.get("lastFileIndex") + "") + 1;

            }

            req.put("sequencenum", sequencenum);

            int noticeindexNum = Integer.parseInt(req.get("noticeindex") + "");


            String first = String.format("%010d", noticeindexNum);
            String second = String.format("%03d", sequencenum);
            fileIndexStr = first + "_" + second + "." + fileExtention;
            middleName = "notice";

            //noticeindex(%10d) + '_' + sequencenum(%3d) + '.' + 확장자. 예)0000000012_001.png

            logger.info("[FileService fileInfo] req={}", req);


        /**
         todo : 건강정보 썸네일파일저장 1:1
         **/
        } else if (inputName.equals("thumbnailfile")) {//공지사항
//            healthindex(%10d) + '.' + 확장자. 예)0000000012.png

            int indexNum = 0;
            if (req.get("healthindex") != null) {
                indexNum = Integer.parseInt(req.get("healthindex") + "");
            }



            String first = String.format("%010d", indexNum);


            fileIndexStr = first + "." + fileExtention;

            middleName = "healthinfo/thumbnailfile";

        /**
         todo : 건강정보 사진저장 1:N
         **/
        } else if (inputName.equals("health_file")) {//공지사항
//            healthindex(%10d) + '.' + 확장자. 예)0000000012.png

            int indexNum = 0;
            if (req.get("healthindex") != null) {
                indexNum = Integer.parseInt(req.get("healthindex") + "");
            }



            String first = String.format("%010d", indexNum);

            //todo: getsecond healthMapper
            int getNextFileSeq = healthMapper.getNextFileSeq(req);
            String second = String.format("%03d", getNextFileSeq);


            fileIndexStr = first + "_" + second + "." + fileExtention;
//            트 /upload/healthinfo/healthfiles/0000000001/0000000001_001.png
            middleName = "healthinfo/healthfiles/"+first;
        }


        dbFilePath = "/" + middleName + "/";



        /**
         todo : 공지사항 파일저장이름 1:N
         **/
        if (inputName.equals("notice_filename")) {

            randomName = fileIndexStr;

        /**
         todo : 건강정보 썸네일파일저장 이름 1:1
         **/
        }else if (inputName.equals("thumbnailfile")) {

            randomName = fileIndexStr;


        /**
         todo : 건강정보 썸네일파일저장 이름 1:NM
         **/
        }else if (inputName.equals("health_file")) {

            randomName = fileIndexStr;


        } else {

            randomName = fileIndexStr + "." + fileExtention;

        }


        //실제 저장위치
        pageFile = pathManager.getPageFileNotByDate(middleName, randomName);

        existFiles(fileIndexStr, file, tempFile, pageFile);
        //파일 폴더에 저장
        saveFiles(file, tempFile, pageFile);

        //파일경로
        organizedFilePath = Global.UPLOAD_PATH + dbFilePath + randomName;
        organizedThumbnaiFilePath = Global.UPLOAD_PATH + dbFilePath + "t_" + randomName;

        String isThumnail = req.get("isThumnail") + "";

        //썸네일
        if (isThumnail.equalsIgnoreCase("true")) {
            imgThumnail(req, organizedFilePath, organizedThumbnaiFilePath);
        }


        //등록된 FILE_ID 조회 :랜덤문자열
        file_id = randomName;


        //FILE_INFO 에 등록
        req.put("filename", file_id);
        String filetype = "1";
        String lowerExt = fileExtention.toLowerCase();
        if (lowerExt.contains("mp4") || lowerExt.contains("mpg") || lowerExt.contains("mpeg") || lowerExt.contains("mov") || lowerExt.contains("wmv") || lowerExt.contains("asf")) {
            filetype = "2";
        }
        req.put("filetype", filetype);
        req.put("file_path", "/upload" + dbFilePath);
        req.put("file_name", randomName);
        req.put("file_original_name", originalFilename);
        req.put("file_size", fileSize);

        if (Global.isDev) logger.info("[FileService uploadFile] req = {}" + req);

        if (Global.isDev) {
            logger.info("[FileService fileInfo] inputName={}", inputName);
            logger.info("[FileService fileInfo] fileName={}", fileName);
            logger.info("[FileService fileInfo] originalFilename={}", originalFilename);
            logger.info("[FileService fileInfo] contentType={}", contentType);
            logger.info("[FileService fileInfo] fileSize={}", fileSize);

            logger.info("[FileService file_path] globalPath={}", Global.UPLOAD_PATH);
            logger.info("[FileService file_path] organizedFilePath={}", organizedFilePath);
            logger.info("[FileService file_path] organizedThumbnaiFilePath={}", organizedThumbnaiFilePath);

            logger.info("[FileService fileInfo] file_id={}", file_id);
        }


        if (inputName.equals("notice_filename")) {


            noticeMapper.insertFile(req);
        }

        return file_id;
    }

    //썸네일만들기
    public void makeThumbNai(String src, String dest, int width, int height) throws IOException {
        Thumbnails.Builder b = Thumbnails.of(new File(src)).size(width, height);
        b.toFile(new File(dest));
    }

    private String getCurrentDate() {
        return DateUtil.getCurrent() + "";
    }

    private String getCurrentTime() {
        return DateUtil.getCurrentTime() + "";
    }

    private void saveFiles(MultipartFile file, File tempFile, File pageFile) throws IOException {
        FileOutputStream pageOut = new FileOutputStream(tempFile);
        IOUtils.copy(file.getInputStream(), pageOut);
        IOUtils.closeQuietly(pageOut);
        FileUtils.moveFile(tempFile, pageFile);
    }

    private void existFiles(String filename, MultipartFile file, File tempFile, File pageFile) throws IOException {

        logger.info("exist={}", pageFile.isFile());
        // 파일 존재 여부 판단
        if (pageFile.isFile()) {

//      FileOutputStream oriFile = new FileOutputStream(""+filename);
//      FileOutputStream pageOut = new FileOutputStream(pageFile);
//      IOUtils.copy(file.getInputStream(), pageOut);
//      IOUtils.closeQuietly(pageOut);
//      FileUtils.moveFile(pageFile, tempFile);
            FileUtils.deleteQuietly(pageFile);
        }

    }

    private String getFileExtention(String originalFilename) {
        String fileExtention = "";
        int i = originalFilename.lastIndexOf(".");
        if (i > 0) fileExtention = originalFilename.substring(i + 1);
        return fileExtention;
    }

    private void imgThumnail(RequestMap req, String organizedFilePath, String organizedThumbnaiFilePath) throws IOException {
        BufferedImage bimg = ImageIO.read(new File(organizedFilePath));
        int width = bimg.getWidth();
        int height = bimg.getHeight();
        int newHeight = 700 * height / width;
        if (width > 700) {
            makeThumbNai(organizedFilePath, organizedThumbnaiFilePath, 700, newHeight);
        } else {
            makeThumbNai(organizedFilePath, organizedThumbnaiFilePath, width, height);
        }
        if (Global.isDev == true) {
            logger.info("img_file_width={}", width);
            logger.info("img_file_height={}", height);

        }


    }

    private void imgThumnail(RequestMap req, String organizedFilePath, String organizedThumbnaiFilePath, int w) throws IOException {
        BufferedImage bimg = ImageIO.read(new File(organizedFilePath));
        int width = bimg.getWidth();
        int height = bimg.getHeight();
        int newHeight = 400 * height / width;
        if (width > 400) {
            makeThumbNai(organizedFilePath, organizedThumbnaiFilePath, 400, 75);
        } else {
            makeThumbNai(organizedFilePath, organizedThumbnaiFilePath, width, height);
        }

        if (Global.isDev) {
            logger.info("img_file_width={}", width);
            logger.info("img_file_height={}", height);

        }
    }

    private void fileSizeCheck(long fileSize, long limit) {
        if (fileSize > limit) {
            throw new BizException("파일용량 3M 이하로 올려주세요.");
        }
    }

    private String[] getRandomString() {
        UUID randomUUID = UUID.randomUUID();
        return randomUUID.toString().split("-");
    }

    private void notFile(MultipartFile file) {
        if (file == null) {
            throw new BizException("file이 없습니다.");
        }
    }

    private void notMultipart(HttpServletRequest request) {
        if (!(request instanceof MultipartHttpServletRequest)) {
            throw new BizException("multipart객체가 아닙니다.");
        }
    }


    public void deleteFile(RequestMap req) {
        String deletePath = Global.UPLOAD_PATH + "/notice/" + req.get("filename");
        if (Global.isDev) logger.debug("[notice deleteFile] deletePath:{}", deletePath);
//    String s = "test_9999.txt";
        File f = new File(deletePath);


        if (f.delete()) {
            logger.info("파일 또는 디렉토리를 성공적으로 지웠습니다: " + deletePath);
        } else {
            logger.info("파일 또는 디렉토리 지우기 실패: " + deletePath);
        }

    }

    public void deleteHealthFile(RequestMap req) {
        String healthindex = req.get("healthindex")+"";
//        if(healthindex.equals("")){
//            healthindex="0";
//        }
        int healthindexInt =  Integer.parseInt(healthindex);
        String healthindexStr = String.format("%010d", healthindexInt);
        String deletePath = Global.UPLOAD_PATH + "/healthinfo/healthfiles/" +healthindexStr+"/" +req.get("filename");
        logger.info("[health_file deleteHealthFile] deletePath:{}", deletePath);
//    String s = "test_9999.txt";
        File f = new File(deletePath);


        if (f.delete()) {
            logger.info("파일 또는 디렉토리를 성공적으로 지웠습니다: " + deletePath);
        } else {
            logger.info("파일 또는 디렉토리 지우기 실패: " + deletePath);
        }

    }


    public void deleteFileName(String path) {

        File f = new File(path);


        if (f.delete()) {
            logger.info("파일 또는 디렉토리를 성공적으로 지웠습니다: " + path);
        } else {
            logger.info("파일 또는 디렉토리 지우기 실패: " + path);
        }

    }


    //다운로드
    public String download(HttpServletRequest request) throws IOException {
        RequestMap req = RequestMap.create(request);
        req.putAll((Map) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE));

        String fullPath = req.get("path") + "\\" + req.get("fileName");
        if (Global.isDev) logger.info("fullPath={}", fullPath);
        return fullPath;
    }


    public void uploadFiles(HttpServletRequest request, RequestMap req) throws Exception {
//    req.putAll(RequestMap.create(request));

        if (request instanceof MultipartHttpServletRequest) {

            logger.debug("req={}", req);

            String inputName = (String) req.get("inputName");


            req.put(inputName, uploadFile(request, req));

        }
    }
}
