package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.AppService;
import com.hs.web.service.PCService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping(value = "/app/")
public class AppController extends ControllerPageBase {
  @Autowired
  private AppService service;
  private static final Logger logger = LoggerFactory.getLogger(AppController.class);
  private String rootKey = "app";
  private String rootPath = "pages/" + rootKey + "/";



  //안드로이드맵뷰
  @RequestMapping(value = "mapview")
  public String mapview(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
//    model.addAttribute("playOne",service.playOne(req).get("data"));
    return rootPath + "mapview";
  }

  //안드로이드맵뷰
  @RequestMapping(value = "locationSelectmapview")
  public String locationSelectmapview(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);


    getListModel(model, req);
    return rootPath + "locationSelectmapview";
  }

  ///search
  @RequestMapping(value = "search")
  @ResponseBody
  public ResultMap search(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.search(req);
  }

  ///playList
  @RequestMapping(value = "playList")
  @ResponseBody
  public ResultMap playList(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.playList(req);
  }

  ///playList
  @RequestMapping(value = "getPlayList")
  @ResponseBody
  public ResultMap getPlayList(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.getPlayList(req);
  }


  //상세
  @RequestMapping(value = "detail/{memberid}")
  public String detailById(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    return rootPath + "detail";
  }

    private void getListModel(Model model, RequestMap req) {
        model.addAllAttributes(service.list(req));
        String gubun = (String) req.get("gubun");
        String putGubun = null;
        if (gubun.equals("2")) {//약국-1
            putGubun = "1";
        } else if (gubun.equals("3")) {//병원-2
            putGubun = "2";
        } else {
            putGubun = "0";
        }
        req.put("gubun", putGubun);
        req.put("searchCode", "1");
        model.addAttribute("codeList", service.getCodeList(req).get("rows"));
        model.addAttribute("gubun", putGubun==null?"1":putGubun);
    }

}
