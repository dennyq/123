package com.hs.web.controller;


import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.DailyService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping(value = "/daily/")
public class DailyController extends ControllerPageBase {
  @Autowired
  private DailyService service;
  private static final Logger logger = LoggerFactory.getLogger(DailyController.class);
  private String rootKey = "daily";
  private String rootPath = "pages/" + rootKey + "/";


  //목록
  @RequestMapping(value = "")
  public String daily(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);

    Date now = new Date();

    SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
    String sch_daydate = format.format(now);

    //초기화
    if (req.get("sch_daydate") == null) {
      req.put("sch_daydate", sch_daydate);
    }


    model.addAllAttributes(service.detail(req));
    return rootPath + "daily";
  }

  //목록
  @RequestMapping(value = "list/{page}")
  public String listPage(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.list(req));
    return rootPath + "list";
  }

  //목록
  @RequestMapping(value = "list")
  public String list(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    model.addAllAttributes(service.list(req));
    return rootPath + "list";
  }

  //목록
  @RequestMapping(value = "search")
  public String search(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    model.addAllAttributes(service.detail(req));
    return rootPath + "daily";
//    return rootPath + "list";
  }

  //목록
  @RequestMapping(value = "search/{sch_daydate}")
  public String searchDate(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    return rootPath + "daily";
//    return rootPath + "list";
  }



  //상세
  @RequestMapping(value = "info/{memberid}")
  public String infoById(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    return rootPath + "info";
  }

  //상세
  @RequestMapping(value = "detail/{memberid}")
  public String detail(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    return rootPath + "detail";
  }

  //쓰기페이지
  @RequestMapping(value = "detail")
  public String input(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    return rootPath + "detail";
  }


  //쓰기
  @RequestMapping(value = "save")
  @ResponseBody
  public ResultMap save(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);



    return service.save(req);

  }

  //쓰기
  @RequestMapping(value = "saveInfo")
  public String saveInfo(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

//		req.put("uploadDir", rootKey);
//		req.putAll(service.uploadImage(request));
    service.save(req);

    return "redirect:/" + rootKey + "/info/"+req.get("memberid");
  }

  //수정
  @RequestMapping(value = "modify")
  @ResponseBody
  public ResultMap modify(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.modify(req);
  }

  //삭제
  @RequestMapping(value = "delete")
  @ResponseBody
  public ResultMap delete(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.delete(req);
  }

}
