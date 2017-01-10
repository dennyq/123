package com.hs.web.controller;



import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;





@Controller
@RequestMapping(value = "/common/")
public class CommonController extends ControllerPageBase {
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);
	
	@Autowired
	private CommonService service;

	//공통코드
	@RequestMapping(value = "code")
	@ResponseBody
	public ResultMap code(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);
		return service.code(req);
	}



	
}
