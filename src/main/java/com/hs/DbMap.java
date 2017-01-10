package com.hs;



import com.hs.util.UnitUtil;

import java.util.HashMap;
import java.util.Map;

public class DbMap extends HashMap<String, Object>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 599162507926542478L;
	
	public DbMap() {
		
	}
	
	public DbMap(Map<? extends String, ? extends Object> map){
		super(map);
	}
	


	public String get(String name, String def) {
		if(!super.containsKey(name) || super.get(name) == null)
			return def;
		
		return super.get(name).toString();
	}
	
	public int get(String name, int def) {
		if(!super.containsKey(name) || super.get(name) == null)
			return def;
		
		return UnitUtil.toInt(super.get(name));
	}
	
	public DbMap clone() {
		return new DbMap(this);
	}

	public static class ArgsException extends BizException {

    private static final long serialVersionUID = 2225212098917599281L;

    private String _argsName;

    public ArgsException(String argsName) {
      super(ResultType.RequestError, "입력변수가 잘못되었습니다. arg=" + argsName);

      _argsName = argsName;
    }

    public String argsName() {
      return _argsName;
    }

  }
}
