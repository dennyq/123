package com.hs.web;

import com.hs.util.HttpUtil;
import com.hs.web.service.EasySocket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.InetAddress;
import java.util.Properties;

@Component
public class Global {
  private final static Logger logger = LoggerFactory.getLogger(Global.class);
  public final static int DEFAULT_PAGE_SIZE = 30;
  public static boolean isDev;
  public static String UPLOAD_PATH;
  public static String SERVER_IP_ADDRESS;
  public static String SERVERENCODING ;
  public static int socketcnt=0;
  public static EasySocket[] m_eSocketReader;

  
  public final static String FONT_NAME = "굴림";// "백묵 굴림";//"맑은 고딕";//"돋움";// = "백묵 굴림";
  public Global() throws IOException {
    logger.warn("*=========================================================*");
    logger.warn("                interface server starting....");
    logger.warn("   file.encoding={}", System.getProperty("file.encoding"));
    SERVERENCODING =  System.getProperty("file.encoding").toUpperCase();
    // IS_TEST
    Properties prop = new Properties();
    prop.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("config.properties"));

    isDev = prop.getProperty("IS_DEV").equals("true");

    UPLOAD_PATH = prop.getProperty("UPLOAD_PATH");
    

    logger.warn("   isDev={}", isDev);
    logger.warn("   UPLOAD_PATH={}", UPLOAD_PATH);

    logger.warn("*=========================================================*");

    try {
      InetAddress ip = HttpUtil.getLocalHostLANAddress();
      SERVER_IP_ADDRESS = ip.getHostAddress();
    } catch (Exception e) {
      logger.error("", e);
      SERVER_IP_ADDRESS = "127.0.0.1";
    }


  }


}
