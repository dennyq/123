package com.hs.web.service;

import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.AppMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AppService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(AppService.class);
  @Autowired private AppMapper mapper;


  public ResultMap search(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app search] recv:{}", req);

     DbList list = mapper.search(req);
//     DbList playList = mapper.playList(req);

    res.put("rows", list);

    list = null;

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

     DbList list = mapper.getPlayList(req);

    res.put("list", list);

    if (Global.isDev) logger.debug("[app getPlayList] send:{}", res);
    return res;
  }

  public ResultMap mapviewinfo(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app mapviewinfo] recv:{}", req);

     DbList list = mapper.mapviewinfo(req);

    res.put("list", list);

    list = null;

    if (Global.isDev) logger.debug("[app mapviewinfo] send:{}", res);
    return res;
  }


  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[app detail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[app detail] send:{}", res);
    return res;
  }


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
    int searchCode = Integer.parseInt(req.get("searchCode") + "");
    DbList list = null;
    DbList listRo = null;
    switch (searchCode){
      case 1:
        list = mapper.codeListBig(req);break;
      case 2:
        list = mapper.codeListMid(req);break;
      case 3:
        list = mapper.codeListDong(req);
        listRo = mapper.codeListRo(req);
        res.put("rowsRo", listRo);
        break;
      default:
        list = mapper.codeListBig(req);
    }
//    DbList list = mapper.codeList(req);
    res.put("rows", list);

    if (Global.isDev) logger.debug("[getCodeList list] send:{}", res);
    return res;
  }


}
