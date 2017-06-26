package com.hs.web.service;

import com.hs.DbList;
import com.hs.DbMap;
import com.hs.ResultMap;
import com.hs.util.PageUtil;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.ServiceBase;
import com.hs.web.mapper.NoticeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


@Service
public class NoticeService extends ServiceBase {

    private static final Logger logger = LoggerFactory.getLogger(NoticeService.class);
    @Autowired
    private NoticeMapper mapper;
    @Autowired
    private FileService fileService;


    //목록
    public ResultMap list(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice list] recv:{}", req);
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

        if (Global.isDev) logger.debug("[notice list] send:{}", res);
        return res;
    }

    //앱목록
    public ResultMap noticeList(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice list] recv:{}", req);


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

        if (Global.isDev) logger.debug("[notice list] send:{}", res);
        return res;
    }

    //앱상세
    public ResultMap noticeDetail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice detail] recv:{}", req);

        mapper.updateHitcount(req);

        res.put("data", mapper.detail(req));
        res.put("file", mapper.detailFile(req));

        if (Global.isDev) logger.debug("[notice detail] send:{}", res);
        return res;
    }

    //상세
    public ResultMap detail(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice detail] recv:{}", req);

        mapper.updateHitcount(req);

        res.put("data", mapper.detail(req));
        res.put("file", mapper.detailFile(req));

        if (Global.isDev) logger.debug("[notice detail] send:{}", res);
        return res;
    }


    //저장
    public ResultMap save(RequestMap req) throws IOException {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice save] recv:{}", req);

        int lastIndex = 0;
        DbMap lastIndexMap = mapper.getLastIndex(req);
        if (lastIndexMap == null) {
            lastIndex = 0;
        }else{
            lastIndex = Integer.parseInt(lastIndexMap.get("lastIndex")+"");
        }


        if (Global.isDev) logger.debug("[notice lastIndex] send:{}", lastIndex);
        req.put("regid",req.get("login_uid"));

        if (req.get("isNew").equals("Y")) {

            req.put("noticeindex",lastIndex+1);
            req.put("searchcount",0);


          mapper.insert(req);
          req.put("noticeindex",lastIndex+1);
            if (Global.isDev) logger.debug("[notice insert] req:{}", req);

        } else {

            if (Global.isDev) logger.debug("[notice update] reqb:{}", req);
            mapper.update(req);
            if (Global.isDev) logger.debug("[notice update] req:{}", req);
        }


        if (Global.isDev) logger.debug("[notice save] send:{}", res);
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
        if (Global.isDev) logger.debug("[notice modify] recv:{}", req);

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


        if (Global.isDev) logger.debug("[notice modify] send:{}", res);
        return res;
    }


    //삭제
    public ResultMap delete(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice delete] recv:{}", req);

        mapper.delete(req);

        if (Global.isDev) logger.debug("[notice delete] send:{}", res);
        return res;
    }

    //비밀번호 변경
    public ResultMap initailizePwd(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice initailizePwd] recv:{}", req);

        mapper.initailizePwd(req);

        if (Global.isDev) logger.debug("[notice initailizePwd] send:{}", res);
        return res;
    }


    //업로드이미지
    public ResultMap uploadImage(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[notice uploadImage] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getImgKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("image_file_key", fileService.uploadFile(request, req));

        }

        if (Global.isDev) logger.debug("[notice uploadImage] send:{}", res);
        return res;
    }

    //업로드파일
    public ResultMap uploadFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        ResultMap res = ResultMap.create();

        if (Global.isDev) logger.debug("[notice uploadFile] recv:{}", req);

        req.put("inputName", "file");

        if (request instanceof MultipartHttpServletRequest) {

            String before_file_id = mapper.getFileKey(req);
            req.put("file_id", before_file_id);
            fileService.deleteFile(req);
            res.put("attach_file_key", fileService.uploadFile(request, req));
        }

        if (Global.isDev) logger.debug("[notice uploadFile] send:{}", res);

        return res;
    }

    //아이디체크
    public ResultMap idCheck(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice idCheck] recv:{}", req);

        int cnt = mapper.idCheck(req);

        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[notice idCheck] send:{}", res);
        return res;
    }

    //아이디체크
    public ResultMap deleteFile(RequestMap req) {
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[notice deleteFile] recv:{}", req);

        int cnt = mapper.deleteFile(req);
        fileService.deleteFile(req);
        if (cnt > 0) {
            res.put("result_message", "fail");
        }

        if (Global.isDev) logger.debug("[notice deleteFile] send:{}", res);
        return res;
    }
}
