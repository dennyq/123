package com.hs.web.mapper;


import com.hs.DbMap;

public interface MachineMapper extends CrudMapper{

 void initailizePwd(DbMap map);
 void updateMember(DbMap map);
 DbMap chkMemberExist(DbMap map);
}
