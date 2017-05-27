package com.hs;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ResultMap extends DbMap{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7247523019191457251L;

	private ResultMap() {
		setResult(ResultType.Success, "success");
	}
	
	public void setResult(ResultType type) {
		this.put("result_code", type.value());
		this.put("result_message", "");


	}
	
	public void setResult(ResultType type, String message) {
		this.put("result_code", type.value());
		this.put("result_message", message);
	}

	public void setResult(String type, String message) {
		this.put("result_code", type);
		this.put("result_message", message);
	}
	
	public void setMessage(String message) {
		setResult(ResultType.MessageError, message);
	}
	
	public static ResultMap create() {
		ResultMap result = new ResultMap();
		return result;
	}
	
	public static ResultMap create(Exception e) {
		ResultMap result = create();
		if(e instanceof BizException) {
			ResultType resultType = ((BizException)e).result();
			String resultCode = ((BizException)e).resultCode();
			if(resultCode != null) {
				result.setResult(((BizException)e).resultCode(), e.getMessage());	
			}
			else {
				result.setResult(resultType, e.getMessage());
			}
		}
		else {
			result.setResult(ResultType.UnknowError, "System failure \n Ask the administrator");
		}
		
		return result;
	}
	
}
