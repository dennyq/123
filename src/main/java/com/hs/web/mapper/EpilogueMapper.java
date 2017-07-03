package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;

public interface EpilogueMapper extends CrudMapper {

    void initailizePwd(DbMap map);

    void updateMember(DbMap map);

    DbMap chkMemberExist(DbMap map);


    void updateHitcount(DbMap req);

    int idCheck(DbMap req);
    int countByMemberId(DbMap req);

    int idPwCheck(DbMap req);

    int idPwDelChk(DbMap req);


    void changePwd(DbMap req);

    int addressCheck(DbMap req);

    String currMemberId(DbMap req);


    DbMap getLastIndex(DbMap req);

    DbMap getLastFileIndex(DbMap req);

    void insertFile(DbMap req);

    DbList detailFile(DbMap req);

    int deleteFile(DbMap req);
}
