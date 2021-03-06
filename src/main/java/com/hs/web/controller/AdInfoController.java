package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.AdInfoService;
import com.hs.web.service.FileService;
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

/**
 * 광고관리
 */
@Controller
@RequestMapping(value = "/adinfo/")
public class AdInfoController extends ControllerPageBase {
    @Autowired
    private AdInfoService service;
    @Autowired
    private FileService fileService;
    private static final Logger logger = LoggerFactory.getLogger(AdInfoController.class);
    private String rootKey = "adinfo";
    private String rootPath = "pages/" + rootKey + "/";

    /**
     * 페이지 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "list/{page}")
    public String listPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }

    /**
     * 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }

    /**
     * 검색
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "search")
    public String search(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        return rootPath + "list";
    }

    /**
     * 팝업
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "popup/{adindex}")
    public String infoById(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        return rootPath + "popup";
    }

    /**
     * 상세페이지
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail/{adindex}")
    public String detail(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        return rootPath + "detail";
    }


    /**
     * 쓰기페이지
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail")
    public String input(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        return rootPath + "detail";
    }

    /**
     * 쓰기
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "write")
    public String write(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        req.put("uploadDir", rootKey);
        req.putAll(service.uploadImage(request));
        service.write(req);

        return "redirect:/" + rootKey + "/list";
    }

    /**
     * 글저장(신규/업데이트)
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    public String save(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;

        MultipartFile file = mrequest.getFile("filename");
        req.put("inputName","filename");

        if (file.getSize() > 0) {
            fileService.uploadFiles(request, req);
        } else {
            req.put("filename", null);
        }
        if (req.get("isNew").equals("Y")) {
            req.put("adindex", service.getNextAdindex(req));
            service.insert(req);
        } else {

            service.update(req);
        }


        return "redirect:/" + rootKey + "/list";
    }

    /**
     * 수정
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "modify")
    @ResponseBody
    public ResultMap modify(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.modify(req);
    }


    /**
     * 세션바꾸기
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "change/{change_uid}")
    public String change(HttpServletRequest request, HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        String change_uid = req.get("change_uid") + "";
        req.put("login_uid", change_uid);
        session.setAttribute("login_uid", change_uid);

        return rootPath + "list";
    }


    /**
     * 삭제
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete")
    @ResponseBody
    public ResultMap delete(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.delete(req);
    }

    /**
     * 순서 위로
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "upPlayOrder/{adindex}/{playorder}")
    @ResponseBody
    public ResultMap upPlayOrder(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        return service.upPlayOrder(req);
    }


    /**
     * 순서 아래로
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "downPlayOrder/{adindex}/{playorder}")
    @ResponseBody
    public ResultMap downPlayOrder(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        return service.downPlayOrder(req);
    }



    /**
     * 광고제목체크
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "adCheck")
    @ResponseBody
    public ResultMap adCheck(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.adCheck(req);
    }
}
