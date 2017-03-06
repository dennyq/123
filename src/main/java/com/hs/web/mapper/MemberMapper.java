package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

import java.util.Map;

public interface MemberMapper extends CrudMapper{
  void initailizePwd(DbMap map);
  void updateMember(DbMap map);
  DbMap chkMemberExist(DbMap map);


  void updateHitcount(DbMap req);

  int idCheck(DbMap req);

  int idPwCheck(DbMap req);

  int idPwDelChk(DbMap req);

  void restore(DbMap req);

  void changePwd(DbMap req);

  int addressCheck(DbMap req);

  String currMemberId(DbMap req);

  int excelDelete(DbMap req);
}
