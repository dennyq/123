package com.hs.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;

public class SessionUtil {
	private static final Logger logger = LoggerFactory.getLogger(SessionUtil.class);

  public static Long getUserNo(HttpServletRequest request) {
		BigInteger member_no = (BigInteger) request.getSession().getAttribute("member_no");
    return  member_no.longValue();
	}

	public static String getUserId(HttpServletRequest request) {
    return  (String) request.getSession().getAttribute("member_email");
	}

  public static String getUserStatus(HttpServletRequest request) {
    return (String) request.getSession().getAttribute("member_status");
  }

  public static String getUserEmail(HttpServletRequest request) {
    return (String) request.getSession().getAttribute("member_email");
  }

	public static String getUserName(HttpServletRequest request) {
		return  (String) request.getSession().getAttribute("member_nm");
	}
	
//	public static String getUserRole(HttpServletRequest request) {
//		return (String) request.getSession().getAttribute("user_role");
//	}
//
//	public static String getUserRoleName(HttpServletRequest request) {
//		return (String) request.getSession().getAttribute("user_role_name");
//	}
	
	public static String getUserIsAdmin(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("isAdmin");
	}
	
	// Check Login Flag
	public static boolean isLogIn(HttpServletRequest request) {
		String user_id = getUserId(request);
		if (user_id == null || user_id.equals("")) {
			return false;
		}
		return true;
	}

	// Log out Action
	public static boolean LogOut(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		session.invalidate();
		return true;
	}
}