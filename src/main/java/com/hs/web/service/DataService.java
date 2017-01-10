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
import com.hs.web.mapper.CctvMapper;
import com.hs.web.mapper.DataMapper;
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
public class DataService extends ServiceBase {

    private static final Logger logger = LoggerFactory.getLogger(DataService.class);
    @Autowired private DataMapper mapper;
    @Autowired private FileService fileService;
    @Autowired private PathManager pathManager;
    @Autowired private GraphService graphService;
    private final String FOLDERPATH = "data";



    //testgraph
    public ResultMap testgraph(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data testgraph] recv:{}", req);
        req.put("folderPath", FOLDERPATH);

        //전날 그래프 지운다.
        pathManager.deleteGrpFiles(FOLDERPATH);

        DbList datasetList = new DbList();



        //
        if(req.get("sch_date")==null){
            String today = DateUtil.getToday();
            res.put("today", today);
            req.put("sch_date",today);
        }

        DbList dblist = mapper.graphList(req);
        if (Global.isDev) logger.info("[data dblist] send:{}", dblist);

        for (int i = 0; i < 3; i++) {
            for(DbMap map : dblist){
                if(i==0)map.put("y",map.get("temperature1"));
                if(i==1)map.put("y",map.get("humidity1"));
                if(i==2)map.put("y",map.get("carbondioxide1"));
            }

            String name = null;

            if (i == 0) name = "temperature1";
            if (i == 1) name = "humidity1";
            if (i == 2) name = "carbondioxide1";

            DbMap datasetMap = new DbMap();
            XYSeriesCollection dataset = new XYSeriesCollection();
            dataset = graphService.createDataset1(dblist, dataset, name);
            datasetMap.put("dataset",dataset);

            datasetList.add(datasetMap);

        }



        if (Global.isDev) logger.info("[data dblist] datasetList size:{}", datasetList.size());

        //영역별분석 그래프
        String grpPath = graphService.createGraphicMultiAxis(req, datasetList, 800, 600);

        res.put("grpPath", grpPath);





        if (Global.isDev) logger.debug("[data testgraph] send:{}", res);
        return res;
    }

    //graph
    public ResultMap graph(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data graph] recv:{}", req);
        req.put("folderPath", FOLDERPATH);
        String grpPath ="/imgs/no-data.png";
        //전날 그래프 지운다.
        pathManager.deleteGrpFiles(FOLDERPATH);

        DbList datasetList = new DbList();
        ArrayList channelList = new ArrayList();
        String today = DateUtil.getToday();

        //
        String channel1 =req.get("channel1")+"";
        String channel2 =req.get("channel2")+"";
        String channel3 =req.get("channel3")+"";
        String channel4 =req.get("channel4")+"";
        String channel5 =req.get("channel5")+"";
        String channel6 =req.get("channel6")+"";
        String channel7 =req.get("channel7")+"";
        String channel8 =req.get("channel8")+"";
        if(req.get("sch_date")==null){
            req.put("sch_date",today);
            res.put("today", today);
            channelList.add(1);
            channelList.add(2);
            channelList.add(3);
            channelList.add(4);
            channel1 = "Y";
            channel2 = "Y";
            channel3 = "Y";
            channel4 = "Y";

        }else{
            res.put("sch_date", req.get("sch_date"));
            channelList.clear();
        }

        DbList dblist = mapper.graphList(req);
        logger.info("dblist.size()={}",dblist.size());
        if(dblist.size()>0){
            if (Global.isDev) logger.info("[data dblist] send:{}", dblist);

            for (int i = 0; i < 8; i++) {
                String channel = req.get("channel"+(i+1))+"";
                if(channel.equals("Y")){
                    channelList.add((i+1));
                    if (Global.isDev) logger.info("[data setChannel length] send:{}", channelList.size());
                }

            }
            if (Global.isDev) logger.info("[data setChannel] send:{}", channelList.size());

            for (int i = 0; i < 3; i++) {
                for(DbMap map : dblist){

                    if (i == 0) map.put("y", map.get("temperature1"));
                    if (i == 1) map.put("y", map.get("humidity1"));
                    if (i == 2) map.put("y", map.get("carbondioxide1"));
                }

                String name = null;

                if (i == 0) name = "temperature";
                if (i == 1) name = "humidity";
                if (i == 2) name = "carbondioxide";

                DbMap datasetMap = new DbMap();
                XYSeriesCollection dataset = new XYSeriesCollection();

                logger.info("channelList.size()={}",channelList.size());
                //multi series
                for (int j = 0; j < channelList.size(); j++) {

                    String seriesName = name;
                    name = name + channelList.get(j);
                    logger.info("channelList.get(j)={}",channelList.get(j));

                    dblist.get(0).put("y", dblist.get(0).get(name));

                    dataset = graphService.createDataset1(dblist, dataset, name);
                    name =seriesName;
                }

                datasetMap.put("dataset",dataset);
                datasetList.add(datasetMap);

            }



            if (Global.isDev) logger.info("[data dblist] datasetList size:{}", datasetList.size());

            //영역별분석 그래프
            grpPath = graphService.createChartMultiAxisTime(req,  datasetList, 800, 600);
        }

        res.put("grpPath", grpPath);



        res.put("channel1", channel1);
        res.put("channel2", channel2);
        res.put("channel3", channel3);
        res.put("channel4", channel4);
        res.put("channel5", channel5);
        res.put("channel6", channel6);
        res.put("channel7", channel7);
        res.put("channel8", channel8);





        if (Global.isDev) logger.debug("[data graph] send:{}", res);
        return res;
    }


    //목록
    public ResultMap list(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data list] recv:{}", req);
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

        res.put("pageTimes", (Integer.parseInt(req.get("page") + "") - 1) * Integer.parseInt(req.get("rows") + ""));

        res.put("paging", PageUtil.getPaging(req, total));

        if (Global.isDev) logger.debug("[data list] send:{}", res);
        return res;
    }


    //상세
    public ResultMap detail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data detail] recv:{}", req);

        res.put("data", mapper.detail(req));

        if (Global.isDev) logger.debug("[data detail] send:{}", res);
        return res;
    }

    //글쓰기
    public ResultMap write(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data write] recv:{}", req);

        mapper.insert(req);

        if (Global.isDev) logger.debug("[data write] send:{}", res);
        return res;
    }

    //저장
    public ResultMap save(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data save] recv:{}", req);
        String joindate = req.get("joindate") + "";
        String usestartdate = req.get("usestartdate") + "";
        String useenddate = req.get("useenddate") + "";
        req.put("joindate", joindate.replace(".", ""));
        req.put("usestartdate", usestartdate.replace(".", ""));
        req.put("useenddate", useenddate.replace(".", ""));

        int idPwCheckCnt = mapper.idPwCheck(req);

        if (req.get("isNew").equals("Y")) {
            if (req.get("memberid").equals("admin")) {
                req.put("grade", "1");
            } else {
                req.put("grade", "2");
            }

            if (idPwCheckCnt != 0) {
                throw new BizException("9009", "id_exist");
            }

            mapper.insert(req);
        } else {


//      if(idPwCheckCnt!=1){
//        throw new BizException("9009","password_not_match");
//      }

            mapper.update(req);
        }


        if (Global.isDev) logger.debug("[data save] send:{}", res);
        return res;
    }

    //수정
    public ResultMap modify(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data modify] recv:{}", req);

        if (req.get("joindate") != null && req.get("joindate") != "") {
            String joindate = req.get("joindate") + "";
            joindate = joindate.replace(".", "");
            req.put("joindate", joindate);
        }

        if (req.get("outdate") != null && req.get("outdate") != "") {
            String outdate = req.get("outdate") + "";
            outdate = outdate.replace(".", "");
            req.put("outdate", outdate);
        }

        if (req.get("usestartdate") != null && req.get("usestartdate") != "") {
            String usestartdate = req.get("usestartdate") + "";
            usestartdate = usestartdate.replace(".", "");
            req.put("usestartdate", usestartdate);
        }

        if (req.get("useenddate") != null && req.get("useenddate") != "") {
            String useenddate = req.get("useenddate") + "";
            useenddate = useenddate.replace(".", "");
            req.put("useenddate", useenddate);
        }

        mapper.update(req);


        if (Global.isDev) logger.debug("[data modify] send:{}", res);
        return res;
    }


    //삭제
    public ResultMap delete(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data delete] recv:{}", req);

        mapper.delete(req);

        if (Global.isDev) logger.debug("[data delete] send:{}", res);
        return res;
    }

    //비밀번호 변경
    public ResultMap initailizePwd(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[data initailizePwd] recv:{}", req);

        mapper.initailizePwd(req);

        if (Global.isDev) logger.debug("[data initailizePwd] send:{}", res);
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

        if (request instanceof MultipartHttpServletRequest) {

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
        if (Global.isDev) logger.debug("[data idCheck] recv:{}", req);

        int cnt = mapper.idCheck(req);

        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[data idCheck] send:{}", res);
        return res;
    }
}
