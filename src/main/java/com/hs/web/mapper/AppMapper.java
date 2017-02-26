package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface AppMapper  extends CrudMapper{

  DbList search(DbMap req);
  DbMap detail(DbMap req);
  DbList playList(DbMap req);
  DbMap playOne(DbMap req);

  DbList getPlayList(DbMap req);
  DbList codeList(DbMap req);

  DbList codeListBig(DbMap req);
  DbList codeListMid(DbMap req);
  DbList codeListDong(DbMap req);
  DbList codeListRo(DbMap req);
}
