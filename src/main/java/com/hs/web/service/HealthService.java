package com.hs.web.service;

import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.HealthMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


@Service
public class HealthService extends ServiceBase {

    private static final Logger logger = LoggerFactory.getLogger(HealthService.class);
    @Autowired
    private HealthMapper mapper;
    @Autowired
    private FileService fileService;


    //목록
    public ResultMap list(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health list] recv:{}", req);
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

        if (Global.isDev) logger.debug("[health list] send:{}", res);
        return res;
    }

    //앱목록
    public ResultMap healthList(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health list] recv:{}", req);


        int p_size;
        p_size = Integer.parseInt(req.get("p_size")+"");
//        p_start = Integer.parseInt(req.get("p_start")+"");


//        req.put("rows", p_size);
        setPagingApp(req);
        if (Global.isDev) logger.debug("[list] recv:{}", req);
        int total;
        DbList list = mapper.list(req);
        total=list.size();



        res.put("total", total);


        if (total == 0) {
            res.put("rows", null);
        } else {
            res.put("rows", list);
        }
//        res.put("sch_memberid", req.get("sch_memberid"));
//        res.put("sch_joindate", req.get("sch_joindate"));
//        res.put("sch_name", req.get("sch_name"));
//        res.put("sch_usestartdate", req.get("sch_usestartdate"));
//        res.put("sch_useenddate", req.get("sch_useenddate"));
//        res.put("sch_handphone", req.get("sch_handphone"));

//        res.put("pageTimes", (Integer.parseInt(req.get("page") + "") - 1) * Integer.parseInt(req.get("rows") + ""));

//        res.put("paging", PageUtil.getPaging(req, total));

        if (Global.isDev) logger.debug("[health list] send:{}", res);
        return res;
    }

    //앱상세
    public ResultMap healthDetail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health detail] recv:{}", req);

        mapper.updateHitcount(req);

        res.put("data", mapper.detail(req));
        res.put("file", mapper.detailFile(req));

        if (Global.isDev) logger.debug("[health detail] send:{}", res);
        return res;
    }

    //상세
    public ResultMap detail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health detail] recv:{}", req);

        mapper.updateHitcount(req);

        res.put("data", mapper.detail(req));
        res.put("file", mapper.detailFile(req));

        if (Global.isDev) logger.debug("[health detail] send:{}", res);
        return res;
    }


    /**
     * todo : 1.건강정보 저장
     * 건강정보 저장
     *
     * @param req
     * @return
     * @throws IOException
     */
    public ResultMap save(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health save] recv:{}", req);

        int lastIndex = 0;
        DbMap lastIndexMap = mapper.getLastIndex(req);
        if (lastIndexMap == null) {
            lastIndex = 0;
        } else {
            lastIndex = Integer.parseInt(lastIndexMap.get("lastIndex") + "");
        }


        if (Global.isDev) logger.debug("[health lastIndex] send:{}", lastIndex);


        req.put("regid", req.get("login_uid"));

        /**
         * 신규저장
         */
        if (req.get("isNew").equals("Y")) {

            req.put("healthindex", lastIndex + 1);
            req.put("searchcount", 0);


            mapper.insert(req);
            req.put("healthindex", lastIndex + 1);
            if (Global.isDev) logger.debug("[health insert] req:{}", req);


            /**
             * 업데이트저장
             */
        } else {

            if (Global.isDev) logger.debug("[health update] reqb:{}", req);
            mapper.update(req);
            if (Global.isDev) logger.debug("[health update] req:{}", req);
        }


        if (Global.isDev) logger.debug("[health save] send:{}", res);
        return res;
    }


    /**
     * NextIndex
     * @param req
     * @return
     */
    public int getNextIndex(RequestMap req) {

        return mapper.getNextIndex(req);
    }


    //수정
    public ResultMap modify(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health modify] recv:{}", req);

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


        if (Global.isDev) logger.debug("[health modify] send:{}", res);
        return res;
    }


    //삭제
    public ResultMap delete(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health delete] recv:{}", req);

        mapper.delete(req);

        if (Global.isDev) logger.debug("[health delete] send:{}", res);
        return res;
    }

    //비밀번호 변경
    public ResultMap initailizePwd(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health initailizePwd] recv:{}", req);

        mapper.initailizePwd(req);

        if (Global.isDev) logger.debug("[health initailizePwd] send:{}", res);
        return res;
    }


    //업로드이미지
    public ResultMap uploadImage(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[health uploadImage] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getImgKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("image_file_key", fileService.uploadFile(request, req));

        }

        if (Global.isDev) logger.debug("[health uploadImage] send:{}", res);
        return res;
    }

    //업로드파일
    public ResultMap uploadFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[health uploadFile] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getFileKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("attach_file_key", fileService.uploadFile(request, req));
        }

        if (Global.isDev) logger.debug("[health uploadFile] send:{}", res);

        return res;
    }

    //아이디체크
    public ResultMap idCheck(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health idCheck] recv:{}", req);

        int cnt = mapper.idCheck(req);

        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[health idCheck] send:{}", res);
        return res;
    }

    //아이디체크
    public ResultMap deleteFile(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health deleteFile] recv:{}", req);

        int cnt = mapper.deleteFile(req);
        fileService.deleteFile(req);
        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[health deleteFile] send:{}", res);
        return res;
    }
}
