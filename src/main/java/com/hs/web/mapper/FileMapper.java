package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;

public interface FileMapper {
	DbList selectList();

	void insert(DbMap req);

	DbMap selectById(DbMap req);

	void deleteById(DbMap req);

	void delectFile(DbMap req);

	void delete(DbMap req);
	
	DbMap getFileInfo(String file_id);
}
