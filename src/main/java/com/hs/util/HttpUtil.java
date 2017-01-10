package com.hs.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.rmi.UnknownHostException;
import java.util.Enumeration;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.ByteArrayRequestEntity;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpUtil {
	private final static Logger logger = LoggerFactory.getLogger(HttpUtil.class);

    public static InetAddress getLocalHostLANAddress() throws UnknownHostException {
        try {
            InetAddress candidateAddress = null;
            // Iterate all NICs (network interface cards)...
            for (Enumeration ifaces = NetworkInterface.getNetworkInterfaces(); ifaces.hasMoreElements();) {
                NetworkInterface iface = (NetworkInterface) ifaces.nextElement();
                // Iterate all IP addresses assigned to each card...
                for (Enumeration inetAddrs = iface.getInetAddresses(); inetAddrs.hasMoreElements();) {
                    InetAddress inetAddr = (InetAddress) inetAddrs.nextElement();
                    if (!inetAddr.isLoopbackAddress()) {

                        if (inetAddr.isSiteLocalAddress()) {
                            // Found non-loopback site-local address. Return it immediately...
                            return inetAddr;
                        }
                        else if (candidateAddress == null) {
                            // Found non-loopback address, but not necessarily site-local.
                            // Store it as a candidate to be returned if site-local address is not subsequently found...
                            candidateAddress = inetAddr;
                            // Note that we don't repeatedly assign non-loopback non-site-local addresses as candidates,
                            // only the first. For subsequent iterations, candidate will be non-null.
                        }
                    }
                }
            }
            if (candidateAddress != null) {
                // We did not find a site-local address, but we found some other non-loopback address.
                // Server might have a non-site-local address assigned to its NIC (or it might be running
                // IPv6 which deprecates the "site-local" concept).
                // Return this non-loopback candidate address...
                return candidateAddress;
            }
            // At this point, we did not find a non-loopback address.
            // Fall back to returning whatever InetAddress.getLocalHost() returns...
            InetAddress jdkSuppliedAddress = InetAddress.getLocalHost();
            if (jdkSuppliedAddress == null) {
                throw new UnknownHostException("The JDK InetAddress.getLocalHost() method unexpectedly returned null.");
            }
            return jdkSuppliedAddress;
        }
        catch (Exception e) {
            UnknownHostException unknownHostException = new UnknownHostException("Failed to determine LAN address: " + e);
            unknownHostException.initCause(e);
            throw unknownHostException;
        }
    }

	public static String downloadString(String url) throws IOException {
		logger.info("request downloadString url={}", url);
		
		HttpClient client = new HttpClient();
		
		GetMethod get = new GetMethod(url);
		try {
			client.executeMethod(get);
			
			if(get.getStatusCode() != 200) {
				throw new RuntimeException("데이타 요청에 실패했습니다. " + get.getStatusLine().toString() + ", url="+url);
			}
			InputStream in = get.getResponseBodyAsStream();
			
			String message = org.apache.commons.io.IOUtils.toString(in, "utf-8");
			return message;
		}
		finally {
			get.releaseConnection();
		}
	}
	
	public static String downloadString(String url, String contentType, String postString) throws IOException {
		HttpClient client = new HttpClient();
		
		PostMethod post = new PostMethod(url);
		post.setRequestHeader("Content-Type", contentType);
		StringRequestEntity str = new StringRequestEntity(postString);
		post.setRequestEntity(str);
		try {
			client.executeMethod(post);
			
			if(post.getStatusCode() != 200) {
				throw new RuntimeException("데이타 요청에 실패했습니다. " + post.getStatusLine().toString());
			}
			InputStream in = post.getResponseBodyAsStream();
			
			String message = org.apache.commons.io.IOUtils.toString(in, "utf-8");
			
			return message;
		}
		finally {
			post.releaseConnection();
		}
	}
	
	public static void downloadAsFile(String url, String filePath) throws IOException {
		File file = new File(filePath);
		if(file.exists()) {
			throw new RuntimeException("파일이 이미 존재합니다.");
		}
		downloadAsFile(url, file, 0);
	}
	
	public static void downloadAsFile(String url, File file, int retryCount) throws IOException {
		HttpClient client = new HttpClient();
		GetMethod get = new GetMethod(url);
		try {
			client.executeMethod(get);
			if(get.getStatusCode() != 200) {
				throw new RuntimeException("데이타 요청에 실패했습니다.");
			}
			
			InputStream in = get.getResponseBodyAsStream();
			FileOutputStream out = new FileOutputStream(file);
			
//			IOUtils.write(get.getResponseBody(), out);
			IOUtils.copy(in, out);
			IOUtils.closeQuietly(out);
			
			if(file.length() != get.getResponseContentLength()) {
				logger.warn("다운로드가 실패되어서 재시도 합니다. size1={}, size2={}", get.getResponseContentLength(), file.length());
				if(retryCount < 10) 
					throw new RuntimeException("파일 다운로드에 실패했습니다. url=" + url);
				// retry...
				
				FileUtils.deleteQuietly(file);
				downloadAsFile(url, file, ++retryCount);
			}
			
			logger.info("다운로드 완료! url={}, size1={}", url, get.getResponseContentLength());
		}
		finally {
			get.releaseConnection();
		}
	}

    public static byte[] downloadData(String url) throws IOException {
        logger.info("request downloadData url={}", url);

        HttpClient client = new HttpClient();

        GetMethod get = new GetMethod(url);
        try {
            client.executeMethod(get);

            if(get.getStatusCode() != 200) {
                throw new RuntimeException("데이타 요청에 실패했습니다. " + get.getStatusLine().toString() + ", url="+url);
            }
            InputStream in = get.getResponseBodyAsStream();

            byte[] data = org.apache.commons.io.IOUtils.toByteArray(in);
            return data;
        }
        finally {
            get.releaseConnection();
        }
    }

    public static byte[] downloadData(String url, String contentType, byte[] postData) throws IOException {
        HttpClient client = new HttpClient();

        PostMethod post = new PostMethod(url);
        post.setRequestHeader("Content-Type", contentType);

        ByteArrayRequestEntity entity = new ByteArrayRequestEntity(postData);
        post.setRequestEntity(entity);
        try {
            client.executeMethod(post);

            if(post.getStatusCode() != 200) {
                throw new RuntimeException("데이타 요청에 실패했습니다. " + post.getStatusLine().toString());
            }
            InputStream in = post.getResponseBodyAsStream();

            byte[] data = org.apache.commons.io.IOUtils.toByteArray(in);
            return data;
        }
        finally {
            post.releaseConnection();
        }
    }
}
