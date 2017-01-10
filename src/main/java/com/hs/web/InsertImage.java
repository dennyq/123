package com.hs.web;

import java.util.*;
import java.io.*;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem.*;
import org.apache.poi.poifs.eventfilesystem.*;
import org.springframework.stereotype.Component;

@Component
public class InsertImage {
  public static void main(String[] args) throws IOException {
    POIFSFileSystem fs      = new POIFSFileSystem(new FileInputStream("/xxx/test.xls")); // 원본엑셀파일
    HSSFWorkbook    wb      = new HSSFWorkbook(fs);
    HSSFSheet       sheet   = wb.getSheetAt(0);

    drawSheet5( sheet, wb );

    // Write the file out.
    FileOutputStream fileOut = new FileOutputStream("/xxx/img_work.xls"); // 이미지 삽입된 엑셀파일
    wb.write(fileOut);
    fileOut.close();
  }

  private static void drawSheet5( HSSFSheet sheet, HSSFWorkbook wb ) throws IOException {
    // Create the drawing patriarch.  This is the top level container for
    // all shapes. This will clear out any existing shapes for that sheet.
    HSSFPatriarch patriarch = sheet.createDrawingPatriarch();

    HSSFClientAnchor anchor;
    anchor = new HSSFClientAnchor(0,0,0,255,(short)1,4,(short)2,4); // 이미지 크기조절은 여기서..
    anchor.setAnchorType( 2 );
    patriarch.createPicture(anchor, loadPicture( "/xxx/okjsp.jpg", wb )); // 삽입 할 이미지
  }

  private static int loadPicture( String path, HSSFWorkbook wb ) throws IOException {
    int pictureIndex;
    FileInputStream fis = null;
    ByteArrayOutputStream bos = null;

    try {
      fis = new FileInputStream( path);
      bos = new ByteArrayOutputStream( );
      int c;
      while ( (c = fis.read()) != -1) {
        bos.write( c );
      }
      pictureIndex = wb.addPicture( bos.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG  );
    } finally {
      if (fis != null) fis.close();
      if (bos != null) bos.close();
    }
    return pictureIndex;
  }
}