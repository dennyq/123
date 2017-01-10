package com.hs.util;

import java.text.DecimalFormat;

public class UnitUtil {

	public static <T> T cast(Object obj) {
		return (T)obj;
	}
	
	public static int toInt(Object obj) {
		if(obj == null) return 0;
		if(obj == "") return 0;
		return (int)Double.parseDouble(obj +"");
	}
	
	public static double toDouble(Object obj) {
		if(obj == null) return 0;
		else if (obj.equals("")) return  0;
		return Double.parseDouble(obj +"");
	}

	public static String convert(double doubleObj , String pattern )
			throws Exception
	{
		DecimalFormat df = new DecimalFormat(pattern) ;
		return df.format(doubleObj).toString() ;
	}

	public static double round(double d, int n) {
		return Math.round(d * Math.pow(10, n)) / Math.pow(10, n);
	}


    /*
      소수점 몇째자리 까지 절삭 하는 코드
      몇째자리 반올림은 DecimalFormat 의 Pattern  을 "#,##0.000" 정도
      주면 3 자리까지 반올림이 된다
      즉 convert( 12345.6789 ,"#,##0.000" )  -> 의 값은 12,345.679 가된다.
      따라서 반올림의 경우 convert 를 사용하고 ,
      절삭의 경우 convertFloor 를 사용하면 된다.
    */

	public static String convertFloor(double doubleObj , int position )
			throws Exception
	{

		String temp =  ""  ;
		String tempTwoDigit =  ""  ;
		int inx = 0 ;
		String patternAttachedZero = "" ;
		String point ="." ;

		if ( position < 0 )
			throw new Exception (" Position 을 0 이상으로 설정 하십시오 " );
		if ( position == 0 )  point="" ; // 소수점이 포함되어 나타나는것 방지

		temp =

				convert( doubleObj ,  "#.0000000000000000000000000000000000"  ) ;
		// BigDecimal 에서 표현하는 소수점 가장 끝자리까지 이므로
		//반올림되어 오류가 나는 소지를 최소화 한다.
		inx = temp.lastIndexOf( "." ) ;
		tempTwoDigit = temp.substring( 0, (( inx + 1 )  +  position ) ) ;

		for ( int i =0 ; i < position ; i++ ) {
			patternAttachedZero += "0" ;
		}

		return  convert(
				Double.parseDouble( tempTwoDigit )  ,
				"#,##0" + point +  patternAttachedZero
		) ;
	}
	
}
