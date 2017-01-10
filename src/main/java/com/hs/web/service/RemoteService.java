package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.RemoteMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.net.SocketTimeoutException;


@Service
public class RemoteService extends ServiceBase {

    private static final Logger logger = LoggerFactory.getLogger(RemoteService.class);
    @Autowired
    private RemoteMapper mapper;
    private EasySocket[] m_eSocketReader;
    private String mMemberID ;//
    public void getBase(Model model, HttpSession session, RequestMap req) {
        if(req.get("login_uip")==null || req.get("login_uport")==null){
            model.addAttribute("needSetting", "Y");
        }else {
            int connectVal = getConnection(req, session);
            if (connectVal == 1) {
                String laborState = getLaborState(req, session);
                String onOffState = getOnOffState(req, session);

                if (!laborState.equals("Error") && !laborState.equals("")) {
                    DbMap laborStates = new DbMap();
                    for (int i = 0; i < laborState.length(); i++) {
                        laborStates.put("channel" + (i + 1), laborState.charAt(i) + "");
                    }
                    model.addAttribute("laborStates", laborStates);
                }


                if (!onOffState.equals("Error") && !onOffState.equals("")) {
                    DbMap onOffStates = new DbMap();

                    for (int i = 0; i < onOffState.length(); i++) {
                        onOffStates.put("channel" + (i + 1), onOffState.charAt(i) + "");
                    }
                    //정역정보
                    model.addAttribute("onOffStates", onOffStates);
                }

            } else {
                model.addAttribute("connectVal", "fail");
            }
        }

        model.addAttribute("heatrecoverystate", getHeatrecoverystate(req, session).get("data"));
        //공기유동팬상태정보
        DbMap airfandata = getAirfanstate(req, session);
        model.addAttribute("airfanstate", airfandata.get("data"));
        model.addAttribute("angleList", airfandata.get("angleList"));
    }

    //  열회수형환풍기상태정보
    public int getConnection(RequestMap req,HttpSession session) {
        int result = 0;
        if(req.get("login_uid") != null) {//세션이 살아있다면
            logger.info("getConnection m_eSocketReader ={}",m_eSocketReader );
            if(req.get("login_socket")==null){

                logger.info("getConnection 세션에리더저장된 m_eSocketReader 없음");

            }else{
                m_eSocketReader = getSocketReader(req);
                logger.info("getConnection 세션에리더저장 m_eSocketReader 있음");
            }

            String id = req.get("login_uid")+"";
            String ip = req.get("login_uip")+"";
            int port = Integer.parseInt(req.get("login_uport")+"");
            mMemberID = id;

            result = connectSocket(ip, port, id);



        }
        return result;
    }



    //// 세션저장된 소켓리더
    public EasySocket[] getSocketReader(RequestMap req) {
        m_eSocketReader = (EasySocket[]) req.get("login_socket");
        return m_eSocketReader;
    }


    //// 정역제어 상태 얻기
    public String getLaborState(RequestMap req,HttpSession session) {
        String strRet = "";
        m_eSocketReader = getSocketReader(req);

        //// 정역제어 상태 얻기
        if(m_eSocketReader[0]!=null){
            strRet = m_eSocketReader[0].GetLaborState(30);
        }

        logger.info("remote GetLaborState strRet={}", strRet);
        return strRet;
    }

    //// 정역제어 상태 얻기
    public String getOnOffState(RequestMap req,HttpSession session) {
        String strRet = "";
        m_eSocketReader = getSocketReader(req);

        //// 정역제어 상태 얻기
        if(m_eSocketReader[0]!=null){
            strRet = m_eSocketReader[0].GetOnOffState(30);
        }

        logger.info("remote GetOnOffState strRet={}", strRet);
        return strRet;
    }


    //  열회수형환풍기상태정보
    public ResultMap getHeatrecoverystate(RequestMap req, HttpSession session) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[remote getHeatrecoverystate] recv:{}", req);

        String strRet = "";
        m_eSocketReader = getSocketReader(req);

        //// 정역제어 상태 얻기
        if (m_eSocketReader[0] != null) {
            strRet = m_eSocketReader[0].GetHeatRecoveryState(30);

            if(!strRet.equals("Error")){
                DbMap data = new DbMap();

                data.put("temperature", strRet.length() >= 2 ? Integer.parseInt(strRet.substring(0, 2)) : 0);
                data.put("humidity", strRet.length() >= 5 ? Integer.parseInt(strRet.substring(2, 5)) : 0);
                data.put("discharge", strRet.length() >= 7 ? Integer.parseInt(strRet.substring(5, 7)) : 0);
                data.put("state", strRet.length() >= 8 ? Integer.parseInt(strRet.substring(7, 8)) : 0);

                res.put("data", data);
            }else {
                DbMap data = new DbMap();
                data.put("temperature", 0);
                data.put("humidity", 0);
                data.put("discharge", 0);
                data.put("state",  0);


                res.put("data", data);
            }

        }


        if (Global.isDev) logger.debug("[remote getHeatrecoverystate] send:{}", res);
        return res;
    }

    //  공기유동팬상태정보
    public ResultMap getAirfanstate(RequestMap req, HttpSession session) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[remote getHeatrecoverystate] recv:{}", req);

        String strRet = "";
        m_eSocketReader = getSocketReader(req);

        //// 정역제어 상태 얻기
        if (m_eSocketReader[0] != null) {
            strRet = m_eSocketReader[0].GetAirFanState(30);
            if(!strRet.equals("Error")){

                DbMap data = new DbMap();
                data.put("angle", strRet.length() >= 1 ? Integer.parseInt(strRet.substring(0, 1)) : 0);
                data.put("temperature", strRet.length() >= 3 ? Integer.parseInt(strRet.substring(1, 3)) : 0);
                data.put("state", strRet.length() >= 4 ? Integer.parseInt(strRet.substring(3, 4)) : 0);
                res.put("data", data);
            }else {
                DbMap data = new DbMap();
                data.put("angle", 0);
                data.put("temperature", 0);
                data.put("state", 0);
                res.put("data", data);
            }
        }
        DbList angleList = getAngleList();

        res.put("angleList", angleList);

        if (Global.isDev) logger.debug("[remote getAirfanstate] send={}", res);
        return res;
    }


    public DbMap getMemberIp(RequestMap req) {


        return mapper.getMemberIp(req);
    }

    //// 공기유동팬 상태 얻기
    public DbList getAngleList()
    {

        String angleStr[] = {"", "상향", "중간", "하향", "회전"};
        DbList angleList = new DbList();
        for (int i = 0; i < angleStr.length; i++) {
            DbMap angleMap = new DbMap();
            angleMap.put("code", (i) + "");
            angleMap.put("angleStr", angleStr[i]);
            angleList.add(angleMap);
        }
        logger.debug("angleList={}", angleList);
        return angleList;
    }

    //열회수형
    public ResultMap setHeatrecoverystate(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[remote setHeatrecoverystate] recv:{}", req);
        mMemberID = req.get("login_uid") + "";
        m_eSocketReader = getSocketReader(req);
        String retVal = setHeatRecoveryState(req);

        res.put("retVal", retVal);

        if (Global.isDev) logger.debug("[remote setHeatrecoverystate] send:{}", res);
        return res;
    }

    //공기유동팬
    public ResultMap setAirfanstate(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[remote setAirfanstate] recv:{}", req);
        m_eSocketReader = getSocketReader(req);
        mMemberID = req.get("login_uid") + "";
        req.put("temperature", req.get("temperature2"));

        String retVal = setAirFanState(req);
        res.put("retVal", retVal);

        if (Global.isDev) logger.debug("[remote setAirfanstate] send:{}", res);
        return res;
    }


    //// 공기유동팬 상태 설정
    private String setAirFanState(RequestMap req) {
        String strRet;

        //// 각도
        byte[] bAngle = new byte[1];
        int angle = Integer.parseInt(req.get("angle") + "");
        switch (angle) {
            case 1:
                bAngle[0] = (byte) '1';
                break;
            case 2:
                bAngle[0] = (byte) '2';
                break;
            case 3:
                bAngle[0] = (byte) '3';
                break;
            case 4:
                bAngle[0] = (byte) '4';
                break;
            default:
                bAngle[0] = (byte) '0';
        }
        byte[] bTemperature = new byte[2];

        int temperatureNo = Integer.parseInt(req.get("temperature") + "");

        String temperature = String.format("%02d", temperatureNo);
        String temperature1 = temperature.substring(0, 1);
        String temperature2 = temperature.substring(1, 2);


        if (temperature1.equals("0")) {
            bTemperature[0] = (byte) '0';
        } else if (temperature1.equals("1")) {
            bTemperature[0] = (byte) '1';
        } else if (temperature1.equals("2")) {
            bTemperature[0] = (byte) '2';
        } else if (temperature1.equals("3")) {
            bTemperature[0] = (byte) '3';
        } else if (temperature1.equals("4")) {
            bTemperature[0] = (byte) '4';
        } else if (temperature1.equals("5")) {
            bTemperature[0] = (byte) '5';
        } else if (temperature1.equals("6")) {
            bTemperature[0] = (byte) '6';
        } else if (temperature1.equals("7")) {
            bTemperature[0] = (byte) '7';
        } else if (temperature1.equals("8")) {
            bTemperature[0] = (byte) '8';
        } else if (temperature1.equals("9")) {
            bTemperature[0] = (byte) '9';
        } else {
            bTemperature[0] = (byte) '0';
        }
        if (temperature2.equals("0")) {
            bTemperature[1] = (byte) '0';
        } else if (temperature2.equals("1")) {
            bTemperature[1] = (byte) '1';
        } else if (temperature2.equals("2")) {
            bTemperature[1] = (byte) '2';
        } else if (temperature2.equals("3")) {
            bTemperature[1] = (byte) '3';
        } else if (temperature2.equals("4")) {
            bTemperature[1] = (byte) '4';
        } else if (temperature2.equals("5")) {
            bTemperature[1] = (byte) '5';
        } else if (temperature2.equals("6")) {
            bTemperature[1] = (byte) '6';
        } else if (temperature2.equals("7")) {
            bTemperature[1] = (byte) '7';
        } else if (temperature2.equals("8")) {
            bTemperature[1] = (byte) '8';
        } else if (temperature2.equals("9")) {
            bTemperature[1] = (byte) '9';
        } else {
            bTemperature[1] = (byte) '0';
        }


        //// 공기유동팬 상태 설정, 각도(상향), 온도(31도)로 설정
        strRet = m_eSocketReader[0].SetAirFanState(bAngle, bTemperature, 30);

        return strRet;
    }

    public boolean checkIP(RequestMap req) {
        boolean isCheckedIp = true;
        if (req.get("login_uip") == null || req.get("login_uport") == null) {
            isCheckedIp = false;
        }
        if (Global.isDev) logger.debug("[remote checkIP]={}", isCheckedIp);
        return isCheckedIp;
    }

    //// 열회수형환풍기 상태 설정
    public String setHeatRecoveryState(RequestMap req)
    {

        byte[] bTemperature = new byte[2];

        int temperatureNo = Integer.parseInt(req.get("temperature") + "");

        String temperature = String.format("%02d", temperatureNo);
        String temperature1 = temperature.substring(0, 1);
        String temperature2 = temperature.substring(1, 2);


        if (temperature1.equals("0")) {
            bTemperature[0] = (byte) '0';
        } else if (temperature1.equals("1")) {
            bTemperature[0] = (byte) '1';
        } else if (temperature1.equals("2")) {
            bTemperature[0] = (byte) '2';
        } else if (temperature1.equals("3")) {
            bTemperature[0] = (byte) '3';
        } else if (temperature1.equals("4")) {
            bTemperature[0] = (byte) '4';
        } else if (temperature1.equals("5")) {
            bTemperature[0] = (byte) '5';
        } else if (temperature1.equals("6")) {
            bTemperature[0] = (byte) '6';
        } else if (temperature1.equals("7")) {
            bTemperature[0] = (byte) '7';
        } else if (temperature1.equals("8")) {
            bTemperature[0] = (byte) '8';
        } else if (temperature1.equals("9")) {
            bTemperature[0] = (byte) '9';
        } else {
            bTemperature[0] = (byte) '0';
        }
        if (temperature2.equals("0")) {
            bTemperature[1] = (byte) '0';
        } else if (temperature2.equals("1")) {
            bTemperature[1] = (byte) '1';
        } else if (temperature2.equals("2")) {
            bTemperature[1] = (byte) '2';
        } else if (temperature2.equals("3")) {
            bTemperature[1] = (byte) '3';
        } else if (temperature2.equals("4")) {
            bTemperature[1] = (byte) '4';
        } else if (temperature2.equals("5")) {
            bTemperature[1] = (byte) '5';
        } else if (temperature2.equals("6")) {
            bTemperature[1] = (byte) '6';
        } else if (temperature2.equals("7")) {
            bTemperature[1] = (byte) '7';
        } else if (temperature2.equals("8")) {
            bTemperature[1] = (byte) '8';
        } else if (temperature2.equals("9")) {
            bTemperature[1] = (byte) '9';
        } else {
            bTemperature[1] = (byte) '0';
        }


        int humidityNo = Integer.parseInt(req.get("humidity") + "");

        String humidity = String.format("%03d", humidityNo);
        String humidity1 = humidity.substring(0, 1);
        String humidity2 = humidity.substring(1, 2);
        String humidity3 = humidity.substring(2, 3);


        //// 습도(100%)
        byte[] bHumidity = new byte[3];

        if (humidity1.equals("0")) {
            bHumidity[0] = (byte) '0';
        } else if (humidity1.equals("1")) {
            bHumidity[0] = (byte) '1';
        } else if (humidity1.equals("2")) {
            bHumidity[0] = (byte) '2';
        } else if (humidity1.equals("3")) {
            bHumidity[0] = (byte) '3';
        } else if (humidity1.equals("4")) {
            bHumidity[0] = (byte) '4';
        } else if (humidity1.equals("5")) {
            bHumidity[0] = (byte) '5';
        } else if (humidity1.equals("6")) {
            bHumidity[0] = (byte) '6';
        } else if (humidity1.equals("7")) {
            bHumidity[0] = (byte) '7';
        } else if (humidity1.equals("8")) {
            bHumidity[0] = (byte) '8';
        } else if (humidity1.equals("9")) {
            bHumidity[0] = (byte) '9';
        } else {
            bHumidity[0] = (byte) '0';
        }
        if (humidity2.equals("0")) {
            bHumidity[1] = (byte) '0';
        } else if (humidity2.equals("1")) {
            bHumidity[1] = (byte) '1';
        } else if (humidity2.equals("2")) {
            bHumidity[1] = (byte) '2';
        } else if (humidity2.equals("3")) {
            bHumidity[1] = (byte) '3';
        } else if (humidity2.equals("4")) {
            bHumidity[1] = (byte) '4';
        } else if (humidity2.equals("5")) {
            bHumidity[1] = (byte) '5';
        } else if (humidity2.equals("6")) {
            bHumidity[1] = (byte) '6';
        } else if (humidity2.equals("7")) {
            bHumidity[1] = (byte) '7';
        } else if (humidity2.equals("8")) {
            bHumidity[1] = (byte) '8';
        } else if (humidity2.equals("9")) {
            bHumidity[1] = (byte) '9';
        } else {
            bHumidity[1] = (byte) '0';
        }
        if (humidity3.equals("0")) {
            bHumidity[2] = (byte) '0';
        } else if (humidity3.equals("1")) {
            bHumidity[2] = (byte) '1';
        } else if (humidity3.equals("2")) {
            bHumidity[2] = (byte) '2';
        } else if (humidity3.equals("3")) {
            bHumidity[2] = (byte) '3';
        } else if (humidity3.equals("4")) {
            bHumidity[2] = (byte) '4';
        } else if (humidity3.equals("5")) {
            bHumidity[2] = (byte) '5';
        } else if (humidity3.equals("6")) {
            bHumidity[2] = (byte) '6';
        } else if (humidity3.equals("7")) {
            bHumidity[2] = (byte) '7';
        } else if (humidity3.equals("8")) {
            bHumidity[2] = (byte) '8';
        } else if (humidity3.equals("9")) {
            bHumidity[2] = (byte) '9';
        } else {
            bHumidity[2] = (byte) '0';
        }


        //// 토출 온도(17도)
        byte[] bDisCharge = new byte[2];

        int dischargeNo = Integer.parseInt(req.get("discharge") + "");

        String discharge = String.format("%02d", dischargeNo);
        String discharge1 = discharge.substring(0, 1);
        String discharge2 = discharge.substring(1, 2);

        if (discharge1.equals("0")) {
            bDisCharge[0] = (byte) '0';
        } else if (discharge1.equals("1")) {
            bDisCharge[0] = (byte) '1';
        } else if (discharge1.equals("2")) {
            bDisCharge[0] = (byte) '2';
        } else if (discharge1.equals("3")) {
            bDisCharge[0] = (byte) '3';
        } else if (discharge1.equals("4")) {
            bDisCharge[0] = (byte) '4';
        } else if (discharge1.equals("5")) {
            bDisCharge[0] = (byte) '5';
        } else if (discharge1.equals("6")) {
            bDisCharge[0] = (byte) '6';
        } else if (discharge1.equals("7")) {
            bDisCharge[0] = (byte) '7';
        } else if (discharge1.equals("8")) {
            bDisCharge[0] = (byte) '8';
        } else if (discharge1.equals("9")) {
            bDisCharge[0] = (byte) '9';
        } else {
            bDisCharge[0] = (byte) '0';
        }
        if (discharge2.equals("0")) {
            bDisCharge[1] = (byte) '0';
        } else if (discharge2.equals("1")) {
            bDisCharge[1] = (byte) '1';
        } else if (discharge2.equals("2")) {
            bDisCharge[1] = (byte) '2';
        } else if (discharge2.equals("3")) {
            bDisCharge[1] = (byte) '3';
        } else if (discharge2.equals("4")) {
            bDisCharge[1] = (byte) '4';
        } else if (discharge2.equals("5")) {
            bDisCharge[1] = (byte) '5';
        } else if (discharge2.equals("6")) {
            bDisCharge[1] = (byte) '6';
        } else if (discharge2.equals("7")) {
            bDisCharge[1] = (byte) '7';
        } else if (discharge2.equals("8")) {
            bDisCharge[1] = (byte) '8';
        } else if (discharge2.equals("9")) {
            bDisCharge[1] = (byte) '9';
        } else {
            bDisCharge[1] = (byte) '0';
        }


        //// 열회수형환풍기 상태 설정. 온도(31도), 습도(100%), 토출온도(17도)로 설정
        //// 열회수형환풍기 상태 설정. 온도(31도), 습도(100%), 토출온도(17도)로 설정
        //    if	( strRet.equals("Error") )
//    {
//      return "Error";
//    }
        return m_eSocketReader[0].SetHeatRecoveryState(bTemperature, bHumidity, bDisCharge, 30);
    }


    public String setOneLaborState(RequestMap req) {
        String strRet ="";

        int state = Integer.parseInt(req.get("state") + "");
        //// 패킷
        byte[] bCS = new byte[1];

        switch (state) {
            case 0:
                bCS[0] = (byte) '0';
                break;
            case 1:
                bCS[0] = (byte) '1';
                break;
            case 2:
                bCS[0] = (byte) '2';
                break;
            case 3:
                bCS[0] = (byte) '3';
                break;
            case 4:
                bCS[0] = (byte) '4';
                break;
            case 5:
                bCS[0] = (byte) '5';
                break;
            default:
                bCS[0] = (byte) '0';
        }


        int channel = Integer.parseInt(req.get("channel") + "");

        //// 정역제어 1개 채널 상태 설정, 2번째 채널을 자동('1')로 설정
        if(m_eSocketReader[0]!=null){
            strRet = m_eSocketReader[0].SetOneLaborState(channel - 1, bCS, 30);
        }


        return strRet;
    }

    public String setOneOnOffState(RequestMap req) {
        String strRet ="";

        byte[] bCS = new byte[1];
        bCS[0] = (byte) '1';
        int state = Integer.parseInt(req.get("state") + "");
        int channel = Integer.parseInt(req.get("channel") + "");
        switch (state) {
            case 0:
                bCS[0] = (byte) '0';
                break;
            case 1:
                bCS[0] = (byte) '1';
                break;
            case 2:
                bCS[0] = (byte) '2';
                break;
            case 3:
                bCS[0] = (byte) '3';
                break;
            case 4:
                bCS[0] = (byte) '4';
                break;
            case 5:
                bCS[0] = (byte) '5';
                break;
            default:
                bCS[0] = (byte) '0';
        }
        logger.info("setOneOnOffState state={}", state);
        //// ON-OFF제어 1개 채널 상태 설정, 3번째 채널을 자동('1')로 설정


        if(m_eSocketReader[0]!=null){
            strRet = m_eSocketReader[0].SetOneOnOffState(channel - 1, bCS, 30);
        }
        return strRet;
    }

    //// 소켓 연결
    public int connectSocket(String ip, int port, String memberId) {
        //// 이미 소켓 생성되어 있으면
        if	( m_eSocketReader[0] != null )
        {
            //// connected 되었으면 true
            if	( m_eSocketReader[0].isConnectedSocket() == true )
            {
                return 1;
            }
        }
        //// 소켓이 생성되어 있지 않으면 소켓 생성
        else
        {
            m_eSocketReader[0] = new EasySocket();

            //// connect
            boolean bU = m_eSocketReader[0].connectionSocket(ip, port);
            if	(  bU == true )
            {
                //// 연결 성공

                //// sleep
                try { Thread.sleep(500); } catch (InterruptedException e) { e.printStackTrace(); }

                //// 회원아이디 입력

                m_eSocketReader[0].SetMemberID(memberId);

                return 1;
            }
            else
            {
                m_eSocketReader[0] = null;
            }
        }

        return 0;
    }

    //// 소켓 닫기
    public void closeSocket(RequestMap req)
    {
        //// 소켓 connected 되었으면 true
        logger.info("====closeSocket=====!");
        m_eSocketReader = getSocketReader(req);
        if	( m_eSocketReader[0] != null )
        {
            if	( m_eSocketReader[0].isConnectedSocket() == true )
            {
                m_eSocketReader[0].disconnectionSocket();
            }
            else
            {
            }

            try { Thread.sleep(500); } catch (InterruptedException e) { e.printStackTrace(); }



            m_eSocketReader[0] = null;
            logger.info("소켓종료!");
        }
    }


}
