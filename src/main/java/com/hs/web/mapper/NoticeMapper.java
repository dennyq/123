package com.hs.web.mapper;


import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface NoticeMapper extends CrudMapper{

 void initailizePwd(DbMap map);
 void updateMember(DbMap map);
 DbMap chkMemberExist(DbMap map);


 void updateHitcount(DbMap req);
}
