package com.hs.web.service;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.SpecialMembershipMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;


@Service
public class SpecialMembershipService extends ServiceBase {

    private static final Logger logger = LoggerFactory.getLogger(SpecialMembershipService.class);
    @Autowired
    private SpecialMembershipMapper mapper;
    @Autowired
    private FileService fileService;


    //목록
    public ResultMap list(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special list] recv:{}", req);
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

        if (Global.isDev) logger.debug("[special list] send:{}", res);
        return res;
    }

    //상세
    public ResultMap detail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special detail] recv:{}", req);

        res.put("data", mapper.detail(req));

        if (Global.isDev) logger.debug("[special detail] send:{}", res);
        return res;
    }

    //상세
    public ResultMap contract(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special contract] recv:{}", req);

        res.put("data", mapper.detail(req));

        if (Global.isDev) logger.debug("[special contract] send:{}", res);
        return res;
    }

    //excelDelete
    public ResultMap excelDelete(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special excelDelete] recv:{}", req);

//        String insertedArr = ;
        String insertedArr[] =((String)req.get("insertedArr")).split(",");
        for(int i=0;i<insertedArr.length;i++){

            req.put("memberid",insertedArr[i]);
            mapper.excelDelete(req);
        }


        if (Global.isDev) logger.debug("[special excelDelete] send:{}", res);
        return res;
    }

    //excelSave
    public ResultMap excelSave(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[member excelsave] recv:{}", req);

        String longitude = req.get("longitude") + "";
        String latitude = req.get("latitude") + "";
        longitude = longitude.equals("") ? "0" : longitude;
        latitude = latitude.equals("") ? "0" : latitude;
        longitude = longitude.equals("null") ? "0" : longitude;
        latitude = latitude.equals("null") ? "0" : latitude;
        double longitudeDouble = Double.parseDouble(longitude);
        double latitudeDouble = Double.parseDouble(latitude);
        req.put("longitude", longitudeDouble);
        req.put("latitude", latitudeDouble);


        req.put("regtime", "20170101000000");
        req.put("usestartdate", "20170101");
        req.put("useenddate", "99991230");

        int addressCheck = mapper.addressCheck(req);

        String currMemberId = mapper.currMemberId(req);
        String memberid = null;
        if (currMemberId.equals("0")) {
            memberid = "B000000001";
            req.put("memberid", memberid);

        } else {
//            logger.info("currMemberId.split(\"B\")[1]={}",currMemberId.split("B")[0]);

            int nextMemberId = Integer.parseInt(currMemberId.split("B")[1]) + 1;
            logger.info("nextMemberId = {}", nextMemberId);
            memberid = "B"+String.format("%09d", nextMemberId);
            logger.info("memberid = {}", memberid);
            req.put("memberid",memberid);
        }



        req.put("grade", "2");
        req.put("deleteyn", "0");
        int idx = Integer.parseInt(req.get("idx")+"");
        res.put("result_idx",idx);
        if (addressCheck > 0) {
            //res.put("result_message","already_exist");

//            throw new BizException("9011", "already_exist","/member/popup",idx);
        }else {
            mapper.insert(req);
            res.put("insertedId",memberid);
            logger.debug("[member insert] req:{}", req);
        }






        if (Global.isDev) logger.debug("[member excelsave] send:{}", res);
        return res;
    }

    //글쓰기
    public ResultMap write(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special write] recv:{}", req);

        mapper.insert(req);

        if (Global.isDev) logger.debug("[special write] send:{}", res);
        return res;
    }

    //저장
    public ResultMap save(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special save] recv:{}", req);
        String joindate = req.get("joindate") + "";
        String usestartdate = (String) req.get("usestartdate");
        String useenddate = (String) req.get("useenddate");

        if(usestartdate == null){
            usestartdate="20170527";
        }

        if(useenddate == null){
            useenddate="99991231";
        }

        req.put("joindate", joindate.replace(".", ""));
        req.put("usestartdate", usestartdate.replace(".", ""));
        req.put("useenddate", useenddate.replace(".", ""));

        int idPwCheckCnt = mapper.idPwCheck(req);

        if (req.get("isNew").equals("Y")) {


            if (idPwCheckCnt != 0) {
                throw new BizException("9009", "id_exist");
            }

            int idPwDelChk = mapper.idPwDelChk(req);
            logger.info("idPwDelChk={}", idPwDelChk);

            if (idPwDelChk == 1) {
                //삭제했으니 delyn 원복
                mapper.restore(req);
                mapper.update(req);
            } else {
                mapper.insert(req);
            }

        } else {


            mapper.update(req);
        }


        if (Global.isDev) logger.debug("[special save] send:{}", res);
        return res;
    }

    //저장
    public ResultMap contractSave(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special save] recv:{}", req);
        String joindate = req.get("joindate") + "";
        String usestartdate = (String) req.get("usestartdate");
        String useenddate = (String) req.get("useenddate");

        //todo: 현재날짜, 전일.
        SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
        Date currentTime = new Date( );
        String dTime = formatter.format ( currentTime );

        logger.info("dTime ={}",dTime);

//        if(usestartdate == null){
        usestartdate = dTime;
//        }
        Calendar day = Calendar.getInstance();
        day.add(Calendar.DATE , -1);
        String beforeDate = new java.text.SimpleDateFormat("yyyyMMdd").format(day.getTime());

//        if(useenddate == null){
        useenddate = beforeDate;
//        }

        req.put("joindate", joindate.replace(".", ""));
        req.put("usestartdate", usestartdate.replace(".", ""));
        req.put("useenddate", useenddate.replace(".", ""));

        int idPwCheckCnt = mapper.idPwCheck(req);

        if (req.get("isNew").equals("Y")) {


            if (idPwCheckCnt != 0) {
                throw new BizException("9009", "id_exist");
            }

            int idPwDelChk = mapper.idPwDelChk(req);
            logger.info("idPwDelChk={}", idPwDelChk);

            if (idPwDelChk == 1) {
                //삭제했으니 delyn 원복
                mapper.restore(req);
                mapper.update(req);

            } else {
                mapper.insert(req);

            }

        } else {
            mapper.update(req);

        }


        if (Global.isDev) logger.debug("[special save] send:{}", res);
        return res;
    }

    //저장
    public ResultMap changePwd(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[member changePwd] recv:{}", req);

        int idPwCheckCnt = mapper.idPwCheck(req);
        if (idPwCheckCnt == 1) {
            mapper.changePwd(req);

        } else {
            res.put("result_message", "fail");
        }


        if (Global.isDev) logger.debug("[member changePwd] send:{}", res);
        return res;
    }

    //수정
    public ResultMap modify(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special modify] recv:{}", req);

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


        if (Global.isDev) logger.debug("[special modify] send:{}", res);
        return res;
    }


    //삭제
    public ResultMap delete(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special delete] recv:{}", req);

        mapper.delete(req);

        if (Global.isDev) logger.debug("[special delete] send:{}", res);
        return res;
    }

    //비밀번호 변경
    public ResultMap initailizePwd(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special initailizePwd] recv:{}", req);

        mapper.initailizePwd(req);

        if (Global.isDev) logger.debug("[special initailizePwd] send:{}", res);
        return res;
    }


    //업로드이미지
    public ResultMap uploadImage(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[special uploadImage] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getImgKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("image_file_key", fileService.uploadFile(request, req));

        }

        if (Global.isDev) logger.debug("[special uploadImage] send:{}", res);
        return res;
    }

    //업로드파일
    public ResultMap uploadFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[special uploadFile] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getFileKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("attach_file_key", fileService.uploadFile(request, req));
        }

        if (Global.isDev) logger.debug("[special uploadFile] send:{}", res);

        return res;
    }

    //아이디체크
    public ResultMap idCheck(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[special idCheck] recv:{}", req);

        int cnt = mapper.idCheck(req);

        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[special idCheck] send:{}", res);
        return res;
    }
}
