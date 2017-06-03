package com.hs.web.interceptor;

import com.hs.web.Global;
import com.hs.web.service.SpecialLoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SpecialLoginCheckInterceptor extends HandlerInterceptorAdapter {
  private static final Logger logger = LoggerFactory.getLogger(SpecialLoginCheckInterceptor.class);

  @Autowired private SpecialLoginService loginService;

  @Override
  public void postHandle(HttpServletRequest request,
                         HttpServletResponse response, Object handler,
                         ModelAndView modelAndView) throws Exception {

    super.postHandle(request, response, handler, modelAndView);

  }


  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    SkipLoginInterceptor chkController = handler.getClass().getAnnotation(SkipLoginInterceptor.class);
    if (Global.isDev) logger.info("chkController: {}",chkController);
    if (Global.isDev) logger.info("chkController null : {}",chkController==null);
    if (chkController == null) {
      if (Global.isDev) logger.info("login prehandle! null");

      String url = request.getRequestURI();
      String noauthUrl = request.getContextPath() + "/special/noauth";

      boolean isLogin = checkLogin(request);

      if (Global.isDev) logger.info("isLogin={}", isLogin);
      if (!isLogin) {

        StringBuffer reUrl = new StringBuffer().append('?').append(request.getQueryString());
        if (reUrl.toString().contains("null")) {
          response.sendRedirect(noauthUrl);
        } else {
          response.sendRedirect(noauthUrl + "?reurl=" + url + reUrl);
        }

        return false;
      }
      return true;
    }
    return true;
  }

  private boolean checkLogin(HttpServletRequest request) {

    HttpSession session = request.getSession();
    if(session != null){
      if (session.getAttribute("specialid") != null) {
        return true;
      }
    }
    return false;

  }



}
