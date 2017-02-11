package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface AppMapper {

  DbList search(DbMap req);
}
