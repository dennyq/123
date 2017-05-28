package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.FileService;
import com.hs.web.service.NoticeService;
import com.hs.web.service.SpecialMembershipService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;

// 전문가
@Controller
@RequestMapping(value = "/notice")
public class NoticeController extends ControllerPageBase {
    @Autowired
    private NoticeService service;
    @Autowired
    private FileService fileService;

    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
    private String rootKey = "notice";
    private String rootPath = "pages/" + rootKey + "/";


    //첫화면
    @RequestMapping(value = "/")
    public String index(HttpServletRequest request) throws Exception {

        return "redirect:/notice/list";

    }


    //목록
    @RequestMapping(value = "list/{page}")
    public String listPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.list(req));
        String Path = request.getContextPath();
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "list";
    }

    //목록
    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        model.addAttribute("thisPath","/"+rootKey);
        logger.debug("thisPath={}","/"+rootKey);
        return rootPath + "list";
    }

    //목록
    @RequestMapping(value = "search")
    public String search(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "list";
    }


    //쓰기페이지
    @RequestMapping(value = "detail")
    public String input(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }

    //상세
    @RequestMapping(value = "detail/{noticeindex}")
    public String detail(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }


    //changePwdPage
    @RequestMapping({"changePwdPage", "changePwdPage/{noticeindex}"})
    public String changePwdPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("changePwd", "Y");
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }


    //비밀번호수정
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

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;

        MultipartFile file = mrequest.getFile("notice_filename");
        req.put("inputName","notice_filename");

        if (file.getSize() > 0) {
            fileService.uploadFiles(request, req);
        } else {
            req.put("notice_filename", null);
        }

        service.save(req);

        return "redirect:/" + rootKey + "/list";
    }



    //일괄등록팝업
    @RequestMapping(value = "popup")
    public String popup(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("thisPath",rootKey);
        return rootPath + "popup";
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
