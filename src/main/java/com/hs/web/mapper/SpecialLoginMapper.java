package com.hs.web.mapper;


import com.hs.DbMap;


public interface SpecialLoginMapper {

	DbMap login(DbMap req);

	int checkLogin(DbMap req);

	int checkLoginAdmin(DbMap req);

	void insertLoginHist(DbMap req);
}
