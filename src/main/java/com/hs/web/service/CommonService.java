package com.hs.web.service;


import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.CommonMapper;
import com.hs.DbList;
import com.hs.ResultMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class CommonService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(CommonService.class);
  @Autowired private CommonMapper mapper;




  public ResultMap code(RequestMap req) throws Exception {
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[common code] req:{}", req);

    DbList codeList = mapper.list(req);

    res.put("codeList",codeList);

    if (Global.isDev) logger.debug("[common code] send:{}", res);

    return res;
  }
  

}
