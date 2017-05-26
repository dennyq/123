package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.AppService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping(value = "/app/")
public class AppController extends ControllerPageBase {
    private final AppService service;
    private static final Logger logger = LoggerFactory.getLogger(AppController.class);
    private final String rootKey = "app";
    private final String rootPath = "pages/" + rootKey + "/";

    @Autowired
    public AppController(AppService service) {
        this.service = service;
    }


    //안드로이드맵뷰
    @RequestMapping(value = "mapview")
    public String mapview(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);

        return rootPath + "mapview";
    }

    //안드로이드맵뷰
    @RequestMapping(value = "mapviewinfo")
    @ResponseBody
    public ResultMap mapviewinfo(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);

        return service.mapviewinfo(req);
    }

    //안드로이드맵뷰
    @RequestMapping(value = "locationSelectmapview")
    public String locationSelectmapview(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);


        getListModel(model, req);
        return rootPath + "locationSelectmapview";
    }

    ///search
    @RequestMapping(value = "search")
    @ResponseBody
    public ResultMap search(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.search(req);
    }

    ///playList
    @RequestMapping(value = "playList")
    @ResponseBody
    public ResultMap playList(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.playList(req);
    }

    ///playList
    @RequestMapping(value = "getPlayList")
    @ResponseBody
    public ResultMap getPlayList(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.getPlayList(req);
    }


    //상세
    @RequestMapping(value = "detail/{memberid}")
    public String detailById(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        return rootPath + "detail";
    }

    private void getListModel(Model model, RequestMap req) {
        model.addAllAttributes(service.list(req));
        String gubun = (String) req.get("gubun");
        String putGubun;
        if (gubun.equals("2")) {//약국-1
            putGubun = "1";
        } else if (gubun.equals("3")) {//병원-2
            putGubun = "2";
        } else {
            putGubun = "0";
        }
        req.put("gubun", putGubun);
        req.put("searchCode", "1");
        model.addAttribute("codeList", service.getCodeList(req).get("rows"));
        model.addAttribute("gubun", putGubun);
    }

}
