package com.hs.web.mapper;



import com.hs.DbList;
import com.hs.DbMap;

public interface CrudMapper {

	DbList list(DbMap req);

	int listCnt(DbMap req);

	DbMap detail(DbMap req);

	int duplicateChk(DbMap req);
	
	int insert(DbMap req);

	void update(DbMap req);

	void delete(DbMap req);

	String getImgKey(DbMap req);

	String getFileKey(DbMap req);



}
