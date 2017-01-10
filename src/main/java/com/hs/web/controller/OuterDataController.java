package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.DataService;
import com.hs.web.service.OuterDataService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/outerData/")
public class OuterDataController extends ControllerPageBase {
  @Autowired
  private OuterDataService service;
  private static final Logger logger = LoggerFactory.getLogger(OuterDataController.class);
  private String rootKey = "outerdata";
  private String rootPath = "pages/" + rootKey + "/";

  //graph
  @RequestMapping(value = "graph")
  public String graph(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);

//    model.addAttribute("grpPath",service.graph(req).get("grpPath"));
    model.addAttribute("grpPath", service.graph(req).get("grpPath"));
    model.addAttribute("today", service.graph(req).get("today"));
    model.addAttribute("sch_date", service.graph(req).get("sch_date"));
    return rootPath + "graph";
  }


  //graphSearch
  @RequestMapping(value = "graphSearch")
  public String graphSearch(HttpServletRequest request,Model model) throws Exception {
    RequestMap req = RequestMap.create(request);
//    model.addAttribute("grpPath",service.graph(req).get("grpPath"));
    model.addAttribute("grpPath", service.graph(req).get("grpPath"));
    model.addAttribute("today", service.graph(req).get("today"));
    model.addAttribute("sch_date", service.graph(req).get("sch_date"));
    return rootPath + "graph";
  }

  //엑셀파일 변환 및 다운로드
  @RequestMapping("/excel_transform_controller")
  public String excelTransform(HttpServletRequest request,Model model) throws Exception{
    RequestMap req = RequestMap.create(request);
    DbList excelList = (DbList) service.list(req).get("rows");

    model.addAttribute("type", "outdata");
    model.addAttribute("title", "외부센서데이터");
    model.addAttribute("excelList", excelList);

    return "excelView";
  }


  //엑셀파일 변환 및 다운로드 ,method = RequestMethod.POST
  @RequestMapping(value = "/excel_transform_controller/{idx}")
  public String excelTransformIdx(HttpServletRequest request,Model model) throws Exception{
    RequestMap req = RequestMap.create(request);
    putPathVariable(request, req);

    if(!(req.get("searchFrm")+"").equalsIgnoreCase("Y")){
      throw new BizException("9009","정상적인 경로로 다시 다운해주세요.","/");
    }
    DbList excelList = (DbList) service.list(req).get("rows");

    model.addAttribute("excelList", excelList);
    model.addAttribute("idx", req.get("idx"));

    return "excelView";
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
