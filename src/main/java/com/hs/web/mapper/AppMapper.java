package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface AppMapper extends CrudMapper{
  void initailizePwd(DbMap map);
  void updateMember(DbMap map);
  DbMap chkMemberExist(DbMap map);
  DbList codeList(DbMap req);

  void updateHitcount(DbMap req);

  int idCheck(DbMap req);

  int idPwCheck(DbMap req);

  int idPwDelChk(DbMap req);

  void restore(DbMap req);

  void changePwd(DbMap req);

  DbList codeListBig(DbMap req);
  DbList codeListMid(DbMap req);
  DbList codeListDong(DbMap req);
  DbList codeListRo(DbMap req);

  DbList searchMember(DbMap req);
  DbList searchByName(DbMap req);

  DbList mapview(DbMap req);
}
