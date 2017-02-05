package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;

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
@RequestMapping(value = "/pc/")
public class PCController extends ControllerPageBase {
  @Autowired
  private PCService service;
  private static final Logger logger = LoggerFactory.getLogger(PCController.class);
  private String rootKey = "pc";
  private String rootPath = "pages/" + rootKey + "/";

  //목록
  @RequestMapping(value = "list/{page}")
  public String listPage(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    getListModel(model, req);
    return rootPath + "list";
  }
  //목록
  @RequestMapping(value = "list")
  public String list(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    getListModel(model, req);
    return rootPath + "list";
  }
  //목록
  @RequestMapping(value = "listSearchRegion")
  public String listSearchRegion(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    getListModel(model, req);
    return rootPath + "listSearchRegion";
  }

  //목록
  @RequestMapping(value = "search")
  public String search(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    getListModel(model, req);
    return rootPath + "list";
  }

  private void getListModel(Model model, RequestMap req) {
    model.addAttribute("tab",(req.get("tab")==null)?"2":req.get("tab")+"");
    model.addAllAttributes(service.list(req));
    req.put("searchCode","1");
    model.addAttribute("codeList", service.getCodeList(req).get("rows"));
  }

  //상세
  @RequestMapping(value = "info")
  public String info(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);

    if (req.get("login_uid") == null) {
      throw new BizException("9009", "need_login");
    }


    return "redirect:/" + rootKey + "/info/" + req.get("login_uid");

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
  @RequestMapping(value = "detail")
  public String details(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);


    model.addAttribute("data",req);
    return rootPath + "detail";
  }

  //상세
  @RequestMapping(value = "detail/{memberid}")
  public String detailById(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    return rootPath + "detail";
  }

  //상세
  @RequestMapping(value = "changePwdPage")
  public String changePwdPage(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    model.addAttribute("changePwd","Y");
    return rootPath + "detail";
  }

  //상세
  @RequestMapping(value = "changePwdPage/{memberid}")
  public String changePwdPageById(HttpServletRequest request, Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    model.addAllAttributes(service.detail(req));
    model.addAttribute("changePwd","Y");
    return rootPath + "detail";
  }


  //쓰기
  //수정
  @RequestMapping(value = "changePwd")
  @ResponseBody
  public ResultMap changePwd(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.changePwd(req);
  }


  //쓰기
  @RequestMapping(value = "save")
  public String save(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

    service.save(req);

    return "redirect:/" + rootKey + "/list";
  }

  //쓰기
  @RequestMapping(value = "saveInfo")
  public String saveInfo(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

    service.save(req);

    return "redirect:/" + rootKey + "/info/"+req.get("memberid");
  }

  //코드/pc/search/ajax
  @RequestMapping(value = "searchCodeList")
  @ResponseBody
  public ResultMap searchCodeList(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();
    int searchCode = Integer.parseInt(req.get("searchCode") + "");
    DbMap resultMap = service.getCodeList(req);
    res.put("codeList", resultMap.get("rows"));
    if (searchCode == 3) {
      res.put("codeListRo", resultMap.get("rowsRo"));
    }

    return res;
  }


  ///searchByAddr
  @RequestMapping(value = "searchByAddr")
  @ResponseBody
  public ResultMap searchByAddr(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

    return  service.searchMember(req);
  }

  //수정
  @RequestMapping(value = "modify")
  @ResponseBody
  public ResultMap modify(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.modify(req);
  }

  //세션바꾸기
  @RequestMapping(value = "change/{change_uid}")
//  @ResponseBody
  public String change(HttpServletRequest request,HttpSession session) throws Exception {
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);
    String change_uid = req.get("change_uid")+"";
    req.put("login_uid",change_uid);
    session.setAttribute("login_uid",change_uid);



//    ResultMap res = ResultMap.create();



    return rootPath + "list";
  }

  //삭제
  @RequestMapping(value = "delete")
  @ResponseBody
  public ResultMap delete(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.delete(req);
  }

  //비밀번호 변경
  @RequestMapping(value = "initailizePwd")
  @ResponseBody
  public ResultMap initailizePwd(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.initailizePwd(req);
  }

  //아이디체크
  @RequestMapping(value = "idCheck")
  @ResponseBody
  public ResultMap idCheck(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    return service.idCheck(req);
  }

}
