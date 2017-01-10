package com.hs.web.mapper;


import com.hs.DbMap;

public interface DailyMapper extends CrudMapper{
  void initailizePwd(DbMap map);
  void updateMember(DbMap map);
  DbMap chkMemberExist(DbMap map);


  void updateHitcount(DbMap req);

  int idCheck(DbMap req);

  int idPwCheck(DbMap req);
}
