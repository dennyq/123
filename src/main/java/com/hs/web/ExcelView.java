package com.hs.web;

import com.hs.BizException;
import com.hs.DbList;
import com.hs.util.DateUtil;
import com.hs.util.StringUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.Map;

@Component
public class ExcelView extends AbstractExcelView {
  private static final Logger logger = LoggerFactory.getLogger(ExcelView.class);
  @Autowired private PathManager pathManager;
  private String GlobalPath =Global.UPLOAD_PATH;
  public String fs = File.separator;
  @Override
  protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
    String excelName = null;
    HSSFSheet worksheet = null;
    HSSFRow row = null;
    String idxStr = null;
    HSSFCell tCell;

    int idx = 0;
    if (ModelMap.get("idx") != null) {

      idxStr = (String) ModelMap.get("idx");
      idx = Integer.parseInt(idxStr);
    }
    String title = (String)ModelMap.get("title");
    String type = (String)ModelMap.get("type");
    String  fieldlistName[] = new String[0];
    String fieldlist[] = new String[0];
    if(type.equals("indata")){
      fieldlistName = new String[]{
              "회원아이디",
              "온도1",
              "습도1",
              "이산화탄소1",
              "온도2",
              "습도2",
              "이산화탄소2",
              "온도3",
              "습도3",
              "이산화탄소3",
              "온도4",
              "습도4",
              "이산화탄소4",
              "온도5",
              "습도5",
              "이산화탄소5",
              "온도6",
              "습도6",
              "이산화탄소6",
              "온도7",
              "습도7",
              "이산화탄소7",
              "온도8",
              "습도8",
              "이산화탄소8",
              "등록한시간"
      };


      fieldlist = new String[]{
              "memberid",
              "temperature1",
              "humidity1",
              "carbondioxide1",
              "temperature2",
              "humidity2",
              "carbondioxide2",
              "temperature3",
              "humidity3",
              "carbondioxide3",
              "temperature4",
              "humidity4",
              "carbondioxide4",
              "temperature5",
              "humidity5",
              "carbondioxide5",
              "temperature6",
              "humidity6",
              "carbondioxide6",
              "temperature7",
              "humidity7",
              "carbondioxide7",
              "temperature8",
              "humidity8",
              "carbondioxide8",
              "regtime"
      };
    }else if(type.equals("outdata")){

      fieldlistName = new String[]{
              "회원아이디",
              "감우",
              "풍향",
              "풍속",
              "일사량",
              "기상센서노드 온도",
              "기상센서노드 습도",
              "기상센서노드 감우",
              "기상센서노드 풍향",
              "기상센서노드 풍속",
              "기상센서노드 일사량",
              "등록한시간"
      };


      fieldlist = new String[]{
              "memberid",
              "rainstate",
              "winddirection",
              "windspeed",
              "wm2",
              "node_temperature",
              "node_humidity",
              "node_rainstate",
              "node_winddirection",
              "node_windspeed",
              "node_wm2",
              "regtime"
      };

    }
    excelName=URLEncoder.encode(title, "UTF-8");
    worksheet = workbook.createSheet(excelName + " WorkSheet");

    DbList list = (DbList)ModelMap.get("excelList");
    row = worksheet.createRow(0);


    for(int i = 0; i<fieldlistName.length;i++){
      String fieldName = fieldlistName[i]+"";
      row.createCell(i).setCellValue(fieldName);
    }


    CellStyle style = workbook.createCellStyle();

    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

    style.setFillForegroundColor(IndexedColors.GREEN.getIndex());

    for(int i=1;i<list.size()+1;i++){
      row = worksheet.createRow(i);



      for(int j = 0; j<fieldlist.length;j++){
        String field = fieldlist[j]+"";
        logger.info("field={}",field);
        String value = list.get(i-1).get(field)+"";
        logger.info("value={}",value);
        row.createCell(j).setCellValue(value);
      }



      if(idxStr != null ){
        int index = idx+1;
        if(index ==i){
          for(int j = 0; j<fieldlist.length;j++){
            row.getCell(j).setCellStyle(style);
          }

        }
      }
    }


    response.setContentType("Application/Msexcel");
    response.setHeader("Content-Disposition", "ATTachment; Filename=" + excelName + ".xls");
  }

  private void drawSheet( HSSFSheet sheet, HSSFWorkbook wb ,int width_start,int width_end,String imgpath,int endIdx) throws Exception {
    HSSFPatriarch patriarch = sheet.createDrawingPatriarch();

    HSSFClientAnchor anchor;
    anchor = new HSSFClientAnchor(0,0,0,255,(short)width_start,2+endIdx,(short)width_end,15+endIdx);
    anchor.setAnchorType(2);

    String result =loadPicture(imgpath, wb);

    if(!result.equalsIgnoreCase("error") && result!=null){
      int resultInt = Integer.parseInt(result);
      patriarch.createPicture(anchor,  resultInt);
    }



  }



  private String loadPicture(String path, HSSFWorkbook wb) throws Exception {
    String pictureIndex;
    FileInputStream fis = null;
    ByteArrayOutputStream bos = null;

    try {
      fis = new FileInputStream(path);

      bos = new ByteArrayOutputStream();
      int c;
      while ( (c = fis.read()) != -1) {
        bos.write( c );
      }
      pictureIndex = wb.addPicture( bos.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG)+"";
    }catch (FileNotFoundException e){
        e.printStackTrace();
      pictureIndex="error";
//      throw new BizException("9009","파일을 찾을수 없습니다.","/");
    }

    finally {
      if (fis != null) fis.close();
      if (bos != null) bos.close();
    }
    return pictureIndex;
  }

  private String getCurrentDate() {
    return DateUtil.getCurrent() + "";
  }

}

//    anchor = new HSSFClientAnchor(0,0,0,255,(short)1,4,(short)2,4); // 이미지 크기조절은 여기서..

//    HSSFClientAnchor(int dx1, int dy1, int dx2, int dy2, short col1, int row1, short col2, int row2)
//  - the x coordinate within the first cell.
//  -  - the y coordinate within the first cell.
//  - the x coordinate within the second cell.
//   - the y coordinate within the second cell.

//  - the column (0 based) of the first cell.
//   - the row (0 based) of the first cell.

//  - the column (0 based) of the second cell.
//  - the row (0 based) of the second cell.
