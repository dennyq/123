package com.hs.web;

import com.hs.BizException;
import com.hs.ResultType;

public class WebPageException extends BizException  {

	public WebPageException(Exception e) {
		super("서버에서 오류가 발생했습니다", e);

        if(e instanceof BizException) {
            BizException be = (BizException)e;
            this._result = be.result();
            this._resultCode = be.resultCode();
        }
	}

    public WebPageException(String message) {
        super(ResultType.ServerError, message);
    }

}