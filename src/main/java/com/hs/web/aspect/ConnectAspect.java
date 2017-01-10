package com.hs.web.aspect;


import com.hs.BizException;
import com.hs.ResultMap;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.service.RemoteService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * Created by ek on 2014-12-18.
 */
@Aspect
public class ConnectAspect {
    private static final Logger logger = LoggerFactory.getLogger(ConnectAspect.class);

    @Autowired
    private RemoteService service;
    private Object resultArr;
    private String logMsg;
    private Object[] thisObjArr;
    private int thisObjArrLen;
    private String[] parameterNames;
    private Object[] parameterTypes;


    @Pointcut("execution(public * com.hs.web.controller..*(..)) &&  !execution(public * com.hs.web.controller.RemoteController.*(..))  &&  !execution(public * com.hs.web.service.RemoteService.*(..))  &&  !execution(public * com.hs.web.service.MonitorService.*(..)) &&  !execution(public * com.hs.web.controller.MonitorController.*(..)) &&  !execution(public * com.hs.web.controller.MainController.*(..))")
//    @Pointcut("execution(public * com.hs.web.controller..*(..)) &&  !execution(public * com.hs.web.controller.RemoteController.*(..)) &&  !execution(public * com.hs.web.controller.MainController.*(..))")
//    @Pointcut("execution(public * com.hs.web.controller..*(..)) &&  !execution(public * com.hs.web.controller.RemoteController.*(..)) !execution(public * com.hs.web.controller.MainController.*(..))")

    public void connectChk() {
    }

    @Around("connectChk()")
    public Object connectChk(ProceedingJoinPoint joinPoint) throws Throwable {


        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        logMsg = className + " : " + methodName + "\n";
        thisObjArr = joinPoint.getArgs();
        thisObjArrLen = thisObjArr.length;
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        parameterNames = signature.getParameterNames();
        parameterTypes = signature.getParameterTypes();
        resultArr = resultWithProceed(joinPoint);

        return resultArr;
    }

    private Object resultWithProceed(ProceedingJoinPoint joinPoint) throws Throwable {

        ObjectMapper jsonMapper = new ObjectMapper();
        jsonMapper.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);

        for (Object obj : thisObjArr) {

            if (obj instanceof HttpServletRequest || obj instanceof MultipartHttpServletRequest) {
                HttpServletRequest request = (HttpServletRequest) obj;
                RequestMap req = RequestMap.create(request);
                HttpSession session = request.getSession();
                if(session.getAttribute("login_sockect")!=null){

                    service.closeSocket(req);

                }

            } else if (obj instanceof RequestMap) {
                RequestMap req = (RequestMap) obj;
            } else {
                for (int i = 0; i < thisObjArrLen; i++) {
                    Object start = thisObjArr[i];
                }
            }

            resultArr = joinPoint.proceed();





            if (resultArr instanceof ResultMap) {
                ResultMap res = (ResultMap) resultArr;
            } else if (resultArr instanceof String && thisObjArrLen > 0) {
                for (int i = 0; i < parameterNames.length; i++) {
                    String parameterName = parameterNames[i];
                    Object parameterType = parameterTypes[i];
                    if (parameterType instanceof Model || parameterName.equals("model")) {
                        Object objByIdx = thisObjArr[i];
                    }
                }
            } else {
            }

            return resultArr;
        }
        return resultArr;
    }
    private boolean checkLogin(HttpServletRequest request) {

        HttpSession session = request.getSession();
        if (session != null) {
            if (session.getAttribute("memberid") != null) {
                return true;
            }
        }
        return false;

    }
}