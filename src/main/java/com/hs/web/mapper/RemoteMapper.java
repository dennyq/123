package com.hs.web.mapper;


import com.hs.DbMap;
import com.hs.web.RequestMap;

public interface RemoteMapper {
 DbMap getInnersensorstate(DbMap req);
 DbMap getInnercablesensorstate(DbMap req);
 DbMap getOutersensorstate(DbMap req);
 DbMap getInitsetting(DbMap req);
 DbMap getNutrientstate(DbMap req);
 DbMap getHeatrecoverystate(DbMap req);
 DbMap getAirfanstate(DbMap req);

 DbMap getMemberIp(DbMap req);

 int setHeatrecoverystate(DbMap req);

 int setAirfanstate(DbMap req);
}
