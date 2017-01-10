package com.hs.util;

import java.text.NumberFormat;
import java.text.ParseException;


public class StringUtil {
	public static final String EMPTY = "";
	public static final int INDEX_NOT_FOUND = -1;
	private static final int PAD_LIMIT = 8192;
	
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}
	
	public static boolean isNotEmpty(String str) {
		return !isEmpty(str);
	}
	
	public static boolean isBlank(String str) {
		int strLen;
		if (str == null || (strLen = str.length()) == 0)
			return true;
		for (int i = 0; i < strLen; i++)
			if (!Character.isWhitespace(str.charAt(i)))
				return false;
	
		return true;
	}
	
	public static boolean isNotBlank(String str) {
		return !isBlank(str);
	}

	  public static boolean isNullOrEmpty(String source) {
	    if (source == null) return true;
	    if ("".equals(source)) return true;
	
	    return false;
	  }
	
	  public static String nvl(String str, String def) {
	    if (str == null || str=="") return def;
	
	    return str;
	  }

  /**
   * 양쪽으로 자리수만큼 문자 채우기
   *
   * @param str         원본 문자열
   * @param size        총 문자열 사이즈(리턴받을 결과의 문자열 크기)
   * @param strFillText 원본 문자열 외에 남는 사이즈만큼을 채울 문자
   * @return
   */
  public static String getCPad(String str, int size, String strFillText) {
    int intPadPos = 0;
    for (int i = (str.getBytes()).length; i < size; i++) {
      if (intPadPos == 0) {
        str += strFillText;
        intPadPos = 1;
      } else {
        str = strFillText + str;
        intPadPos = 0;
      }
    }
    return str;
  }


  /**
   * 왼쪽으로 자리수만큼 문자 채우기
   *
   * @param str         원본 문자열
   * @param size        총 문자열 사이즈(리턴받을 결과의 문자열 크기)
   * @param strFillText 원본 문자열 외에 남는 사이즈만큼을 채울 문자
   * @return
   */
  public static String getLPad(String str, int size, String strFillText) {
    for (int i = (str.getBytes()).length; i < size; i++) {
      str = strFillText + str;
    }
    return str;
  }


  /**
   * 오른쪽으로 자리수만큼 문자 채우기
   *
   * @param str         원본 문자열
   * @param size        총 문자열 사이즈(리턴받을 결과의 문자열 크기)
   * @param strFillText 원본 문자열 외에 남는 사이즈만큼을 채울 문자
   * @return
   */
  public static String getRPad(String str, int size, String strFillText) {
    for (int i = (str.getBytes()).length; i < size; i++) {
      str += strFillText;
    }
    return str;
  }

  /**
   * 주어진 숫자의 길이 만큼 랜덤한 문자열을 만들어 리턴.
   *
   * @param int (len)
   * @return String
   */
  public static String getRandomKey(int len) {
    String chararray = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    String ret = "";
    for (int i = 0; i < len; i++) {
      ret += chararray.charAt((int) (Math.random() * 100) % chararray.length());
    }
    return ret;
  }

  /**
   * 랜덤키 생성 '-' 포함
   *
   * @param len
   * @return String
   */
  public static String getRandomKey2(int len) {
    String chararray = "abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789";
    String ret = "";
    for (int i = 0; i < len; i++) {
      ret += chararray.charAt((int) (Math.random() * 100) % chararray.length());
    }
    return ret;
  }

  /**
   * 주어진 숫자의 길이 만큼 랜덤한 문자열(대문자와 숫자)을 만들어 리턴.
   *
   * @param int (len)
   * @return String
   */
  public static String getRandomKeyUpperCase(int len) {
    String chararray = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    String ret = "";
    for (int i = 0; i < len; i++) {
      ret += chararray.charAt((int) (Math.random() * 100) % chararray.length());
    }
    return ret;
  }

  /**
   * 임시 비밀번호 전송
   * @param len
   * @return STring
   */
  public static String getRandomPassword(int len) {
    String chararray = "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6";
    String ret = "";
    for(int i = 0; i < len; i++) {
      ret += chararray.charAt((int)(Math.random()*100)%chararray.length());
    }
    return ret;
  }
  
  /**
   * value값을 int형으로 리턴함. value가 유효하지 않은 경우 0을 리턴함.
   * 
   * @param value
   * @return
   */
  public static int parseInt(Object value) {
      return parseInt(value, 0);
  }

  /**
   * value값을 int형으로 리턴함. value가 유효하지 않은 경우 defaultValue를 리턴함.
   * 
   * @param value
   * @return
   */
  public static int parseInt(Object value, int defaultValue) {
      Number number = parseNumber(value);
      return number == null ? defaultValue : number.intValue();
  }
  
  /**
   * value값을 Number형으로 리턴함. value가 유효하지 않은 경우 null를 리턴함.
   * 
   * @param value
   * @return
   */
  public static Number parseNumber(Object value) {
      try {
          return NumberFormat.getInstance().parse(valueOf(value));
      }
      catch(ParseException e) {
          return null;
      }
  }
  
  
  /**
   * value를 String으로 변환해 줌.
   * 
   * @param value
   * @return
   */
  public static String valueOf(Object value) {
      return valueOf(value, String.valueOf((Object)null));
  }

  /**
   * value를 String으로 변환해 줌. vaule가 null이면 defaultValue를 리턴함.
   * 
   * @param value
   * @param defaultValue
   * @return
   */
  public static String valueOf(Object value, String defaultValue) {
      return value == null ? defaultValue : String.valueOf(value);
  }

  /**
   * value를 String으로 변환해 줌. vaule가 null이거나 공백이면 defaultValue를 리턴함.
   * 
   * <pre>
   * StringUtil.valueIfEmpty(null, &quot;NULL&quot;)  = &quot;NULL&quot;
   * StringUtil.valueIfEmpty(&quot;&quot;, &quot;NULL&quot;)    = &quot;NULL&quot;
   * StringUtil.valueIfEmpty(&quot;bat&quot;, &quot;NULL&quot;) = &quot;bat&quot;
   * </pre>
   * 
   * @param value
   * @param defaultValue
   * @return
   */
  public static String valueIfEmpty(Object value, String defaultValue) {
      return defaultIfEmpty(valueOf(value, ""), defaultValue);
  }
  
  
	public static String defaultString(String str) {
		return str != null ? str : "";
	}

	public static String defaultString(String str, String defaultStr) {
		return str != null ? str : defaultStr;
	}

	public static String defaultIfBlank(String str, String defaultStr) {
		return isBlank(str) ? defaultStr : str;
	}

	public static String defaultIfEmpty(String str, String defaultStr) {
		return isEmpty(str) ? defaultStr : str;
	}

	
	
	//nice 본인인증 
	public static String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }



}
