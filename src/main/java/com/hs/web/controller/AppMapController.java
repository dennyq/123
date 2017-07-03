package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.EpilogueService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping(value = "/app/map/")
public class AppMapController extends ControllerPageBase {
    @Autowired private EpilogueService service;

    private static final Logger logger = LoggerFactory.getLogger(AppMapController.class);
    private final String rootKey = "app";
    private final String rootPath = "pages/" + rootKey + "/";




    //리스트
    @RequestMapping(value = "epilogueList")
    @ResponseBody
    public ResultMap epilogueList(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);

        return service.list(req);
    }

    //상세
    @RequestMapping(value = "epilogueReg")
    @ResponseBody
    public ResultMap epilogueReg(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);

        return service.save(req);
    }

}
