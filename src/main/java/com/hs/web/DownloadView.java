package com.hs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

@Component
public class DownloadView extends AbstractView {
  private static final Logger logger = LoggerFactory.getLogger(DownloadView.class);

  public DownloadView() {
    setContentType("application/download; charset=utf-8");
  }

  @Override
  protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    String fileName = (String) model.get("fileName");
    if (Global.isDev) logger.info("fileName={}", fileName);
    File file = (File) model.get("downloadFile");

    response.setContentType(getContentType());
    response.setContentLength((int) file.length());

    fileName = URLEncoder.encode(fileName, "utf-8");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
    response.setHeader("Content-Transfer-Encoding", "binary");

    OutputStream out = response.getOutputStream();
    FileInputStream fis = null;

    try {
      fis = new FileInputStream(file);
      FileCopyUtils.copy(fis, out);
    } finally {
      if (fis != null) {
        try {
          fis.close();
        } catch (IOException ioe) {
        }
      }
    }
    out.flush();
  }

}
