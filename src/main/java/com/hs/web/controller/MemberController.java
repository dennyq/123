package com.hs.web.controller;

import com.hs.BizException;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.ExcelFileService;
import com.hs.web.service.FileService;
import com.hs.web.service.MemberService;
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
import javax.servlet.http.HttpSession;

// 머신
@Controller
@RequestMapping(value = "/member/")
public class MemberController extends ControllerPageBase {
    @Autowired
    private MemberService service;
    @Autowired
    private ExcelFileService excelFileService;
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
    private String rootKey = "member";
    private String rootPath = "pages/" + rootKey + "/";

    //목록
    @RequestMapping(value = "list/{page}")
    public String listPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }

    //목록
    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }


    //일괄등록팝업
    @RequestMapping(value = "popup")
    public String popup(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        return rootPath + "popup";
    }

    //todo : excelUpload
    @RequestMapping(value = "excelUpload")
    public String excelUpload(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;

        MultipartFile file = mrequest.getFile("excelfile");
        req.put("inputName","excelfile");

        if(file.getSize() > 0) {

            model.addAllAttributes(excelFileService.uploadFiles(request, req));
        }


        return rootPath + "popupSave";
    }

    //todo : excelSave
    @RequestMapping(value = "excelSave")
    @ResponseBody
    public ResultMap excelSave(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);



        return service.excelSave(req);
    }


    //목록
    @RequestMapping(value = "search")
    public String search(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }


    //상세
    @RequestMapping(value = "info")
    public String info(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
//    putPathVariable(request, req);
//    model.addAllAttributes(service.detail(req));
        if (req.get("login_uid") == null) {
            throw new BizException("9009", "need_login");
        }
//      return redirect:rootPath + "info"+;

        return "redirect:/" + rootKey + "/info/" + req.get("login_uid");
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

    //상세
    @RequestMapping(value = "changePwdPage")
    public String changePwdPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("changePwd", "Y");
        return rootPath + "detail";
    }

    //상세
    @RequestMapping(value = "changePwdPage/{memberid}")
    public String changePwdPageById(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("changePwd", "Y");
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

        service.save(req);

        return "redirect:/" + rootKey + "/list";
    }

    //쓰기
    @RequestMapping(value = "saveInfo")
    public String saveInfo(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        service.save(req);

        return "redirect:/" + rootKey + "/info/" + req.get("memberid");
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
    public String change(HttpServletRequest request, HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        String change_uid = req.get("change_uid") + "";
        req.put("login_uid", change_uid);
        session.setAttribute("login_uid", change_uid);


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
