package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.MemberMapper;
import com.hs.web.mapper.PCMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


@Service
public class PCService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(PCService.class);
  @Autowired private PCMapper mapper;



  //목록
  public ResultMap list(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main list] recv:{}", req);
    req.put("rows", "10");
    setPaging(req);
    if (Global.isDev) logger.debug("[list] recv:{}", req);

    DbList list = mapper.list(req);
    int total = mapper.listCnt(req);

    res.put("total", total);
    res.put("rows", list);
    res.put("sch_memberid", req.get("sch_memberid"));
    res.put("sch_joindate", req.get("sch_joindate"));
    res.put("sch_name", req.get("sch_name"));
    res.put("sch_usestartdate", req.get("sch_usestartdate"));
    res.put("sch_useenddate", req.get("sch_useenddate"));
    res.put("sch_handphone", req.get("sch_handphone"));

    res.put("pageTimes", (Integer.parseInt(req.get("page")+"")-1)*Integer.parseInt(req.get("rows")+""));

    res.put("paging", PageUtil.getPaging(req, total));

    if (Global.isDev) logger.debug("[main list] send:{}", res);
    return res;
  }

  //코드목록
  public ResultMap getCodeList(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[getCodeList list] recv:{}", req);

    DbList list = mapper.codeList(req);
    res.put("rows", list);

    if (Global.isDev) logger.debug("[getCodeList list] send:{}", res);
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

  //저장
  public ResultMap save(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main save] recv:{}", req);
    String joindate =  req.get("joindate")+"";
    String usestartdate =  req.get("usestartdate")+"";
    String useenddate =  req.get("useenddate")+"";
    String longitude =  req.get("longitude")+"";
    String latitude =  req.get("latitude")+"";
    longitude = longitude.equals("")?"0":longitude;
    latitude = latitude.equals("")?"0":latitude;
    double longitudeDouble =  Double.parseDouble(longitude);
    double latitudeDouble =  Double.parseDouble(latitude);
    req.put("longitude",longitudeDouble);
    req.put("latitude",latitudeDouble);


    req.put("joindate",joindate.replace(".",""));
    req.put("usestartdate",usestartdate.replace(".",""));
    req.put("useenddate",useenddate.replace(".",""));

    int idPwCheckCnt = mapper.idPwCheck(req);

    if(req.get("isNew").equals("Y")){
      if(req.get("memberid").equals("admin")){
        req.put("grade","1");
      }else {
        req.put("grade","2");
      }

      if (idPwCheckCnt != 0) {
        throw new BizException("9009","id_exist");
      }

      int idPwDelChk = mapper.idPwDelChk(req);
      logger.info("idPwDelChk={}",idPwDelChk);

      if(idPwDelChk==1){
        //삭제했으니 delyn 원복
        mapper.restore(req);
        mapper.update(req);
      }else{
        mapper.insert(req);
      }

    }else{



      mapper.update(req);
    }



    if (Global.isDev) logger.debug("[main save] send:{}", res);
    return res;
  }
  //저장
  public ResultMap changePwd(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[member changePwd] recv:{}", req);

    int idPwCheckCnt = mapper.idPwCheck(req);
    if(idPwCheckCnt==1){
      mapper.changePwd(req);

    }else {
      res.put("result_message","fail");
    }


    if (Global.isDev) logger.debug("[member changePwd] send:{}", res);
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
      req.put("useenddate", useenddate);
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



  //아이디체크
  public ResultMap idCheck(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main idCheck] recv:{}", req);

    int cnt = mapper.idCheck(req);

    if(cnt > 0){
      res.put("result_message", "fail");
    }

    if (Global.isDev) logger.debug("[main idCheck] send:{}", res);
    return res;
  }
}
