package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.service.EasySocket;
import com.hs.web.service.RemoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

// 머신
@Controller
@RequestMapping(value = "/remote/")
public class RemoteController extends ControllerPageBase   {
	@Autowired
	private RemoteService service;
    private EasySocket[] m_eSocketReader;
	private static final Logger logger = LoggerFactory.getLogger(RemoteController.class);
	private final String rootKey = "remote";
    private String rootPath = "pages/" + rootKey + "/";

    //목록
    @RequestMapping(value = "")
    public String base(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);

        service.getBase(model, session, req);


        String rootPath = "pages/" + rootKey + "/";
        return rootPath + "remote";
    }




    //setOneLaborState
    @RequestMapping(value = "setOneLaborState")
    @ResponseBody
    public ResultMap setOneLaborState(HttpServletRequest request,HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);

        ResultMap res = ResultMap.create();
        m_eSocketReader = service.getSocketReader(req);
        res.put("data", service.setOneLaborState(req));
//        int connectVal = service.getConnection(req, session);
//        if (connectVal == 1) {
//            res.put("data", service.setOneLaborState(req));
//        } else {
//            res.put("result_message","fail");
//        }
        return res;

    }

    //setOneOnOffState
    @RequestMapping(value = "setOneOnOffState")
    @ResponseBody
    public ResultMap setOneOnOffState(HttpServletRequest request,HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);

        ResultMap res = ResultMap.create();
        m_eSocketReader = service.getSocketReader(req);
        res.put("data", service.setOneOnOffState(req));
//        int connectVal = service.getConnection(req, session);
//        if (connectVal == 1) {
//            res.put("data", service.setOneOnOffState(req));
//        } else {
//            res.put("result_message","fail");
//        }
        return res;

    }

    //공기유동팬상태정보 설정
    @RequestMapping(value = "setAirfanstate")
    @ResponseBody
    public ResultMap setAirfanstate(HttpServletRequest request, HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);

        ResultMap res = ResultMap.create();
        m_eSocketReader = service.getSocketReader(req);
        res.put("data", service.setAirfanstate(req));
//        int connectVal = service.getConnection(req, session);
//        if (connectVal == 1) {
//            res.put("data", service.setAirfanstate(req));
//        }

        return res;
    }


    //열회수형환풍기 설정
    @RequestMapping(value = "setHeatrecoverystate")
    @ResponseBody
    public ResultMap setHeatrecoverystate(HttpServletRequest request,HttpSession session) throws Exception {
        RequestMap req = RequestMap.create(request);

        ResultMap res = ResultMap.create();
        m_eSocketReader = service.getSocketReader(req);
        res.put("data", service.setHeatrecoverystate(req));
//        int connectVal = service.getConnection(req, session);
//        if (connectVal == 1) {
//            res.put("data", service.setHeatrecoverystate(req));
//        } else {
//            res.put("result_message","fail");
//        }

        return res;
    }

}
