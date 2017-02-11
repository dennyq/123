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
    return rootPath + "mapview";
  }

  ///search
  @RequestMapping(value = "search")
  @ResponseBody
  public ResultMap search(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

    return   service.search(req);
  }

}
