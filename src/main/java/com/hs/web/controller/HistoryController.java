package com.hs.web.controller;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.RequestMap;
import com.hs.web.service.HistoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

// 사용이력
@Controller
@RequestMapping(value = "/history/")
public class HistoryController extends ControllerPageBase {
	@Autowired
	private HistoryService service;
	private static final Logger logger = LoggerFactory.getLogger(HistoryController.class);
	private String rootKey = "history";
	private String rootPath = "pages/" + rootKey + "/";

	//엑셀파일 변환 및 다운로드
	@RequestMapping("/excel_transform_controller")
	public String excelTransform(HttpServletRequest request,Model model) throws Exception{
		RequestMap req = RequestMap.create(request);
		DbList excelList = (DbList) service.list(req).get("data");

		model.addAttribute("excelList", excelList);

		return "excelView";
	}


	//엑셀파일 변환 및 다운로드 ,method = RequestMethod.POST
	@RequestMapping(value = "/excel_transform_controller/{idx}")
	public String excelTransformIdx(HttpServletRequest request,Model model) throws Exception{
		RequestMap req = RequestMap.create(request);
		putPathVariable(request, req);

		if(!(req.get("searchFrm")+"").equalsIgnoreCase("Y")){
			throw new BizException("9009","정상적인 경로로 다시 다운해주세요.","/");
		}
		DbList excelList = (DbList) service.list(req).get("data");

		model.addAttribute("excelList", excelList);
		model.addAttribute("idx", req.get("idx"));

		return "excelView";
	}

	//목록
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request,Model model) throws Exception {
//		RequestMap req = RequestMap.create(request);
//		model.addAllAttributes(service.list(req));
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
	@RequestMapping(value = "detail/{memberid}/{scantime}/{memberid}")
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
	@ResponseBody
	public ResultMap write(HttpServletRequest request) throws Exception {
//	public String write(HttpServletRequest request) throws Exception {
		RequestMap req = RequestMap.create(request);


		req.put("uploadDir", rootKey);
		req.putAll(service.uploadImage(request));


//	 	service.write(req);
			return service.write(req);
//		return "redirect:/" + rootKey + "/detail";
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
