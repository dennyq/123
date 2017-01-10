package com.hs.web.service;


import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.mapper.MemberMapper;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.MainMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Service
public class MainService extends ServiceBase{

    private static final Logger logger = LoggerFactory.getLogger(MainService.class);
    @Autowired private MainMapper mapper;
    @Autowired private FileService fileService;
    @Autowired private MemberMapper memberMapper;

    public ResultMap login(HttpServletRequest request, HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();
        checkArgs(req);

        if(Global.isDev){
            logger.debug("[main login] req:{}", req);

            DbMap loginMap = mapper.login(req);
            boolean isMember =loginMap!=null;
            if(isMember){
                loginMap.putAll(req);
                logger.debug("[main login] loginMap:{}", loginMap);
                session.setAttribute("loginMap", loginMap);
                res.put("result_message","success");
            }else{
                res.put("result_message","login_not_match");
            }
        }
        if(Global.isDev) logger.debug("[main login] send:{}", res);
        return res;
    }






}
