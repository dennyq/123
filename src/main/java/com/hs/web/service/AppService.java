package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.AppMapper;
import com.hs.web.mapper.PCMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;


@Service
public class AppService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(AppService.class);
  @Autowired private AppMapper mapper;


  public ResultMap search(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app search] recv:{}", req);

     DbList list = mapper.search(req);
     DbList playList = mapper.playList(req);

    res.put("rows", list);

    if (Global.isDev) logger.debug("[app search] send:{}", res);
    return res;
  }


  public ResultMap playOne(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app playOne] recv:{}", req);

     DbMap map = mapper.playOne(req);

    res.put("data", map);

    if (Global.isDev) logger.debug("[app playOne] send:{}", res);
    return res;
  }


  public ResultMap playList(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app playList] recv:{}", req);

     DbList list = mapper.playList(req);

    res.put("rows", list);

    if (Global.isDev) logger.debug("[app playList] send:{}", res);
    return res;
  }

  public ResultMap getPlayList(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app getPlayList] recv:{}", req);

     DbList list = mapper.playList(req);

    res.put("list", list);

    if (Global.isDev) logger.debug("[app getPlayList] send:{}", res);
    return res;
  }


  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app detail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[app detail] send:{}", res);
    return res;
  }


}
