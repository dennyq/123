package com.hs.web.controller;

import com.hs.BizException;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.service.FileService;
import com.hs.web.service.HealthService;
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
@RequestMapping(value = "/health")
public class HealthController extends ControllerPageBase {
    @Autowired
    private HealthService service;
    @Autowired
    private FileService fileService;

    private static final Logger logger = LoggerFactory.getLogger(HealthController.class);
    private String rootKey = "health";
    private String rootPath = "pages/" + rootKey + "/";


    /**
     * index redirect
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/")
    public String index(HttpServletRequest request) throws Exception {

        return "redirect:/health/list";

    }

    //todo: 여기서 관리자용, sepecial 용으로 나누자.


    /**
     * 페이지목록
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
        String Path = request.getContextPath();
        model.addAttribute("thisPath","/"+rootKey);
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
        model.addAttribute("thisPath","/"+rootKey);
        logger.debug("thisPath={}","/"+rootKey);
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
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "list";
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
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }

    /**
     * 상세페이지
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail/{healthindex}")
    public String detail(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }


    /**
     * 저장(신규/업데이트)
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    public String save(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        if (req.get("login_uid") == null) {
            throw new BizException("9009", "need_login");
        }

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;

        MultipartFile file = mrequest.getFile("thumbnailfile");
        req.put("inputName","thumbnailfile");



        if (Global.isDev) logger.info("[HealthController save] req = {}" + req);

        if (file.getSize() > 0) {
            fileService.uploadFiles(request, req);
        } else {
            req.put("thumbnailfile", null);
        }
        if (Global.isDev) logger.info("[HealthController after upload] req = {}" + req);

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
    //아이디체크
    @RequestMapping(value = "deleteFile")
    @ResponseBody
    public ResultMap deleteFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.deleteFile(req);
    }

}
