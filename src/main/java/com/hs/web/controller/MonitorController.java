package com.hs.web.controller;

import com.hs.DbMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.service.EasySocket;
import com.hs.web.service.MonitorService;
import com.hs.web.service.RemoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import java.util.Timer;
import java.util.TimerTask;

// 머신
@Controller
@RequestMapping(value = "/monitor/")
public class MonitorController extends ControllerPageBase  {
	@Autowired
	private MonitorService service;
	@Autowired private RemoteService remoteService;
	private static final Logger logger = LoggerFactory.getLogger(MonitorController.class);
	private final String rootKey = "monitor";
	private final String rootPath = "pages/" + rootKey + "/";

	//목록
	@RequestMapping(value = "")
	public String base(HttpServletRequest request,Model model,HttpSession session) throws Exception {
		RequestMap req = RequestMap.create(request);
		int connectVal = remoteService.getConnection(req, session);
		if (connectVal == 1) {
			String laborState = remoteService.getLaborState(req,session);
			String onOffState = remoteService.getOnOffState(req,session);
			DbMap laborStates = new DbMap();

			for(int i=0;i<laborState.length();i++){
				laborStates.put("channel"+(i+1),laborState.charAt(i)+"");
			}
			DbMap onOffStates = new DbMap();

			for(int i=0;i<onOffState.length();i++){
				onOffStates.put("channel"+(i+1),onOffState.charAt(i)+"");
			}
			//정역정보
			model.addAttribute("laborStates", laborStates);
			//onOff
			model.addAttribute("onOffStates", onOffStates);
		}

		model.addAttribute("innersensorstate",service.getInnersensorstate(req).get("data"));
		model.addAttribute("innercablesensorstate",service.getInnercablesensorstate(req).get("data"));
		model.addAttribute("outersensorstate",service.getOutersensorstate(req).get("data"));
		model.addAttribute("initsetting",service.getInitsetting(req).get("data"));
		model.addAttribute("nutrientstate",service.getNutrientstate(req).get("data"));
		model.addAttribute("heatrecoverystate", service.getHeatrecoverystate(req).get("data"));

		//열회수형환풍기상태정보
		model.addAttribute("airfanstate", service.getAirfanstate(req).get("data"));


		return rootPath + "monitor";

	}



}
