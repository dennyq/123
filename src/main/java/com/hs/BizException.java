package com.hs;

public class BizException extends RuntimeException  {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6650410639570678979L;
	
	protected ResultType _result;
    protected String _resultCode;
    protected String _url;
    protected int _idx;

	public BizException() {
		_result = ResultType.UnknowError;
		_resultCode = "9999";
	}
	
	public BizException(String message, Throwable t) {
		super(message, t);
		_result = ResultType.MessageError;
		_resultCode = "9000";
	}
	
	public BizException(String message) {
		this(message, (Throwable)null);
	}


	public BizException(ResultType result, String message, Throwable t) {
		this(message, t);
		_result = result;
	}
	
	public BizException(ResultType result, String message) {
		this(message, (Throwable)null);
		_result = result;
	}
	
	public BizException(ResultType result) {
		this("", (Throwable)null);
		_result = result;
	}
	
	public BizException(String resultCode, String message) {
		this(message, (Throwable)null);
		_resultCode = resultCode;
	}

	public BizException(String resultCode, String message,String url) {
		this(message, (Throwable)null);
		_resultCode = resultCode;
		_url = url;
	}

	public BizException(String resultCode, String message,String url,int idx) {
		this(message, (Throwable)null);
		_resultCode = resultCode;
		_url = url;
		_idx = idx;
	}

	public BizException(String resultCode, String message,int idx) {
		this(message, (Throwable)null);
		_resultCode = resultCode;
		_idx = idx;
	}


	public ResultType result() {
		return _result;
	}
	
	public String resultCode() {
		return _resultCode;
	}
	public String url() {
		return _url;
	}

	public int idx() {
		return _idx;
	}
}
