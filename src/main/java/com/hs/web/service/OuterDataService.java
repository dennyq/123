package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.DateUtil;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.PathManager;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.DataMapper;
import com.hs.web.mapper.OuterDataMapper;
import org.jfree.data.xy.XYSeriesCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;


@Service
public class OuterDataService extends ServiceBase {

  private static final Logger logger = LoggerFactory.getLogger(OuterDataService.class);
  @Autowired private OuterDataMapper mapper;
  @Autowired private FileService fileService;
  @Autowired private PathManager pathManager;
  @Autowired private GraphService graphService;

  private final String FOLDERPATH = "outerData";

  //graph
//  public ResultMap graph(RequestMap req) throws IOException {
//    ResultMap res = ResultMap.create();
//    if (Global.isDev) logger.debug("[outer graph] recv:{}", req);
//    req.put("folderPath", FOLDERPATH);
//    String grpPath ="/imgs/no-data.png";
//
//    //전날 그래프 지운다.
//    pathManager.deleteGrpFiles(FOLDERPATH);
//
//    DbList datasetList = new DbList();//2
//
//
//    String today = DateUtil.getToday();
//
//
//    if(req.get("sch_date")==null){
//      req.put("sch_date",today);
//      res.put("today", today);
//
//    }else{
//      res.put("sch_date", req.get("sch_date"));
//
//    }
//
//    DbList dblist = mapper.graphList(req);
//    if(dblist.size()>0){
//      if (Global.isDev) logger.info("[outer dblist] send:{}", dblist);
//
//
//
//      //2ro
//      for (int i = 0; i < 2; i++) {
//        for(DbMap map : dblist){
//
//          if(i==0)map.put("y",map.get("windspeed"));
//          if(i==1)map.put("y",map.get("wm2"));
//
//        }
//
//        String name = null;
//
//        if (i == 0) name = "windspeed";
//        if (i == 1) name = "wm2";
//
//
//        DbMap datasetMap = new DbMap();
//        XYSeriesCollection dataset = new XYSeriesCollection();
//
//
////        dblist.get(i).put("y", dblist.get(i).get(name));
//        dataset = graphService.createDataset1(dblist, dataset, name);
//
//
//
//
//        datasetMap.put("dataset",dataset);
//        datasetList.add(datasetMap);
//
//      }
//
//
//
//      if (Global.isDev) logger.info("[outer dblist] datasetList size:{}", datasetList.size());
//
//      //영역별분석 그래프
//      grpPath = graphService.createChartMultiAxisTime(req, datasetList, 800, 600);
//
//    }
//
//    res.put("grpPath", grpPath);
//
//
//
//
//    if (Global.isDev) logger.debug("[outer graph] send:{}", res);
//    return res;
//  }



  //graph2
  public ResultMap graph(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[outer graph recv:{}", req);
    req.put("folderPath", FOLDERPATH);
    String grpPath ="/imgs/no-data.png";

    //전날 그래프 지운다.
    pathManager.deleteGrpFiles(FOLDERPATH);

    DbList datasetList = new DbList();//4


    String today = DateUtil.getToday();


    if(req.get("sch_date")==null){
      req.put("sch_date",today);
      res.put("today", today);

    }else{
      res.put("sch_date", req.get("sch_date"));

    }

    DbList dblist = mapper.graphList(req);
    if(dblist.size()>0){
      if (Global.isDev) logger.info("[outer graph dblist] send:{}", dblist);

      //4ro
      for (int i = 0; i < 4; i++) {
        for(DbMap map : dblist){

          if(i==0)map.put("y",map.get("node_temperature"));
          if(i==1)map.put("y",map.get("node_humidity"));
          if(i==2)map.put("y",map.get("node_wm2"));
          if(i==3)map.put("y",map.get("node_windspeed"));

        }

        String name = null;
        if (i == 0) name = "온도";
        if (i == 1) name = "습도";
        if (i == 2) name = "일사량";
        if (i == 3) name = "풍속";
//        A.node_temperature,
//                A.node_humidity,
//                A.node_rainstate,
//                A.node_winddirection,
//                A.node_windspeed,

        DbMap datasetMap = new DbMap();
        XYSeriesCollection dataset = new XYSeriesCollection();

//        dblist.get(i).put("y", dblist.get(i).get(name));
        dataset = graphService.createDataset1(dblist, dataset, name);




        datasetMap.put("dataset",dataset);
        datasetList.add(datasetMap);

      }



      if (Global.isDev) logger.info("[outer dblist] datasetList size:{}", datasetList.size());

      //영역별분석 그래프
      grpPath = graphService.createChartMultiAxisTime(req, datasetList, 800, 600);

    }

    res.put("grpPath", grpPath);




    if (Global.isDev) logger.debug("[outer graph send:{}", res);
    return res;
  }

  //목록
  public ResultMap list(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main list] recv:{}", req);
    req.put("rows", "10");
    setPaging(req);
    if (Global.isDev) logger.debug("[list] recv:{}", req);

    DbList list = mapper.list(req);
    int total = mapper.listCnt(req);

    res.put("total", total);
    res.put("rows", list);
    res.put("sch_memberid", req.get("sch_memberid"));
    res.put("sch_joindate", req.get("sch_joindate"));
    res.put("sch_name", req.get("sch_name"));
    res.put("sch_usestartdate", req.get("sch_usestartdate"));
    res.put("sch_useenddate", req.get("sch_useenddate"));
    res.put("sch_handphone", req.get("sch_handphone"));

    res.put("pageTimes", (Integer.parseInt(req.get("page")+"")-1)*Integer.parseInt(req.get("rows")+""));

    res.put("paging", PageUtil.getPaging(req, total));

    if (Global.isDev) logger.debug("[main list] send:{}", res);
    return res;
  }





  //상세
  public ResultMap detail(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main detail] recv:{}", req);

    res.put("data", mapper.detail(req));

    if (Global.isDev) logger.debug("[main detail] send:{}", res);
    return res;
  }

  //글쓰기
  public ResultMap write(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main write] recv:{}", req);

    mapper.insert(req);

    if (Global.isDev) logger.debug("[main write] send:{}", res);
    return res;
  }

  //저장
  public ResultMap save(RequestMap req) throws IOException {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main save] recv:{}", req);
    String joindate =  req.get("joindate")+"";
    String usestartdate =  req.get("usestartdate")+"";
    String useenddate =  req.get("useenddate")+"";
    req.put("joindate",joindate.replace(".",""));
    req.put("usestartdate",usestartdate.replace(".",""));
    req.put("useenddate",useenddate.replace(".",""));

    int idPwCheckCnt = mapper.idPwCheck(req);

    if(req.get("isNew").equals("Y")){
      if(req.get("memberid").equals("admin")){
        req.put("grade","1");
      }else {
        req.put("grade","2");
      }

      if(idPwCheckCnt!=0){
        throw new BizException("9009","id_exist");
      }

      mapper.insert(req);
    }else{


//      if(idPwCheckCnt!=1){
//        throw new BizException("9009","password_not_match");
//      }

      mapper.update(req);
    }



    if (Global.isDev) logger.debug("[main save] send:{}", res);
    return res;
  }

  //수정
  public ResultMap modify(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main modify] recv:{}", req);

    if(req.get("joindate") != null && req.get("joindate") != "" ){
      String joindate = req.get("joindate")+"";
      joindate = joindate.replace(".","");
      req.put("joindate",joindate);
    }

    if(req.get("outdate") != null && req.get("outdate") != "" ){
      String outdate = req.get("outdate")+"";
      outdate = outdate.replace(".","");
      req.put("outdate",outdate);
    }

    if(req.get("usestartdate") != null && req.get("usestartdate") != "" ){
      String usestartdate = req.get("usestartdate")+"";
      usestartdate = usestartdate.replace(".","");
      req.put("usestartdate",usestartdate);
    }

    if(req.get("useenddate") != null && req.get("useenddate") != "" ){
      String useenddate = req.get("useenddate")+"";
      useenddate = useenddate.replace(".","");
      req.put("useenddate", useenddate);
    }

    mapper.update(req);




    if (Global.isDev) logger.debug("[main modify] send:{}", res);
    return res;
  }


  //삭제
  public ResultMap delete(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main delete] recv:{}", req);

    mapper.delete(req);

    if (Global.isDev) logger.debug("[main delete] send:{}", res);
    return res;
  }

  //비밀번호 변경
  public ResultMap initailizePwd(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main initailizePwd] recv:{}", req);

    mapper.initailizePwd(req);

    if (Global.isDev) logger.debug("[main initailizePwd] send:{}", res);
    return res;
  }


  //업로드이미지
  public ResultMap uploadImage(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[uploadImage] recv:{}", req);

    req.put("inputName", "file");

    if (request instanceof MultipartHttpServletRequest) {

      String before_file_id = mapper.getImgKey(req);
      req.put("file_id", before_file_id);
      fileService.deleteFile(req);
      res.put("image_file_key", fileService.uploadFile(request, req));

    }

    if (Global.isDev) logger.debug("[uploadImage] send:{}", res);
    return res;
  }

  //업로드파일
  public ResultMap uploadFile(HttpServletRequest request) throws Exception {
    RequestMap req = RequestMap.create(request);
    ResultMap res = ResultMap.create();

    if (Global.isDev) logger.debug("[uploadFile] recv:{}", req);

    req.put("inputName", "file");

    if(request instanceof MultipartHttpServletRequest) {

      String before_file_id = mapper.getFileKey(req);
      req.put("file_id", before_file_id);
      fileService.deleteFile(req);
      res.put("attach_file_key", fileService.uploadFile(request, req));
    }

    if (Global.isDev) logger.debug("[uploadFile] send:{}", res);

    return res;
  }

  //아이디체크
  public ResultMap idCheck(RequestMap req) {
    ResultMap res = ResultMap.create();
    if (Global.isDev) logger.debug("[main idCheck] recv:{}", req);

    int cnt = mapper.idCheck(req);

    if(cnt > 0){
      res.put("result_message", "fail");
    }

    if (Global.isDev) logger.debug("[main idCheck] send:{}", res);
    return res;
  }
}
