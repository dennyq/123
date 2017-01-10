package com.hs.web.service;

import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.MonitorMapper;
import com.hs.web.mapper.NoticeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


@Service
public class MonitorService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(MonitorService.class);
  @Autowired private MonitorMapper mapper;
  @Autowired private FileService fileService;



  // 내부무선센서정보getInnersensorstate
  public ResultMap getInnersensorstate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getInnersensorstate] recv:{}", req);

    res.put("data", mapper.getInnersensorstate(req));

    if (Global.isDev) logger.debug("[monitor getInnersensorstate] send:{}", res);
    return res;
  }


  //  내부유선센서정보getInnercablesensorstate
  public ResultMap getInnercablesensorstate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getInnercablesensorstate] recv:{}", req);

    res.put("data", mapper.getInnercablesensorstate(req));

    if (Global.isDev) logger.debug("[monitor getInnercablesensorstate] send:{}", res);
    return res;
  }

  //  외부유무선센서정보getOutersensorstate
  public ResultMap getOutersensorstate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getOutersensorstate] recv:{}", req);

    res.put("data", mapper.getOutersensorstate(req));

    if (Global.isDev) logger.debug("[monitor getOutersensorstate] send:{}", res);
    return res;
  }





  // 내부무선센서정보getInnersensorstate
  public ResultMap getInnersensorstateChk(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getInnersensorstateChk] recv:{}", req);

    res.put("data", mapper.getInnersensorstateChk(req));

    if (Global.isDev) logger.debug("[monitor getInnersensorstateChk] send:{}", res);
    return res;
  }


  //  내부유선센서정보getInnercablesensorstate
  public ResultMap getInnercablesensorstateChk(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getInnercablesensorstateChk] recv:{}", req);

    res.put("data", mapper.getInnercablesensorstateChk(req));

    if (Global.isDev) logger.debug("[monitor getInnercablesensorstateChk] send:{}", res);
    return res;
  }

  //  외부유무선센서정보getOutersensorstate
  public ResultMap getOutersensorstateChk(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getOutersensorstateChk] recv:{}", req);

    res.put("data", mapper.getOutersensorstateChk(req));

    if (Global.isDev) logger.debug("[monitor getOutersensorstateChk] send:{}", res);
    return res;
  }


  //  초기설정getInitsetting
  public ResultMap getInitsetting(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getInitsetting] recv:{}", req);

    res.put("data", mapper.getInitsetting(req));

    if (Global.isDev) logger.debug("[monitor getInitsetting] send:{}", res);
    return res;
  }

  //  양액정보getNutrientstate
  public ResultMap getNutrientstate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getNutrientstate] recv:{}", req);

    res.put("data", mapper.getNutrientstate(req));

    if (Global.isDev) logger.debug("[monitor getNutrientstate] send:{}", res);
    return res;
  }

  //  열회수형환풍기상태정보getHeatrecoverystate
  public ResultMap getHeatrecoverystate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getHeatrecoverystate] recv:{}", req);

    res.put("data", mapper.getHeatrecoverystate(req));

    if (Global.isDev) logger.debug("[monitor getHeatrecoverystate] send:{}", res);
    return res;
  }

  //  //열회수형환풍기상태정보
  public ResultMap getAirfanstate(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[monitor getAirfanstate] recv:{}", req);

    res.put("data", mapper.getAirfanstate(req));

    if (Global.isDev) logger.debug("[monitor getAirfanstate] send:{}", res);
    return res;
  }




  public DbMap getMemberIp(RequestMap req) {


    return mapper.getMemberIp(req);
  }



}
