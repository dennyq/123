package com.hs.web.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by bonbu on 2016-12-25.
 */
public class SessionListner implements HttpSessionListener {
   private static final Logger logger = LoggerFactory.getLogger(SessionListner.class);
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        // 세션 생성시 호출

        HttpSession session = httpSessionEvent.getSession();

        long time = session.getCreationTime();

        String id = session.getId();

        logger.info(time + "에 생성된 세션" + id);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        // 세션 만료시 호출

        HttpSession session = httpSessionEvent.getSession();

        long time = session.getCreationTime();

        long last_time = session.getLastAccessedTime();

        long now_time = System.currentTimeMillis();

        String id = session.getId();

        logger.info((now_time - last_time) + "ms 만에 세션이 죽음"  + id);


    }
}
