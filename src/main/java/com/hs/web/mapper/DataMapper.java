package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface DataMapper extends CrudMapper{
  void initailizePwd(DbMap map);
  void updateMember(DbMap map);
  DbMap chkMemberExist(DbMap map);


  void updateHitcount(DbMap req);

  int idCheck(DbMap req);

  int idPwCheck(DbMap req);

  DbList graphList(DbMap req);
}
