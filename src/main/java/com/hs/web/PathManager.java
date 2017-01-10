package com.hs.web;


import com.hs.util.DateUtil;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

@Component
public class PathManager {
  private static final Logger logger = LoggerFactory.getLogger(PathManager.class);
  private String _uploadPath;
  public String fs = File.separator;

  private String uploadPath() {
    if (_uploadPath == null) {
      _uploadPath = Global.UPLOAD_PATH;
    }

    return _uploadPath;
  }

  public static File getTempFile() throws IOException {
    String tempPath = Global.UPLOAD_PATH + "/temp";
    File tempPathFile = new File(tempPath);
    if (!tempPathFile.exists()) tempPathFile.mkdirs();
    File tempFile = File.createTempFile("temp", ".tmp", tempPathFile);
    return tempFile;
  }

    public File getGrpFile(HashMap<String, Object> map) throws IOException {
        String MMBR_ID = map.get("login_uid") + "";
        String ANAL_IDX = map.get("login_memberid") + "";
        String date = DateUtil.getCurrent();
        String tempPath = uploadPath() + fs + "grp" + fs + date + fs + MMBR_ID + fs + ANAL_IDX;
        File tempPathFile = new File(tempPath);
        if(!tempPathFile.exists()) tempPathFile.mkdirs();
        File tempFile = File.createTempFile("graph", ".png", tempPathFile);
        return tempFile;
    }

  public static File getPageFile(String memberid, String now, String fileName) {

    String year = now.substring(0, 4);
    String month = now.substring(4, 6);
    String date = now.substring(6, 8);


    String pagePath = Global.UPLOAD_PATH + "/" + year + "/" + month + "/" + date + "/" + memberid ;

    File pagePathFile = new File(pagePath);
    if (!pagePathFile.exists()) pagePathFile.mkdirs();

    String pageFileName = pagePath + "/" + fileName;
    File pageFile = new File(pageFileName);

    return pageFile;
  }


  public static File getPageFile(String now, String fileName) {

    String year = now.substring(0, 4);
    String month = now.substring(4, 6);
    String date = now.substring(6, 8);


    String pagePath = Global.UPLOAD_PATH + "/" + year + "/" + month + "/" + date ;

    File pagePathFile = new File(pagePath);
    if (!pagePathFile.exists()) pagePathFile.mkdirs();

    String pageFileName = pagePath + "/" + fileName;
    File pageFile = new File(pageFileName);

    return pageFile;
  }

  public String getRelativePath(String path) {
    if(path.startsWith(uploadPath())) {
      return path.substring(uploadPath().length());
    }
    else {
      return path;
    }
  }

  public String getRelativePath(String path, boolean containUpload) {
    if(!containUpload) {
      return getRelativePath(path);
    }
    if(path.startsWith(uploadPath())) {
      return fs+"upload"+fs+ path.substring(uploadPath().length());
    }
    else {
      return fs+"upload"+fs+ path;
    }
  }

  public String getRelativePath(String path, boolean containUpload,String duplicateStr) {
    if(!containUpload) {
      return getRelativePath(path);
    }
    if(path.startsWith(uploadPath()+duplicateStr)) {
      return fs+"upload"+fs+duplicateStr + path.substring(uploadPath().length());
    }
    else {
      return fs+"upload"+fs+duplicateStr + path;
    }
  }

  public static String getAbsolutePath(String path) {
    return Global.UPLOAD_PATH + path;
  }

  public static String getAbsolutePathUpload(String path,boolean containUpload) {
    if(!containUpload) {
      return Global.UPLOAD_PATH + path;
    }else{
      logger.info("UPLOAD_PATH={}",Global.UPLOAD_PATH + path.substring("/upload".length(),path.length()));
      return Global.UPLOAD_PATH + path.substring("/upload".length(),path.length());
    }

  }

  public File getTempPdfFile() throws IOException {
    String date = DateUtil.getCurrent();
    String tempPath = uploadPath() + fs + "temp" + fs + date;
    File tempPathFile = new File(tempPath);
    if (!tempPathFile.exists()) tempPathFile.mkdirs();
    File tempFile = File.createTempFile("pdf_", ".pdf", tempPathFile);

    // 어제꺼 지운다.
//		deleteTempFiles();
    return tempFile;
  }

  public File getTempPdfFile(String fn) throws IOException {
    String date = DateUtil.getCurrent();
    String tempPath = uploadPath() + fs + "temp" + fs + date + fs + fn;
    File tempPathFile = new File(tempPath);
    return tempPathFile;
  }

//  public File getGrpFile(HashMap<String, Object> map) throws IOException {
//    String member_no = map.get("member_no") + "";
//    String apply_seq = map.get("apply_seq") + "";
//    String folderPath = map.get("folderPath")+"";
//    String date = DateUtil.getCurrent();
//    String tempPath = uploadPath() + fs + folderPath + fs + "grp" + fs + date + fs + member_no + fs + apply_seq;
//    File tempPathFile = new File(tempPath);
//    if(!tempPathFile.exists()) tempPathFile.mkdirs();
//    File tempFile = File.createTempFile("graph", ".png", tempPathFile);
//    return tempFile;
//  }


  /**
   * 전날 grp파일을 모두 지운다.
   */
  public void deleteGrpFiles() {
    String date = DateUtil.getAddDays("yyyyMMdd", -1);
    String tempPath = uploadPath() + fs + "grp" + fs + date ;
    File f = new File(tempPath);
    if(f.exists()) FileUtils.deleteQuietly(f);
  }


  /**
   * 전날 evaluation grp파일을 모두 지운다.
   */
  public void deleteGrpFiles(String folderNAme) {
    String date = DateUtil.getAddDays("yyyyMMdd", -1);
    String tempPath = uploadPath() + fs + folderNAme +fs  + "grp" + fs + date ;
    File f = new File(tempPath);
    if(f.exists()) FileUtils.deleteQuietly(f);
  }
  }
