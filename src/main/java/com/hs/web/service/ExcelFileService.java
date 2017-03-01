package com.hs.web.service;

import com.hs.BizException;
import com.hs.ResultMap;
import com.hs.util.DateUtil;
import com.hs.web.Global;
import com.hs.web.PathManager;
import com.hs.web.RequestMap;
import com.hs.web.tx.txManager;
import jxl.Sheet;
import jxl.Workbook;
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
public class ExcelFileService {
    private static final Logger logger = LoggerFactory.getLogger(ExcelFileService.class);
    @Autowired
    private MemberService memberService;
    private Workbook openWorkbook;
    private Sheet openSheet;
    private String file_id;

    @Autowired
    private PathManager pathManager;

    //업로드
    @txManager
    public ResultMap uploadFile(HttpServletRequest request, RequestMap req) throws Exception {
        ResultMap res = ResultMap.create();
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
//        File excelFile = (File) ((MultipartHttpServletRequest) request).getFile(inputName);

        notFile(file);

        String fileName = file.getName();
        String originalFilename = file.getOriginalFilename();

        String contentType = file.getContentType();
        long fileSize = file.getSize();

        String randomStr = getRandomString()[0];

        //todo: 파일용량 체크 뒤에 제한숫자
        fileSizeCheck(fileSize, 320000000);
//    String now = req.get("scantime") + "";
//    String nowtime = req.get("scantime") + "";

        String fileExtention = getFileExtention(originalFilename);

        logger.debug("fileExtention={}", fileExtention);
        //todo: 엑셀서비스

        //임시저장위치
    File tempFile = pathManager.getTempFile();



//    //실제 저장위치
    pageFile = pathManager.getPageFileNotByDate("excel",randomStr+"."+fileExtention);
//
//    existFiles(adindexStr,file, tempFile, pageFile);
//    //파일 폴더에 저장
    saveFiles(file, tempFile, pageFile);
        logger.debug("pageFile={}", pageFile);
//
          /* Workbook 클래스의 객체를 아래와 같이 얻어온다. */
        openWorkbook = Workbook.getWorkbook(pageFile);

        /* Workbook 객체(엑셀파일) 의 첫번째 시트(인덱스0) 를 얻어온다. */
        openSheet = openWorkbook.getSheet(0);
        int totalColumns = openSheet.getColumns();
        logger.debug("totalColumns : ={}",totalColumns);

        String arryField[] ;

        /* 아래코드는 엑셀파일내의 행 길이만큼 반복적으로 지정한 열 위치의 값을 불러오는 코드*/
//        String arryField[] = {"번호","병원/약국","전화번호","우편번호","소재지주소","홈페이지"};
//        if(totalColumns==7){
            arryField = new String[]{"no", "name", "gubun", "telephone", "zipcode", "address", "introduce"};
//        }else{
//            arryField = new String[]{"no", "name", "gubun", "telephone", "zipcode", "address", "introduce", "openflag"};
//        }

        /* openSheet.getRows() 는 엑셀의 행 길이*/
        for (int i = 1; i < openSheet.getRows(); i++) {
            for(int j=0;j<totalColumns;j++){
                String value = null;
                logger.debug("i : ={}", i+" : "+j);
                logger.debug("i,j getContents={}", openSheet.getCell(j, i).getContents());//행,열
                String contents = openSheet.getCell(j, i).getContents();
                if(j==2){

                    if(contents.indexOf("병원")>-1){
                        value ="2";
                    }else{
                        value ="1";
                    }

                }else {
                    value =contents;
                }

                req.put(arryField[j]+"",value);
                logger.debug("i,j req={}", arryField[j]+" /// "+value);//행,열

            }
            int no =  Integer.parseInt(req.get("no")+"");
            String noStr = "B"+String.format("%010d",no);
            String randomId = noStr;//noStr+"_"+randomStr.substring(0,2);
            logger.debug("randomId : ={}",randomId);
//            if(req.get("memberid")==null)req.put("memberid",randomId);
            req.put("memberid",randomId);
            if(req.get("password") == null) req.put("password", "1234");
//            req.put("password", randomId);
            if(req.get("openflag") == null) req.put("openflag", 0);
            req.put("isNew","Y");
            req.put("deleteyn","0");
            req.put("idx",i);
            logger.debug("req : ={}",req);

            memberService.excelSave(req);
                        /* openSheet.getCell(열, 행) 으로 Cell을 얻어온다 */
//            Cell cellCounter = openSheet.getCell(5, i);
//            Cell cellScreening = openSheet.getCell(6, i);
//
//                        /* 얻어온 Cell의 getContents() 을 사용하여 Cell 안의 문자열을 얻어온다.*/
//
//            logger.debug("excel={}", openSheet.getCell(0, 1).getContents());




//      if((counterNumber.toString().equals(cellCounter.getContents())) &&
//              (screeningNumber.toString().equals(cellScreening.getContents()))){
//        return openSheet.getCell(17, i).getContents();
//      }
        }

        openWorkbook.close();
//
//// Workbook을 생성해서 읽을 Excel File을 넣습니다.
//    Workbook workbook = Workbook.getWorkbook(new File(fileName));
//// Sheet를 생성해서 workbook에 넣은 Excel File을 Sheet단위로 분리합니다.
//    Sheet sheet = workbook.getSheet();
//// cell을 생성해서 Sheet의 내용을 cell단위로 분리해서 읽습니다.
//    Cell cell = sheet.getCell(행번호,열번호);
//// cell내용을 String형태로 담고, DB에 적재하거나 적절히 사용합니다.
//    String excelData = cell.getContents();
//// 작업이 끝나면 workbook을 종료합니다.
//    workbook.close();


        //임시저장위치
//    File tempFile = pathManager.getTempFile();
//
////    String year = now.substring(0, 4);
////    String month = now.substring(4, 6);
////    String date = now.substring(6, 8);
////    String middleName =  req.get("uploadDir")+"";
//    String middleName = null;
//    String adindexStr = null;
//    int adindex;
//    if(inputName.equals("filename")){
//      adindex =Integer.parseInt((req.get("adindex") + "")) ;
//      adindexStr = String.format("%010d",adindex);
//      middleName ="adinfo";
//    }
//
//
//    //디비 저장위치
////    dbFilePath ="/"+ middleName+"/"+ year + "/" + date + "/";
////    dbFilePath = "/" + year + "/" + month + "/" + date + "/" + memberid + "/";
////    dbFilePath = "/" + year + "/" + month + "/" + date + "/" + adindex + "/";
//    //dbFilePath = "/" + adindexStr + "/";
//
//
//    dbFilePath = "/" + middleName + "/";
//
////    randomName = randomStr[0] +"_"+now.substring(8,now.length())+ "." + fileExtention;
//    String name = "";
//    if (inputName.equals("generalimagefile")) {
//      name = "G";
//    } else if (inputName.equals("irimagefile")) {
//      name = "R";
//    } else {
//      name = "S";
//    }
////    randomName = adindex + "_" + name + "_" + randomStr[0] + "_" + nowtime + "." + fileExtention;
//    randomName = adindexStr +"." + fileExtention;
//
//
//
//    //실제 저장위치
//    pageFile = pathManager.getPageFileNotByDate(middleName,randomName);
//
//    existFiles(adindexStr,file, tempFile, pageFile);
//    //파일 폴더에 저장
//    saveFiles(file, tempFile, pageFile);
//
//    //파일경로
//    organizedFilePath = Global.UPLOAD_PATH + dbFilePath + randomName;
//    organizedThumbnaiFilePath = Global.UPLOAD_PATH + dbFilePath + "t_" + randomName;
//
//    String isThumnail = req.get("isThumnail") + "";
//
//    //썸네일
//    if (isThumnail.equalsIgnoreCase("true")) {
//      imgThumnail(req, organizedFilePath, organizedThumbnaiFilePath);
//    }
//
//
//    //등록된 FILE_ID 조회 :랜덤문자열
////    file_id = RandomStringUtils.randomAlphanumeric(15);
//    file_id = randomName;
//    //FILE_INFO 에 등록
//    req.put("filename", file_id);
//    req.put("file_path", "/upload" + dbFilePath);
//    req.put("file_name", randomName);
//    req.put("file_original_name", originalFilename);
//    req.put("file_size", fileSize);
//
//    if (Global.isDev) logger.info("[FileService uploadFile] req = {}" + req);
//
//    if (Global.isDev) {
//      logger.info("[FileService fileInfo] inputName={}", inputName);
//      logger.info("[FileService fileInfo] fileName={}", fileName);
//      logger.info("[FileService fileInfo] originalFilename={}", originalFilename);
//      logger.info("[FileService fileInfo] contentType={}", contentType);
//      logger.info("[FileService fileInfo] fileSize={}", fileSize);
//
//      logger.info("[FileService file_path] globalPath={}", Global.UPLOAD_PATH);
//      logger.info("[FileService file_path] organizedFilePath={}", organizedFilePath);
//      logger.info("[FileService file_path] organizedThumbnaiFilePath={}", organizedThumbnaiFilePath);
//
//      logger.info("[FileService fileInfo] file_id={}", file_id);
//    }

        return res;
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

    private String getRdmString() {
        UUID randomUUID = UUID.randomUUID();
        return randomUUID.toString();
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

        String s = "test_9999.txt";
        File f = new File(s);


        if (f.delete()) {
            logger.info("파일 또는 디렉토리를 성공적으로 지웠습니다: " + s);
        } else {
            logger.info("파일 또는 디렉토리 지우기 실패: " + s);
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


    public ResultMap uploadFiles(HttpServletRequest request, RequestMap req) throws Exception {

//        ResultMap res = ResultMap.create();
        if (request instanceof MultipartHttpServletRequest) {

            logger.debug("req={}", req);


//            req.put("filename", uploadFile(request, req));
            return uploadFile(request, req);
        }

        return null;
    }
}
