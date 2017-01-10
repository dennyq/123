package com.hs.web.service;

import com.hs.ResultMap;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.MachineMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


@Service
public class MachineService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(MachineService.class);
  @Autowired private MachineMapper mapper;
  @Autowired private FileService fileService;


  //목록
  public ResultMap list(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main list] recv:{}", req);
    res.putAll(getSplitDate(req, "joindate"));
    res.putAll(getSplitDate(req,"outdate"));
    res.putAll(getSplitDate(req,"usestartdate"));
    res.putAll(getSplitDate(req,"useenddate"));

//    if(req.get("joindate") != null && req.get("joindate") != ""){
//      String joindate = req.get("joindate")+"";
//      if(joindate.trim().equals("-") && joindate.trim().equals("+-+") ){
//        req.remove("joindate");
//      }else{
//        String[] joindateArr = joindate.split(" - ");
//        String joindate_low = joindateArr[0].replace(".","");
//        String joindate_high = joindateArr[1].replace(".","");
//        req.put("joindate_low", joindate_low);
//       req.put("joindate_high",joindate_high);
//      }
//
//    }
//    if(req.get("outdate") != null && req.get("outdate") != ""){
//      String outdate = req.get("outdate")+"";
//      if(outdate.trim().equals("-") && outdate.trim().equals("+-+") ){
//        req.remove("outdate");
//      }else{
//        String[] outdateArr = outdate.split(" - ");
//        String outdate_low = outdateArr[0].replace(".","");
//        String outdate_high = outdateArr[1].replace(".","");
//        req.put("outdate_low",outdate_low);
//        req.put("outdate_high",outdate_high);
//      }
//    }
//    if(req.get("usestartdate") != null && req.get("usestartdate") != ""){
//      String usestartdate = req.get("usestartdate")+"";
//      if(usestartdate.trim().equals("-") && usestartdate.trim().equals("+-+") ){
//        req.remove("usestartdate");
//      }else{
//        String[] usestartdateArr = usestartdate.split(" - ");
//        String usestartdate_low = usestartdateArr[0].replace(".", "");
//        String usestartdate_high = usestartdateArr[1].replace(".", "");
//        req.put("usestartdate_low", usestartdate_low);
//        req.put("usestartdate_high", usestartdate_high);
//      }
//    }
//    if(req.get("useenddate") != null && req.get("useenddate") != ""){
//      String useenddate = req.get("useenddate")+"";
//      if(useenddate.trim().equals("-") && useenddate.trim().equals("+-+") ){
//        req.remove("useenddate");
//      }else{
//        String[] useenddateArr = useenddate.split(" - ");
//        String useenddate_low = useenddateArr[0].replace(".", "");
//        String useenddate_high = useenddateArr[1].replace(".", "");
//        req.put("useenddate_low", useenddate_low);
//        req.put("useenddate_high", useenddate_high);
//      }
//    }

    res.put("data", mapper.list(req));

    if (Global.isDev) logger.debug("[main list] send:{}", res);
    return res;
  }


  //상세
  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main detail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[main detail] send:{}", res);
    return res;
  }

  //글쓰기
  public ResultMap write(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main write] recv:{}", req);

    mapper.insert(req);

    if (Global.isDev) logger.debug("[main write] send:{}", res);
    return res;
  }

  //수정
  public ResultMap modify(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main modify] recv:{}", req);

    if(req.get("joindate") != null && req.get("joindate") != "" ){
      String joindate = req.get("joindate")+"";
      joindate = joindate.replace(".","");
      req.put("joindate",joindate);
    }

    if(req.get("outdate") != null && req.get("outdate") != "" ){
      String outdate = req.get("outdate")+"";
      outdate = outdate.replace(".","");
      req.put("outdate",outdate);
    }

    if(req.get("usestartdate") != null && req.get("usestartdate") != "" ){
      String usestartdate = req.get("usestartdate")+"";
      usestartdate = usestartdate.replace(".","");
      req.put("usestartdate",usestartdate);
    }

    if(req.get("useenddate") != null && req.get("useenddate") != "" ){
      String useenddate = req.get("useenddate")+"";
      useenddate = useenddate.replace(".","");
      req.put("useenddate",useenddate);
    }

    mapper.update(req);




    if (Global.isDev) logger.debug("[main modify] send:{}", res);
    return res;
  }


  //삭제
  public ResultMap delete(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main delete] recv:{}", req);

    mapper.delete(req);

    if (Global.isDev) logger.debug("[main delete] send:{}", res);
    return res;
  }

  //비밀번호 변경
  public ResultMap initailizePwd(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main initailizePwd] recv:{}", req);

    mapper.initailizePwd(req);

    if (Global.isDev) logger.debug("[main initailizePwd] send:{}", res);
    return res;
  }


  //업로드이미지
  public ResultMap uploadImage(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[uploadImage] recv:{}", req);

    req.put("inputName", "file");

    if (request instanceof MultipartHttpServletRequest) {

      String before_file_id = mapper.getImgKey(req);
      req.put("file_id", before_file_id);
      fileService.deleteFile(req);
      res.put("image_file_key", fileService.uploadFile(request, req));

    }

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
