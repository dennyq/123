package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.CctvService;
import com.hs.web.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

// 머신
@Controller
@RequestMapping(value = "/cctv/")
public class CctvController extends ControllerPageBase {
  @Autowired
  private CctvService service;
  private MemberService memberService;
  private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
  private String rootKey = "cctv";
  private String rootPath = "pages/" + rootKey + "/";

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


    if (req.get("login_uid").equals("admin")) {
      model.addAttribute("loginip", "183.101.130.211");
      model.addAttribute("port", "90");
      model.addAttribute("username", "admin");
      model.addAttribute("password", "nano953102");

    } else {//90:admin:nano953102
      req.put("memberid",req.get("login_uid"));
      DbMap info = (DbMap) service.detail(req).get("data");
      model.addAttribute("loginip",info.get("ipaddress"));

//      for(int i=1;i<9;i++){
//        String camerainfo = info.get("camerainfo"+i)+"";
//        String
//      }
      String camerainfo1 = (String) info.get("camerainfo1");
      if(camerainfo1==null){
//        throw new BizException("9009","no_data");
        model.addAttribute("result","no_data");
      }else  if(camerainfo1.equals("")){
        model.addAttribute("result","no_data");
      }else{
        String camerainfo1Arr[] = camerainfo1.split(":");

        model.addAttribute("port",camerainfo1Arr[0]);
        model.addAttribute("username",camerainfo1Arr[1]);
        model.addAttribute("password",camerainfo1Arr[2]);
      }

    }

//    model.addAllAttributes(service.list(req));
    return rootPath + "list";
  }

  //목록
  @RequestMapping(value = "search")
  public String search(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
    model.addAllAttributes(service.list(req));
    return rootPath + "list";
  }


  //상세
  @RequestMapping(value = "info")
  public String info(HttpServletRequest request, Model model) throws Exception {
//    RequestMap req = RequestMap.create(request);
//    putPathVariable(request, req);
//    model.addAllAttributes(service.detail(req));
    throw new BizException("9009","need_login");
//    return rootPath + "info";
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
  @RequestMapping(value = "write")
  public String write(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

    req.put("uploadDir", rootKey);
    req.putAll(service.uploadImage(request));
    service.write(req);

    return "redirect:/" + rootKey + "/list";
  }

  //쓰기
  @RequestMapping(value = "save")
  public String save(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);

//		req.put("uploadDir", rootKey);
//		req.putAll(service.uploadImage(request));
    service.save(req);

    return "redirect:/" + rootKey + "/list";
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
