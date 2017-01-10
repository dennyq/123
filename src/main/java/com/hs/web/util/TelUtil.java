package com.hs.web.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by paper on 2014. 6. 16..
 */
public class TelUtil {
    private final static Logger logger = LoggerFactory.getLogger(TelUtil.class);

    public static String[] splitTelNumber(String telNumber) {
        String[] res = new String[3];
        res[0] = "";
        res[1] = "";
        res[2] = "";

        if(telNumber == null) return res;

        if(telNumber.indexOf("-") > -1) {
            telNumber = telNumber.replaceAll("-", "");
        }

        res[0] = telNumber.substring(0, 3);
        telNumber = telNumber.substring(3);

        int j = 2, k=0;
        char[] telNumberCharList = telNumber.toCharArray();
        for(int i = telNumberCharList.length-1;i>=0;i--) {
            res[j] = telNumberCharList[i] + "" + res[j];
            k++;
            if(k>=4) {
                j--;
                k = 0;
            }
            if(j<1) break;
        }

        return res;
    }
}
