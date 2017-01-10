package com.hs.util;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;


public class DateUtil {
    private static final String dafaultFormat = "yyyyMMdd";

	public static String date(String pattern) {
		return date(pattern, 0);
	}
	
	public static String date(String pattern, int addDays) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, addDays);
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(cal.getTime());
	}

    public static String getCurrent(){
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat(dafaultFormat);
        return df.format(cal.getTime());
    }
    public static String getCurrentTime(){
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        return df.format(cal.getTime());
    }

    public static String getDate(String pattern, long timestamp)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(timestamp);
        SimpleDateFormat df = new SimpleDateFormat(pattern);
        return df.format(cal.getTime());
    }
    public static String getToday()
    {

		Date now = new Date();


		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
//    System.out.println(format.format(now)); // 20090529
//    format = new SimpleDateFormat("YYYY.MM.dd");
//    System.out.println(format.format(now)); // Fri May 29 11:06:29

		String today = format.format(now);
//        Calendar cal = Calendar.getInstance();
//        cal.setTimeInMillis(timestamp);
//        SimpleDateFormat df = new SimpleDateFormat(pattern);
//        return df.format(cal.getTime());
		return today;
    }

    public static long getTimeStamp(String pattern) throws Exception
    {
        return getTimeStamp(pattern, date(pattern));
    }

    public static long getTimeStamp(String pattern, String date) throws Exception
    {
        Date d = new SimpleDateFormat(pattern).parse(date);
        return d.getTime();
    }



  public static Date getAddDate(int amount){
    Calendar cal = Calendar.getInstance();
    Date curDate = cal.getTime();
    return DateUtils.addDays(curDate, amount);
  }

	public static String getAddDays(String format,int amount){
	    Date date = getAddDate(amount);
	    SimpleDateFormat df = new SimpleDateFormat(format);
	    return df.format(date);
	}
	
	
	public static int getManAge(String birth){
		
		String today = ""; //오늘 날짜
		int manAge = 0; //만 나이

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

		today = formatter.format(new Date()); //시스템 날짜를 가져와서 yyyyMMdd 형태로 변환

		//today yyyyMMdd
		int todayYear = Integer.parseInt( today.substring(0, 4) );
		int todayMonth = Integer.parseInt( today.substring(4, 6) );
		int todayDay = Integer.parseInt( today.substring(6, 8) );

		int ssnYear = Integer.parseInt( birth.substring(0, 4) );
		int ssnMonth = Integer.parseInt(birth.substring(4, 6) );
		int ssnDay = Integer.parseInt(birth.substring(6, 8) );

		
		manAge = todayYear - ssnYear;

		if( todayMonth < ssnMonth ){ //생년월일 "월"이 지났는지 체크
			manAge--;
		}else if( todayMonth == ssnMonth ){ //생년월일 "일"이 지났는지 체크
			if( todayDay < ssnDay ){
				manAge--; //생일 안지났으면 (만나이 - 1)
			}
		}

		return manAge;
	}


}
