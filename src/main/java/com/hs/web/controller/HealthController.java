package com.hs.web.controller;

import com.hs.BizException;
import com.hs.ResultMap;
import com.hs.web.ControllerPageBase;
import com.hs.web.Global;
import com.hs.web.RequestMap;
import com.hs.web.service.FileService;
import com.hs.web.service.HealthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Iterator;
import java.util.UUID;

// 전문가
@Controller
@RequestMapping(value = "/health")
public class HealthController extends ControllerPageBase {
    @Autowired
    private HealthService service;
    @Autowired
    private FileService fileService;

    private static final Logger logger = LoggerFactory.getLogger(HealthController.class);
    private String rootKey = "health";
    private String rootPath = "pages/" + rootKey + "/";


    /**
     * index redirect
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/")
    public String index(HttpServletRequest request) throws Exception {

        return "redirect:/health/list";

    }

    //todo: 여기서 관리자용, sepecial 용으로 나누자.


    /**
     * 페이지목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "list/{page}")
    public String listPage(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.list(req));
        String Path = request.getContextPath();
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "list";
    }

    /**
     * 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        model.addAttribute("thisPath","/"+rootKey);
        logger.debug("thisPath={}","/"+rootKey);
        return rootPath + "list";
    }

    /**
     * 검색
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "search")
    public String search(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAllAttributes(service.list(req));
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "list";
    }


    /**
     * 쓰기페이지
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail")
    public String input(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        model.addAttribute("thisPath","/"+rootKey);
        model.addAttribute("isNew","Y");

        return rootPath + "detail";
    }

    /**
     * 상세페이지
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "detail/{healthindex}")
    public String detail(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("thisPath","/"+rootKey);
        return rootPath + "detail";
    }


    /**
     * 저장(신규/업데이트)
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    public String save(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        int healthindex = 0;
        if (req.get("login_uid") == null) {
            throw new BizException("9009", "need_login");
        }

        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;
        if (req.get("isNew").equals("Y")) {
            healthindex =  service.getNextIndex(req);
            req.put("healthindex", healthindex);
        }

        MultipartFile file = mrequest.getFile("thumbnailfile");




        MultipartFile health_file = mrequest.getFile("health_file");

        if(file!=null){
            if (file.getSize() > 0) {
                req.put("inputName","thumbnailfile");

                fileService.uploadFiles(request, req);


            } else {
                req.put("thumbnailfile", null);
            }



        }

        if(health_file!=null){
            if (health_file.getSize() > 0) {
                req.put("inputName","health_file");

                fileService.uploadFiles(request, req);

                service.saveFile(req);


                
            } else {
                req.put("health_file", null);
            }



        }

        if (Global.isDev) logger.info("[HealthController after upload] req = {}" + req);

        service.save(req);



        return "redirect:/" + rootKey + "/list";
    }



    /**
     * 저장테스트 ajax(신규/업데이트)
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "upload")
    @ResponseBody
    public ResultMap upload(MultipartHttpServletRequest request) throws Exception {
//        RequestMap req = RequestMap.create(request);
//        if (Global.isDev) logger.debug("[health upload] recv:{}", req);
//        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf;
//        List<Image> list = new LinkedList<>();

        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            logger.debug("Uploading {}", mpf.getOriginalFilename());

            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            String newFilename = newFilenameBase + originalFileExtension;
//            String storageDirectory = fileUploadDirectory;
//            String contentType = mpf.getContentType();
//            logger.error(" upload file "+mpf.getOriginalFilename());
//            File newFile = new File(storageDirectory + "/" + newFilename);
//            try {
//                mpf.transferTo(newFile);
//
//                BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 290);
//                String thumbnailFilename = newFilenameBase + "-thumbnail.png";
//                File thumbnailFile = new File(storageDirectory + "/" + thumbnailFilename);
//                ImageIO.write(thumbnail, "png", thumbnailFile);
//
//                Image image = new Image();
//                image.setName(mpf.getOriginalFilename());
//                image.setThumbnailFilename(thumbnailFilename);
//                image.setNewFilename(newFilename);
//                image.setContentType(contentType);
//                image.setSize(mpf.getSize());
//                image.setThumbnailSize(thumbnailFile.length());
//                image = imageDao.create(image);
//
//                image.setUrl("/picture/"+image.getId());
//                image.setThumbnailUrl("/thumbnail/"+image.getId());
//                image.setDeleteUrl("/delete/"+image.getId());
//                image.setDeleteType("DELETE");
//
//                list.add(image);
//
//            } catch(IOException e) {
//
//            }

        }

//        Map<String, Object> files = new HashMap<>();
//        files.put("files", list);
        ResultMap res = ResultMap.create();
        if (Global.isDev) logger.debug("[health upload] send:{}", res);
       return res;
    }


    //일괄등록팝업
    @RequestMapping(value = "popup")
    public String popup(HttpServletRequest request, Model model) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        model.addAllAttributes(service.detail(req));
        model.addAttribute("thisPath",rootKey);
        return rootPath + "popup";
    }






    //수정
    @RequestMapping(value = "modify")
    @ResponseBody
    public ResultMap modify(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.modify(req);
    }

    //삭제
    @RequestMapping(value = "delete")
    @ResponseBody
    public ResultMap delete(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.delete(req);
    }


    //아이디체크
    @RequestMapping(value = "idCheck")
    @ResponseBody
    public ResultMap idCheck(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.idCheck(req);
    }

    //deleteFile
    @RequestMapping(value = "deleteFile")
    @ResponseBody
    public ResultMap deleteFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.deleteFile(req);
    }

    //deleteFile
    @RequestMapping(value = "deleteFile/{healthindex}")
    @ResponseBody
    public ResultMap deleteFiles(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        return service.deleteFiles(req);
    }


    //updateContents //2017.08.13 : -ek
    @RequestMapping(value = "updateContents/{healthindex}")
    @ResponseBody
    public ResultMap updateContents(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        return service.updateContents(req);
    }

    //updateThum //2017.08.13 : -ek
    @RequestMapping(value = "updateThum/{healthindex}")
    public String updateThum(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;
        String healthindex = req.get("healthindex")+"";
        MultipartFile file = mrequest.getFile("thumbnailfile");

        if (file != null) {
            if (file.getSize() > 0) {
                req.put("inputName", "thumbnailfile");
                fileService.uploadFiles(request, req);
                service.updateThum(req);

            } else {
                req.put("thumbnailfile", null);
            }


        }


        return "redirect:/" + rootKey + "/detail/"+healthindex;
    }

    //updateFile //2017.08.13 : -ek
    @RequestMapping(value = "updateFile/{healthindex}")
    public String updateFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        MultipartHttpServletRequest mrequest = (MultipartHttpServletRequest) request;
        String healthindex = req.get("healthindex")+"";

        MultipartFile health_file = mrequest.getFile("health_file");
        if(health_file!=null){
            if (health_file.getSize() > 0) {
                req.put("inputName","health_file");

                fileService.uploadFiles(request, req);

                service.saveFile(req);



            } else {
                req.put("health_file", null);
            }



        }
        return "redirect:/" + rootKey + "/detail/"+healthindex;
    }



    /**
     * 파일삭제.
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "deleteHealthFile/{healthindex}/{pictureorder}/{sequencenum}")
    @ResponseBody
    public ResultMap deleteHealthFile(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        logger.info("파일삭제 req={}",req);
        return service.deleteHealthFile(req);
    }

    /**
     * 순서 위로
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "upOrder/{healthindex}/{pictureorder}/{sequencenum}")
    @ResponseBody
    public ResultMap upOrder(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        return service.upOrder(req);
    }


    /**
     * 순서 아래로
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "downOrder/{healthindex}/{pictureorder}/{sequencenum}")
    @ResponseBody
    public ResultMap downOrder(HttpServletRequest request) throws Exception {
        RequestMap req = RequestMap.create(request);
        putPathVariable(request, req);
        return service.downOrder(req);
    }

}
