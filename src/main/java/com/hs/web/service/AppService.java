package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
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
    if (Global.isDev) logger.debug("[main search] recv:{}", req);

     DbList list = mapper.search(req);
    res.put("rows", list);


    if (Global.isDev) logger.debug("[main search] send:{}", res);
    return res;
  }


  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main detail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[main detail] send:{}", res);
    return res;
  }


}
