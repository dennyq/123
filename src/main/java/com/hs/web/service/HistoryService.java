package com.hs.web.service;

import com.hs.ResultMap;
import com.hs.web.Global;
import com.hs.web.PathManager;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.HistoryMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;


@Service
public class HistoryService extends ServiceBase {
  public String fs = File.separator;
  private static final Logger logger = LoggerFactory.getLogger(HistoryService.class);
  @Autowired private HistoryMapper mapper;
  @Autowired private PathManager pathManager;
  @Autowired private FileService fileService;

  //목록
  public ResultMap list(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historylist] recv:{}", req);

    res.putAll(getSplitDate(req, "scantime"));



    res.put("data", mapper.list(req));

    if (Global.isDev) logger.debug("[historylist] send:{}", res);
    return res;
  }


  //상세
  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historydetail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[historydetail] send:{}", res);
    return res;
  }

  //글쓰기
  public ResultMap write(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historywrite] recv:{}", req);


    mapper.insert(req);

    if (Global.isDev) logger.debug("[historywrite] send:{}", res);
    return res;
  }

  //수정
  public ResultMap modify(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historymodify] recv:{}", req);

    if(req.get("joindate") != null && req.get("joindate") != ""){
      String joindate = req.get("joindate")+"";
      joindate = joindate.replace(".","");
      req.put("joindate",joindate);
    }

    if(req.get("outdate") != null && req.get("outdate") != ""){
      String outdate = req.get("outdate")+"";
      outdate = outdate.replace(".","");
      req.put("outdate",outdate);
    }

    if(req.get("usestartdate") != null && req.get("usestartdate") != ""){
      String usestartdate = req.get("usestartdate")+"";
      usestartdate = usestartdate.replace(".","");
      req.put("usestartdate",usestartdate);
    }

    if(req.get("useenddate") != null && req.get("useenddate") != ""){
      String useenddate = req.get("useenddate")+"";
      useenddate = useenddate.replace(".","");
      req.put("useenddate",useenddate);
    }

    mapper.update(req);

    if (Global.isDev) logger.debug("[historymodify] send:{}", res);
    return res;
  }


  //삭제
  public ResultMap delete(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historydelete] recv:{}", req);

    //물리적 파일 삭제.
    String imagefilepath = req.get("imagefilepath") + "";
    String generalimagefile= (String) req.get("generalimagefile");
    String irimagefile= (String) req.get("irimagefile");
    String signimagefile= (String) req.get("signimagefile");

    String signImgUrl = (imagefilepath + signimagefile).replace("/",fs);
    String gImgUrl =  (imagefilepath + generalimagefile).replace("/",fs);
    String irImgUrl = (imagefilepath + irimagefile).replace("/",fs);

    String row_signImgUrl  = pathManager.getAbsolutePathUpload(signImgUrl , true);
    String row_gImgUrl  = pathManager.getAbsolutePathUpload(gImgUrl , true);
    String row_irImgUrl  = pathManager.getAbsolutePathUpload(irImgUrl , true);

    if(row_signImgUrl!=null && !row_signImgUrl.equals("")){
      fileService.deleteFileName(row_signImgUrl);
    }
    if(row_gImgUrl!=null && !row_gImgUrl.equals("")){
      fileService.deleteFileName(row_gImgUrl);
    }
    if(row_irImgUrl!=null && !row_irImgUrl.equals("")){
      fileService.deleteFileName(row_irImgUrl);
    }



    mapper.delete(req);

    if (Global.isDev) logger.debug("[historydelete] send:{}", res);
    return res;
  }

  //비밀번호 변경
  public ResultMap initailizePwd(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[historyinitailizePwd] recv:{}", req);

    mapper.initailizePwd(req);

    if (Global.isDev) logger.debug("[historyinitailizePwd] send:{}", res);
    return res;
  }


  //업로드이미지
  public ResultMap uploadImage(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[uploadImage] recv:{}", req);

    req.put("inputName", "generalimagefile");

    if (request instanceof MultipartHttpServletRequest) {
      fileService.uploadFile(request, req);
//      String before_file_id = mapper.getImgKey(req);
//      req.put("file_id", before_file_id);
//      fileService.deleteFile(req);

      req.put("imagefilepath",req.get("file_path"));
      req.put("generalimagefile",req.get("file_name"));
      req.put("gimagefile_ori",req.get("file_original_name"));
      logger.info("req={}",req);

    }

    req.put("inputName", "irimagefile");

    if (request instanceof MultipartHttpServletRequest) {
      fileService.uploadFile(request, req);
//      String before_file_id = mapper.getImgKey(req);
//      req.put("file_id", before_file_id);
//      fileService.deleteFile(req);
//      req.putAll(fileService.uploadFile(request, req));

      req.put("imagefilepath",req.get("file_path"));
      req.put("irimagefile",req.get("file_name"));
      req.put("irimagefile_ori",req.get("file_original_name"));
      logger.info("req={}",req);

    }

    req.put("inputName", "signimagefile");

    if (request instanceof MultipartHttpServletRequest) {
      fileService.uploadFile(request, req);
//      String before_file_id = mapper.getImgKey(req);
//      req.put("file_id", before_file_id);
//      fileService.deleteFile(req);
//      req.putAll(fileService.uploadFile(request, req));

      req.put("imagefilepath",req.get("file_path"));
      req.put("signimagefile",req.get("file_name"));
      req.put("signimagefile_ori",req.get("file_original_name"));
      logger.info("req={}", req);

    }
    res.putAll(req);
    if (Global.isDev) logger.debug("[uploadImage] send:{}", res);
    return res;
  }

  //업로드파일
  public ResultMap uploadFile(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[uploadFile] recv:{}", req);

    req.put("inputName", "file");

    if(request instanceof MultipartHttpServletRequest) {

      String before_file_id = mapper.getFileKey(req);
      req.put("file_id", before_file_id);
      fileService.deleteFile(req);
      res.put("attach_file_key", fileService.uploadFile(request, req));
    }

    if (Global.isDev) logger.debug("[uploadFile] send:{}", res);

    return res;
  }




}
