package com.hs.web;

import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.StringUtil;
import com.hs.util.UnitUtil;
import com.hs.web.mapper.CommonMapper;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;


@Service
public class ServiceBase {
	private final static Logger logger = LoggerFactory.getLogger(ServiceBase.class);
	@Autowired private CommonMapper mapper;
  @Autowired private PathManager pathManager;
	protected void checkArgs(RequestMap req, String... args) {
		for(String arg : args) {
			if(!req.containsKey(arg))
				throw new DbMap.ArgsException(arg);
		}
	}


  protected RequestMap getSplitDate(RequestMap req,String dateName){
    if(req.get(dateName) != null && req.get(dateName) != ""){
      String dateStr = req.get(dateName)+"";
      if(dateStr.trim().equals("-") && dateStr.trim().equals("+-+") ){
        req.remove(dateName);
      }else{
        String[] dateStrArr = dateStr.split(" - ");
        if(dateStrArr.length == 2){
          String dateStr_low = dateStrArr[0].replace(".","");
          String dateStr_high = dateStrArr[1].replace(".","");
          req.put(dateName+"_low", dateStr_low);
          req.put(dateName+"_high",dateStr_high);
        }else{
          req.remove(dateName);
        }

      }

    }
    return req;
  }

	protected void putPathVariable(HttpServletRequest request, RequestMap req) {
    //noinspection unchecked
    req.putAll((Map) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE));
	}


	protected void setPaging(RequestMap req) {

		String page = StringUtil.nvl((String) req.get("page"), "1");
		String rows =StringUtil.nvl((String) req.get("rows"), "10");

    int page_num  = UnitUtil.toInt(page);
    int page_size =  UnitUtil.toInt(rows);

    req.put("page",page);
		req.put("p_start", (page_num - 1) * (page_size) );
		req.put("p_size", page_size);
	}
	protected void setPagingApp(RequestMap req) {

		String p_start_str = StringUtil.nvl((String) req.get("p_start"), "1");
		String p_size_str =StringUtil.nvl((String) req.get("p_size"), "10");
//
    int p_start  = UnitUtil.toInt(p_start_str);
    int p_size =  UnitUtil.toInt(p_size_str);
//
////    req.put("page",page);
////		req.put("p_start", (page_num - 1) * (page_size) );
		req.put("p_start", p_start);
		req.put("p_size", p_size);
	}


  protected ResultMap setDownload2(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) throws IOException
  {
    Map<String, Object> model = mv.getModel();

    File file = (File)model.get("file");
    String filename = (String)model.get("filename");

    String str = URLEncoder.encode(filename, "utf-8");
    File destFile = pathManager.getTempPdfFile();
    if(destFile.exists()) FileUtils.deleteQuietly(destFile);
    FileUtils.moveFile(file, destFile);

    String fileUrl = "/ibt/print/download.do?fn=" + str + "&fid=" + destFile.getName();
    ResultMap res = ResultMap.create();
    res.put("url", fileUrl);
    return res;
  }


  protected void setDownload(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) throws IOException
  {
    Map<String, Object> model = mv.getModel();

    File file = (File)model.get("file");
    String filename = (String)model.get("filename"); // filename = new String(filename.getBytes("8859_1"),"utf-8");

    boolean del = (Boolean)model.get("delete");
    String contentType = (String)model.get("contenttype");

    if(contentType != null)     response.setContentType(contentType);

    response.setContentLength((int)file.length());

    String fileName = filename;
    fileName = getDownFileNames(request, fileName);

    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
    response.setHeader("Content-Transfer-Encoding", "binary");

    OutputStream out = response.getOutputStream();
    FileInputStream fis = null;

    try {
      fis = new FileInputStream(file);
      FileCopyUtils.copy(fis, out);

    } finally {
      if(fis != null)
      {
        try {
          fis.close();
        } catch(IOException ignored)
        {}
      }
    }
    out.flush();

    if(del)
    {
      FileUtils.deleteQuietly(file);
    }
  }

  private static String getBrowser(HttpServletRequest request)
  {
    String header = request.getHeader("User-Agent");
    if ( header.indexOf("MSIE") > -1)
    {
      return "MSIE";

    } else if ( header.indexOf("Chrome") > -1)
    {
      return "Chrome";

    } else if ( header.indexOf("Opera") > -1)
    {
      return "Opera";

    } else if ( header.indexOf("Safari") > -1)
    {
      return "Safari";
    }
    return "Firefox";
  }

  private static String getDownFileNames(HttpServletRequest request, String fileName)
  {
    String browser = getBrowser(request);
    if ( fileName == null || fileName.equals("") )
    {
      fileName = "UnKnownFileName";
    }

    String resultName;

    String tomcatEncoding = "ISO-8859-1";   //tomcatEncoding = "UTF-8";

    try{
      if ( browser.indexOf("MSIE") != -1 )
      {
        // Explorer
        resultName = URLEncoder.encode(fileName, "UTF-8"); // resultName = new String( fileName.getBytes("EUC-KR"), "ISO-8859-1").replaceAll(" ","%20");

      } else if ( browser.indexOf("Opera") != -1 )
      {
        // Opera
        resultName = new String( fileName.getBytes("UTF-8"), tomcatEncoding);

      }else if ( browser.indexOf("Chrome") != -1 )
      {
        // Chrome
        resultName = new String( fileName.getBytes("EUC-KR"), tomcatEncoding);

      }else if ( browser.indexOf("Safari") != -1 )
      {
        // Safari
        resultName = new String( fileName.getBytes("UTF-8"), tomcatEncoding);

      } else if ( browser.indexOf("Firefox") != -1 )
      {
        // FireFox
        resultName = new String( fileName.getBytes("UTF-8"), tomcatEncoding);

      } else{
        // Other
        resultName = new String( fileName.getBytes("EUC-KR"), tomcatEncoding);

      }
    } catch (Exception ex)
    {
      resultName = fileName;
    }
    return resultName;
  }


}









