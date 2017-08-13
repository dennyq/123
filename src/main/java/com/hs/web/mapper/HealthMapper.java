package com.hs.web.mapper;


import com.hs.DbList;
import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface HealthMapper extends CrudMapper {

    void initailizePwd(DbMap map);

    void updateMember(DbMap map);

    DbMap chkMemberExist(DbMap map);


    void updateHitcount(DbMap req);

    int idCheck(DbMap req);

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

    int getNextIndex(DbMap req);
    int getNextFileSeq(DbMap req);

    DbMap getOrderMinMax(DbMap req);

    void upOrder(DbMap req);
    void upOrderOther(DbMap req);
    void downOrder(DbMap req);
    void downOrderOther(DbMap req);


    int updateContents(DbMap req);
    int updateThum(DbMap req);
    int updateFile(DbMap req);

    int deleteHealthFile(RequestMap req);

    int deleteFiles(RequestMap req);
}
