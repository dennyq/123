package com.hs.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.List;


/*------------------------------------------------------------------------------------------------------------------------------------------+
|  소켓 통신 클래스(EasySocket.java)																						2011.03.30(수)	|
+-------------------------------------------------------------------------------------------------------------------------------------------+
|																																			|
+------------------------------------------------------------------------------------------------------------------------------------------*/
@Component
public class 	EasySocket
{
	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  전역 변수 선언																														|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	private  boolean 		mConnectedSocketflag  = false;										// connection 유무
	public	 String			error				= "";												// 에러 메세지											// 인터페이스
	private  Socket			mSocket				= null;												// 소켓(데이타)
	private  PrintWriter	out					= null;									// 전송스트림(데이타)
	private  ReceiveSocketThread	mReceiveSocketThread  = null;										// 쓰레드(수신)

	private  String                 mMemberID                       = "";									// 회원아이디
	private  boolean                m_bCommand                      = false;								// 명령 수행
	private  String                 mRequestRet			= "";									// 명령 요청 결과
	private static final Logger logger = LoggerFactory.getLogger(EasySocket.class);

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  클래스 생성자																														|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public EasySocket()
	{

	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  이미 연결되어 있는지 확인																														|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public boolean isConnectedSocket()
	{
		return mConnectedSocketflag;
	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  서버에 소켓을 연결한다.																												|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public boolean connectionSocket(String ip)
	{
		return connectionSocket(ip, 4352);			//// port(4352)는 PJLink 사용 시 port임
	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  서버에 소켓을 연결한다.																												|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public boolean connectionSocket(String ip, int port)
	{
		if	( mSocket == null )
		{
			//// 소켓 개체 생성
			mSocket	= new Socket();
			//// READ 타임아웃 설정
			try
			{
				mSocket.setSoTimeout(5000);
			}
			catch (SocketException e)
			{
				e.printStackTrace();
				//// error          = "소켓 환경 구성 중 오류가 발생하였습니다.";
				mSocket        		 = null;
				mConnectedSocketflag = false;
				return false;
			}

			//// 소켓 연결
			try
			{
				SocketAddress address = new InetSocketAddress(ip, port);
				mSocket.connect(address, 5000);
			}
			catch (IOException e)
			{
				e.printStackTrace();
				//// error          = "소켓 연결 중 오류가 발생하였습니다.";
				mSocket              = null;
				mConnectedSocketflag = false;
				return false;
			}

			//// 출력 스트림 생성
			try
			{
				out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(mSocket.getOutputStream(), "UTF-8")), true);
			}
			catch (UnsupportedEncodingException e)
			{
				e.printStackTrace();
				mSocket              = null;
				mConnectedSocketflag = false;
				return false;
			}
			catch (IOException e)
			{
				e.printStackTrace();
				mSocket              = null;
				mConnectedSocketflag = false;
				return false;
			}

			//// 수신 쓰레드 생성
			mReceiveSocketThread = new ReceiveSocketThread();
			//// 수신 쓰레드 제어
			mReceiveSocketThread.start();

			mConnectedSocketflag = true;
		}

		return true;
	}

	//// 회원아이디 입력
	public void SetMemberID(String id)
	{
		mMemberID = id;
	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  서버에 데이타를 전송한다.																											|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public boolean sendSocket(String data)
	{
		boolean bRet = false;

		if	( mSocket != null )
		{
			try
			{
				//// byte로 변환
				byte[] buffer = data.getBytes("UTF-8");
				//// 길이만큼 byte를 넣어줌
				//// byte[] byteFix = CutLen(buffer, 200);

				//// 데이터 전송
				bRet = sendByBytes(buffer);
			}
			catch (UnsupportedEncodingException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return bRet;
	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  서버에 데이타를 전송한다.																											|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public boolean sendByBytes(byte[] data)
	{
		boolean bRet = false;

		int Len = data.length;

		if	( mSocket != null )
		{
			try
			{
				mSocket.getOutputStream().write(data);
				mSocket.getOutputStream().flush();

				bRet = true;
			}
			catch (IOException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();

				//// 연결된 소켓을 끊는다.
				disconnectionSocket();
			}
		}

		return bRet;
	}


	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  연결된 소켓을 끊는다.																												|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	public void disconnectionSocket()
	{
		try
		{
			if	( mReceiveSocketThread != null )
			{
				mReceiveSocketThread.interrupt();
			}

			if	( mSocket != null )
			{

				mSocket.close();
				mSocket = null;


			}

			mConnectedSocketflag = false;
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	//// 정역제어 상태 얻기
	public String GetLaborState(int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-30s", "                              ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s", new String("SC01"), sMemberID, sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// ON-OFF제어 상태 얻기
	public String GetOnOffState(int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-30s", "                              ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s", new String("SC04"), sMemberID, sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// 정역제어 1개 채널 상태 설정
	public String SetOneLaborState(int CN, byte[] CS, int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// 채널번호
		String sChannelNumber = String.format("%1d", CN);
		//// etc
		String sEtc = String.format("%-28s", "                            ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s%s%s", new String("SC02"), sMemberID, sChannelNumber, new String(CS), sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// ON-OFF제어 1개 채널 상태 설정
	public String SetOneOnOffState(int CN, byte[] CS, int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// 채널번호
		String sChannelNumber = String.format("%1d", CN);
		//// etc
		String sEtc = String.format("%-28s", "                            ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s%s%s", new String("SC05"), sMemberID, sChannelNumber, new String(CS), sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// 공기유동팬 상태 얻기
	public String GetAirFanState(int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-30s", "                              ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s", new String("SC07"), sMemberID, sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// 열회수형환풍기 상태 얻기
	public String GetHeatRecoveryState(int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-30s", "                              ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s", new String("SC09"), sMemberID, sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// 공기유동팬 상태 설정
	public String SetAirFanState(byte[] bAngle, byte[] bTemperature, int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-27s", "                                  ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s%s%s", new String("SC08"), sMemberID, new String(bAngle), new String(bTemperature), sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	//// 열회수형환풍기 상태 설정
	public String SetHeatRecoveryState(byte[] bTemperature, byte[] bHumidity, byte[] bDisCharge, int TimeOut)
	{
		//// 회원아이디
		String sMemberID = String.format("%-10s", mMemberID);
		//// etc
		String sEtc = String.format("%-23s", "                                  ");

		//// 패킷 조합
		String sPacket = String.format("%s%s%s%s%s%s", new String("SC10"), sMemberID, new String(bTemperature), new String(bHumidity), new String(bDisCharge), sEtc);

		//// 명령 수행
		m_bCommand  = true;
		mRequestRet = "";

		//// 메시지 전송
		boolean bSnd = sendSocket(sPacket);
		if	( bSnd )
		{
			for ( int i = 0; i < TimeOut; i++ )
			{
				//// sleep
    				try { Thread.sleep(100); } catch (InterruptedException e) { e.printStackTrace(); }

    				//// 명령 받으면
    				if	( m_bCommand == false )
    				{
    					break;
    				}
			}

			//// 명령 받으면
    			if	( m_bCommand == false )
    			{
    				return mRequestRet;
    			}

    			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
		else
		{
			//// 명령 수행 취소
			m_bCommand = false;

			return "Error";
		}
	}

	/*--------------------------------------------------------------------------------------------------------------------------------------+
	|  수신된 데이타를 처리한다.																											|
	+--------------------------------------------------------------------------------------------------------------------------------------*/
	private class ReceiveSocketThread extends Thread
	{
		BufferedReader 	in  = null;
		//// thread running
		boolean m_bRunning = true;

		public  byte[]	byte_get = new byte[200];

		//// stop thread
		public void stopThread()
		{
			this.m_bRunning = false;
		}

		//// run
		public void run()
		{
			while ( m_bRunning == true )
			{
				try
				{
					int size = mSocket.getInputStream().read(byte_get);
					if	( size <= 0 )	break;

					//System.out.println(size);

					//// 받은 데이터를 파싱한다
					if	( size >= 44 )
					{
						if	( byte_get[0] == (byte)('C') && byte_get[1] == (byte)('S') )
						{
							//System.out.println("A-"+size);
							parseSocketData(size, byte_get);
						}														// 받은 데이터를 파싱한다
					}
				}
				catch (SocketTimeoutException e)
				{												// read timeout 발생
					if (Thread.currentThread().isInterrupted()) break;								// 인터럽트 발생
				}
				catch (UnsupportedEncodingException e)
				{											// 지원하지 않는 인코딩 방식
					break;
				}
				catch (IOException e)
				{															// 기타 오류
					break;
				}

				try
				{
					sleep(10);
				}
				catch (InterruptedException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
					break;
				}
			}

			mReceiveSocketThread = null;

			//// disconnectionSocket
			disconnectionSocket();																		// 소켓 연결 종료
		}
	}

	//// 받은 데이터를 파싱한다
	void parseSocketData(int size, byte[] data)
	{
		String strData = new String(data);

		//System.out.println("parseSocketData-"+strData);

		//// 정역제어 상태 요청 결과
		if	( strData.substring(0,4).equals("CS01") )
		{
			//System.out.println("parseSocketData(CS01)-"+strData);
			mRequestRet = strData.substring(4,14);
		}

		//// ON-OFF 제어 상태 요청 결과
		if	( strData.substring(0,4).equals("CS02") )
		{
			//System.out.println("parseSocketData(CS02)-"+strData);
			mRequestRet = strData.substring(4,14);
		}

		//// 공기유동팬 상태 요청 결과
		if	( strData.substring(0,4).equals("CS03") )
		{
			//System.out.println("parseSocketData(CS01)-"+strData);
			mRequestRet = strData.substring(4,8);
		}

		//// 열회수형환풍기 상태 요청 결과
		if	( strData.substring(0,4).equals("CS04") )
		{
			//System.out.println("parseSocketData(CS01)-"+strData);
			mRequestRet = strData.substring(4,12);
		}

		//// 명령 수행 완료
		m_bCommand = false;
	}


	/**
	* str : 원문 String
	* pt1 : 자르기 시작 위치
	* pt2 : 자르기 끝 위치
	*/
	public static String strHangleByteCutToString(String str, int pt1, int pt2)
	{
		StringBuffer strBuf = new StringBuffer();
		try
		{
			byte[] byteHangle = str.getBytes("EUC-KR");

			for(int i = pt1; i < pt2; i++)
			{
				if	((byteHangle[i] & 0x80) == 0x80)
				{
					byte[] hangle = new byte[2];
					hangle[0] = byteHangle[i];
					hangle[1] = byteHangle[++i];
					strBuf.append(new String(hangle));
				}
				else
				{
					strBuf.append((char)byteHangle[i]);
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception: " + e);
		}

		return strBuf.toString();
	}

	/**
	* str : 원문 String
	* pt1 : 복사 시작 위치
	* pt2 : 복사 끝 위치
	*/
	public static String stByteCopyToString(String str, int pt1, int pt2)
	{
		StringBuffer strBuf = new StringBuffer();
		try
		{
			byte[] byteHangle = str.getBytes("EUC-KR");

			for ( int i = pt1; i < pt2; i++ )
			{
				strBuf.append((char)byteHangle[i]);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception: " + e);
		}

		return strBuf.toString();
	}


    /**
     * bytes에서 원하는 위치의 char 값을 얻음
     * @param bytes
     * @param sLoc
     * @return char
    */
    public static char getBytesToChar(byte[] bystStr, int sLoc)
    {
        char cData = 0;
        try
        {
            int bytelen =  bystStr.length;

            if	( bytelen > sLoc )
            {
    				cData = (char)bystStr[sLoc];
            }
        }
        catch(Exception e)
        {
            return cData;
        }

        return cData;
    }

	//// 길이만큼 byte를 넣어줌
	public static byte[] CutLen( byte[] byteInput, int nLength )
	{
			byte[] bOutput = new byte[nLength];

			for( int i = 0; i < nLength; i++ )
			{
				bOutput[i] = byteInput[i];
			}

			return bOutput;
	}
}