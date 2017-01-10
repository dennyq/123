package com.hs.web;

 

import com.hs.BizException;
import com.hs.ResultType;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.Map;

@Controller
public abstract class ControllerPageBase {
	private final static Logger logger = LoggerFactory.getLogger(ControllerPageBase.class);



	@ExceptionHandler (BizException.class)
	@ResponseStatus(value=HttpStatus.BAD_REQUEST)
	public ModelAndView handleArgsException(Exception ex, HttpServletRequest request) {
		return handle(ex, request);
	}

    @ExceptionHandler (Exception.class)
    @ResponseStatus(value=HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView handleUnknowException(Exception ex, HttpServletRequest request) {
        return handle(ex, request);
    }

    public ModelAndView handle(Exception ex, HttpServletRequest request) {
        logger.error("알 수 없는 페이지 오류가 발생했습니다.", ex);
        String code = ResultType.UnknowError+"";
        String str = "내부 시스템에 오류가 발생했습니다.";
//        String str = "서버 접속 오류가 발생하였습니다.";
        String url = "";
        if(ex instanceof Exception) {
            if(ex.getMessage()!=null  && ex.getMessage()!="")
            str = ex.getMessage();
        }

        if(ex instanceof BizException) {
            str = ex.getMessage();
            code = ((BizException)ex).resultCode();
            url = ((BizException)ex).url();
        }

        ModelAndView mv = new ModelAndView("common/error/error500");
        mv.addObject("result_code", code);
        mv.addObject("result_message", str);
        if(!StringUtils.isEmpty(request.getRemoteUser())) {
            mv.addObject("login_uid", request.getRemoteUser());
        }

        if (request.getRequestURI().endsWith(".json") || (request.getContentType() != null && request.getContentType().equals("application/json"))) {
            mv.addObject("result_code", code);
            mv.addObject("result_message", str);
            mv.setViewName("jsonView");
            return mv;
        }

        if(code.equals(ResultType.HandeledServerError+"")){

            ModelAndView mvAlert = new ModelAndView("/common/error/alert");
            mvAlert.addObject("result_code", code);
            mvAlert.addObject("result_message", str);

            return mvAlert;

        }else if(code.equals(ResultType.ReurlServerError+"")){

            ModelAndView mvAlert = new ModelAndView("/common/error/alert");
            mvAlert.addObject("result_code", code);
            mvAlert.addObject("result_message", str);
            mvAlert.addObject("url", url);
            return mvAlert;

        }else if(code.equals(ResultType.AuthError+"")){

            ModelAndView mvAlert = new ModelAndView("/common/error/noauth");
            mvAlert.addObject("result_code", code);
            mvAlert.addObject("result_message", str);
            mvAlert.addObject("url", url);
            return mvAlert;

        }else if(code.equals("9008")){

            ModelAndView mvAlert = new ModelAndView("/common/error/alert");
            mvAlert.addObject("result_code", code);
            mvAlert.addObject("result_message", str);

            if(url == null){
                url = "/";
            }
            mvAlert.addObject("url", url);
            return mvAlert;
        }else if(code.equals("9009")){

            ModelAndView mvAlert = new ModelAndView("/common/error/alert");
            mvAlert.addObject("result_code", code);
            mvAlert.addObject("result_message", str);

            mvAlert.addObject("url", url);
            return mvAlert;
        }

        return mv;
    }

    protected void putPathVariable(HttpServletRequest request, RequestMap req) {
        req.putAll((Map) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE));
    }


}
