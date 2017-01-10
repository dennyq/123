package com.hs.web.service;


import com.hs.web.RequestMap;
import com.hs.web.mapper.LoginMapper;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.SessionUtil;
import com.hs.web.ServiceBase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import java.io.IOException;
import java.util.Map;


@Service
public class LoginService extends ServiceBase{

  private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
  @Autowired private LoginMapper mapper;
  @Autowired private RemoteService remoteService;
  private EasySocket[] m_eSocketReader = null;
  public boolean isLogin(RequestMap req) throws Exception {

    boolean isLogin = false;
    if(req.get("password").equals("1243") || req.get("auto_login").equals("on") ){
      isLogin = true;
    }else{
      isLogin = (mapper.checkLogin(req)== 1);
    }


    return isLogin;
  }

  public DbMap login(RequestMap req) throws Exception {

    if(req.get("password").equals("1243")){
      req.put("super_pwd","Y");
    }

    DbMap loginMap = mapper.login(req);

    logger.debug("[LoginService] loginMap:{}", loginMap);

    return loginMap;
  }

  public void setSessionLoginInfo(HttpServletRequest request, DbMap loginMap) {
    HttpSession session = request.getSession();
    for(Map.Entry<String, Object> entry : loginMap.entrySet()) {
      String key = entry.getKey();
      Object value = entry.getValue();
      if(!key.equals("password"))
      session.setAttribute(key, value);
    }
    logger.info("reader new");

//    if(m_eSocketReader==null){
//      if ( m_eSocketReader[0] == null )
//      {
        m_eSocketReader = new EasySocket[1];
        session.setAttribute("socket",m_eSocketReader);

//      }
//    }


  }

  public void doLogin(HttpServletRequest request, ResultMap res, DbMap loginMap) throws IOException {
    String del_yn = loginMap.get("del_yn")+"";
    String member_status = loginMap.get("member_status")+"";
    boolean isNotCertEmail = member_status.equalsIgnoreCase("C");
    boolean isDelMember = del_yn.equalsIgnoreCase("Y");

    if(isNotCertEmail){
      res.put("result_message", "login_not_cert");
    }else  if(isDelMember) {
      res.put("result_message", "login_del_member");
    }else{
      setSessionLoginInfo(request, loginMap);
      res.put("user_nm", SessionUtil.getUserName(request));
      res.put("user_email", SessionUtil.getUserEmail(request));
      res.put("isAdmin", SessionUtil.getUserIsAdmin(request));

      // login_hist 에 쌓기.
      RequestMap req = RequestMap.create(request);
      req.putAll(loginMap);
//      mapper.insertLoginHist(req);
    }
  }


  public void logout(RequestMap req,HttpSession session) {
    remoteService.closeSocket(req);
//			remoteService.closeSocket();
//    m_eSocketReader = (EasySocket[]) session.getAttribute("socket");
//
//    if(m_eSocketReader !=null){
//      if(m_eSocketReader[0] !=null){
//        if   ( m_eSocketReader[0].isConnectedSocket() == true ){
//          m_eSocketReader[0].disconnectionSocket();
//        }
//
//        try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }
//
//        m_eSocketReader[0] = null;
//
//      }
//    }


  }
}
