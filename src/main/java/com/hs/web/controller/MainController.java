package com.hs.web.controller;

import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.interceptor.SkipLoginInterceptor;
import com.hs.web.service.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

@SkipLoginInterceptor
@Controller
@RequestMapping(value = "")
public class MainController extends ControllerPageBase  {
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    private MainService service;
    @Autowired
    private LoginService loginService;
    @Autowired
    private RemoteService remoteService;

    //첫화면
    @RequestMapping(value = "/")
    public String index(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        if (req.get("login_uid") != null) {

//            return "redirect:/notice/list";
            return "redirect:/member/list";
        } else {

            return "pages/login/login";
        }


    }

    //첫화면
    @RequestMapping(value = "/m_login")
    public String m_login(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        return "pages/login/m_login";
    }

    //로그인
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();
        req.put("memberid", req.get("famersId"));
        req.put("password", req.get("famersPw"));
        String auto_login = req.get("auto_login") + "";
        req.put("auto_login", auto_login);


        if (Global.isDev) logger.debug("[member memberLogin] req:{}", req);

        if (loginService.isLogin(req)) {
            DbMap loginMap = loginService.login(req);
            if (loginMap != null) {
                loginService.doLogin(request, res, loginMap);

                if ((loginMap.get("memberid") + "").equals("admin")) {
                    res.put("result_message", "success_admin");
                } else {
                    res.put("result_message", "success");
                }


            } else {
                res.put("result_message", "login_not_match");
            }
        } else {
            res.put("result_message", "login_not_match");
        }
        if (Global.isDev) logger.debug("[member memberLogin] res:{}", res);
        model.addAllAttributes(res);
        return "jsonView";
    }

    //logout
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request,HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);
        loginService.logout(req,session);
        session.invalidate();
        return "redirect:/";
    }

    //m_list
    @RequestMapping(value = "/m_list")
    public String m_list(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        return "pages/main/m_list";
    }

    //about
    @RequestMapping(value = "/main/about")
    public String about() throws Exception {
        return "pages/main/about";
    }

    //product
    @RequestMapping(value = "/main/product")
    public String product() throws Exception {
        return "pages/main/product";
    }

    //인증에러
    @RequestMapping(value = "noauth")
    public String noauth() throws Exception {
        return "pages/common/noauth";
    }


}


