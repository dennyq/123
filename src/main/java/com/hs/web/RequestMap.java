package com.hs.web;

import com.google.gson.Gson;
import com.hs.DbMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;

public class RequestMap extends DbMap {
    private static final Logger logger = LoggerFactory.getLogger(RequestMap.class);
    private static final long serialVersionUID = -1840941644262834923L;

    private static Gson _gson = new Gson();
    public static RequestMap create(HttpServletRequest request) throws IOException {

        if(request.getContentType() != null && request.getContentType().equals("application/json")) {
            String message = org.apache.commons.io.IOUtils.toString(request.getInputStream());
            RequestMap map = _gson.fromJson(message, RequestMap.class);
            setDefaultValues(request, map);

            return map;
        }
        else {
            RequestMap map = new RequestMap();
            Enumeration en = request.getParameterNames();
            while(en.hasMoreElements()) {
                String key = en.nextElement() + "";

                String value = ServletRequestUtils.getStringParameter(request, key, "");

                map.put(key, value);
            }

            setDefaultValues(request, map);

            return map;
        }

    }


    private static void setDefaultValues(HttpServletRequest request, RequestMap req) {
        req.put("login_ip", request.getRemoteAddr());
        HttpSession session = request.getSession();
        // 반드시 DB필드명과 다른 이름으로 설정할 것 - 관리자 에서 문제될 수 있음

        String memberid = session.getAttribute("memberid")+"";
        if(memberid.equals("admin")){
            req.put("login_admin", "Y");
            session.setAttribute("login_admin","Y");
            if(session.getAttribute("login_uid")!=null){
                req.put("login_uid", session.getAttribute("login_uid"));
            }
        }else{
            req.put("login_admin", "N");
            session.setAttribute("login_admin","N");
            if(session.getAttribute("login_uid")!=null){
                req.put("login_uid", session.getAttribute("login_uid"));
            }
        }

        req.put("login_uid", session.getAttribute("memberid"));
        req.put("login_name", session.getAttribute("name"));






    }


    private HttpServletRequest _httpServletRequest;

    public RequestMap() {

    }

    public RequestMap(HttpServletRequest httpServletRequest, Map<? extends String, ? extends String> map){
        super(map);
        _httpServletRequest = httpServletRequest;
    }

    public HttpServletRequest request() {
        return _httpServletRequest;
    }






    public void checkArgs(String... params) {
        for(String arg : params) {
            if(!containsKey(arg))
                throw new ArgsException(arg);
        }
    }

    public void checkArgValues(String name, String... values) {
        String value = get(name, "");
        for(String arg : values) {
            if (value.equals(arg))
                return;
        }
        throw new ArgsException(name);
    }


}