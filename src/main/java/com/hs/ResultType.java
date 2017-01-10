package com.hs;

public enum ResultType {
	Success("0000"),
	RequestError("1000"),
	// RequestErrorNotLogin("1001"),
	ServerError("2000"),
	MessageError("3000"),
	HandeledServerError("9000"),
	ReurlServerError("9001"),
	AuthError("9002"),

	UnknowError("9999");

	
	private String _value;
	ResultType(String value) {
		_value = value;
	}
	
	public String value() {
		return _value;
	}
	
	
}
