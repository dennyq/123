package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.HealthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping(value = "/app/healthinfo/")
public class AppHealthController extends ControllerPageBase {
    @Autowired private HealthService service;

    private static final Logger logger = LoggerFactory.getLogger(AppHealthController.class);

    /**
     * 목록 mainList?p_size=시작위치&p_size=개수
     * @param request ?p_size=시작위치&p_size=개수
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "mainList")
    @ResponseBody
    public ResultMap mainList(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        return service.list(req);
    }

    /**
     * search 목록 searchList?searchvalue=검색값&p_size=시작위치&p_size=개수
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "searchList")
    @ResponseBody
    public ResultMap searchList(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.list(req);
    }

    /**
     * 상세 detail?healthindex=인덱스값
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail")
    @ResponseBody
    public ResultMap detail(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);

        return service.detail(req);
    }
}
