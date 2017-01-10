package com.hs.web.controller;

import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.service.FileService;
import com.hs.BizException;
import com.hs.DbMap;
import com.hs.web.DownloadView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

@Controller
@RequestMapping(value = "")
public class DownloadController extends ControllerPageBase {
  @Autowired private DownloadView downloadView;
  
  @Autowired private FileService fileservice;
  
  private static final Logger logger = LoggerFactory.getLogger(DownloadController.class);
  /** 다운로드 버퍼 크기 */
  private static final int BUFFER_SIZE = 8192; // 8kb

  /** 문자 인코딩 */
  private static final String CHARSET = "euc-kr";
  //다운로드
  @RequestMapping("/newdownload")
  @ResponseBody
  public static void newDownload(@RequestParam("path")String path, @RequestParam("fileName")String fileName,HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    if(path.contains("upload")){
      String upload = "upload";
      path = path.substring(upload.length()+1,path.length());
    }


    String fullPath = Global.UPLOAD_PATH + path ;

    if (Global.isDev) logger.info("fullPath={}", fullPath);
    File file = new File(fullPath);


    String mimetype = request.getSession().getServletContext().getMimeType(file.getName());

    if (file == null || !file.exists() || file.length() <= 0 || file.isDirectory()) {
      throw new BizException("파일 객체가 Null 혹은 존재하지 않거나 길이가 0, 혹은 파일이 아닌 디렉토리이다.");
    }

    InputStream is = null;

    try {
      is = new FileInputStream(file);
      download(request, response, is, fileName, file.length(), mimetype);
    } finally {
      try {
        is.close();
      } catch (Exception ex) {
      }
    }
  }

  /**
   * 해당 입력 스트림으로부터 오는 데이터를 다운로드 한다.
   *
   * @param request
   * @param response
   * @param is
   *            입력 스트림
   * @param filename
   *            파일 이름
   * @param filesize
   *            파일 크기
   * @param mimetype
   *            MIME 타입 지정
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is,
                              String filename, long filesize, String mimetype) throws ServletException, IOException {
    String mime = mimetype;

    if (mimetype == null || mimetype.length() == 0) {
      mime = "application/octet-stream;";
    }


    byte[] buffer = new byte[BUFFER_SIZE];

    response.setContentType(mime + "; charset=" + CHARSET);

    // 아래 부분에서 euc-kr 을 utf-8 로 바꾸거나 URLEncoding을 안하거나 등의 테스트를
    // 해서 한글이 정상적으로 다운로드 되는 것으로 지정한다.
    String userAgent = request.getHeader("User-Agent");

    // attachment; 가 붙으면 IE의 경우 무조건 다운로드창이 뜬다. 상황에 따라 써야한다.
    if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
      response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(filename, "utf-8") + ";");
//      logger.info("MSIE 5.5 filename={}", filename);

    } else if (userAgent != null && userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
      response.setHeader("Content-Disposition", "attachment; filename="
          + URLEncoder.encode(filename, "UTF-8") + ";");
//      logger.info("MS IE (보통은 6.x 이상 가정) filename={}", filename);
    } else { // 모질라나 오페라
      response.setHeader("Content-Disposition", "attachment; filename="
          + new String(filename.getBytes(CHARSET), "latin1") + ";");
//      logger.info("모질라나 오페라", filename);
    }

    // 파일 사이즈가 정확하지 않을때는 아예 지정하지 않는다.
    if (filesize > 0) {
      response.setHeader("Content-Length", "" + filesize);
    }

    BufferedInputStream fin = null;
    BufferedOutputStream outs = null;

    try {
      fin = new BufferedInputStream(is);
      outs = new BufferedOutputStream(response.getOutputStream());
      int read = 0;

      while ((read = fin.read(buffer)) != -1) {
        outs.write(buffer, 0, read);
      }
    } catch (IOException ex) {
      // Tomcat ClientAbortException을 잡아서 무시하도록 처리해주는게 좋다.
    } finally {
      try {
        outs.close();
      } catch (Exception ex1) {
      }

      try {
        fin.close();
      } catch (Exception ex2) {

      }
    } // end of try/catch
  }




  private String getBrowser(HttpServletRequest request) {
    String header =request.getHeader("User-Agent");
    if (header.contains("MSIE")) {
      return "MSIE";
    } else if(header.contains("Chrome")) {
      return "Chrome";
    } else if(header.contains("Opera")) {
      return "Opera";
    }
    return "Firefox";
  }
  
  
  //다운로드
//  @RequestMapping("/download")
//  @ResponseBody
//  public ModelAndView download(HttpServletRequest request) throws Exception{
//
//
//    DbMap map= fileservice.geFileInfo(request);
//
//    String path = (String)map.get("file_path") +(String)map.get("file_name");
//    String fileName =(String)map.get("file_original_name");
//
//
//    if(path.contains("upload")){
//      String upload = "upload";
//      path = path.substring(upload.length()+1,path.length());
//    }
//
//    ModelAndView mav = new ModelAndView();
//    mav.setView(downloadView);
//
//    String fullPath =Global.UPLOAD_PATH + path ;
//
//    if (Global.isDev) logger.info("fullPath={}", fullPath);
//
//    File file = new File(fullPath);
//
//    mav.addObject("downloadFile", file);
//    mav.addObject("fileName",fileName);
//    return mav;
//  }

}
