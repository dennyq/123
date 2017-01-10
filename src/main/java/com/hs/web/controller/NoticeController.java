package com.hs.web.controller;

import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

// 머신
@Controller
@RequestMapping(value = "/notice/")
public class NoticeController extends ControllerPageBase {
	@Autowired
	private NoticeService service;
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	private String rootKey = "notice";
	private String rootPath = "pages/" + rootKey + "/";

	//목록
	@RequestMapping(value = "list/{page}")
	public String listPage(HttpServletRequest request,Model model) throws Exception {
		RequestMap req = RequestMap.create(request);
		putPathVariable(request, req);
		model.addAllAttributes(service.list(req));
		return rootPath + "list";
	}
	//목록
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request,Model model) throws Exception {
		RequestMap req = RequestMap.create(request);
		model.addAllAttributes(service.list(req));
		return rootPath + "list";
	}

	//목록
	@RequestMapping(value = "search")
	public String search(HttpServletRequest request,Model model) throws Exception {
		RequestMap req = RequestMap.create(request);
		model.addAllAttributes(service.list(req));
		return rootPath + "list";
	}



	//상세
	@RequestMapping(value = "detail/{noticenumber}")
	public String detail(HttpServletRequest request, Model model) throws Exception {
		RequestMap req = RequestMap.create(request);
		putPathVariable(request, req);
		model.addAllAttributes(service.detail(req));
		return rootPath + "detail";
	}

	//쓰기페이지
	@RequestMapping(value = "detail")
	public String input(HttpServletRequest request, Model model) throws Exception {
		RequestMap req = RequestMap.create(request);
		return rootPath + "detail";
	}

	//쓰기
	@RequestMapping(value = "write")
	public String write(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);

		req.put("uploadDir", rootKey);
		req.putAll(service.uploadImage(request));
		service.write(req);

		return "redirect:/" + rootKey + "/list";
	}

	//쓰기
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);

//		req.put("uploadDir", rootKey);
//		req.putAll(service.uploadImage(request));
		service.save(req);

		return "redirect:/" + rootKey + "/list";
	}
	//수정
	@RequestMapping(value = "modify")
	@ResponseBody
	public ResultMap modify(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);
		return service.modify(req);
	}

	//삭제
	@RequestMapping(value = "delete")
	@ResponseBody
	public ResultMap delete(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);
		return service.delete(req);
	}

	//비밀번호 변경
	@RequestMapping(value = "initailizePwd")
	@ResponseBody
	public ResultMap initailizePwd(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);
		return service.initailizePwd(req);
	}

}
