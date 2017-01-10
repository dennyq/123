package com.hs.util;


import java.util.HashMap;

public class PageUtil {
  private static final int PAGE_SIZE = 10;    // 페이지링크에서  출력되는 페이지수.

  /**
   * 검색리스트에 조건을 함께 담기 위한 pagingMapPut 구성
   *
   * @param  map	   검색조건을 포함한 맵
   * @param  totalRecord				전체레코드수
   *사용예제: res.put("paging", PageUtil.getPaging(req,  total));
   */
  public static String getPaging(HashMap map, int totalRecord) {
    int ROW_SIZE = UnitUtil.toInt(map.get("p_size"));
    int page = UnitUtil.toInt(map.get("page"));

    int numPerBlock = PAGE_SIZE;              // @ 한페이지당 보여줄 블록수 수정가능.

    int totalPage = (int) Math.ceil((double) totalRecord / ROW_SIZE);      // 총페이지 수
    int totalBlock = (int) Math.ceil((double) totalPage / numPerBlock);      // 총블럭수
    int nowBlock = (int) Math.ceil((double) page / numPerBlock);            //지금블럭

    /////////////////////////////////////////IMAGE/////URL////////////////////////////////////////////////////////////

    String firstImage = "<img src='/imgs/pprev.jpg' alt=\"pprev\"/>";
    String prepreImage = "<img src='/imgs/prev.jpg' alt=\"prev\"/>";
    String nextnextImage = "<img src='/imgs/next.jpg' alt=\"next\"/>";
    String lastImage = "<img src='/imgs/nnext.jpg' alt=\"nnext\" />";

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    StringBuilder prevString = new StringBuilder();
    StringBuilder nextString = new StringBuilder();
    StringBuilder nowString = new StringBuilder();
    int pageInt = 1 ;

    //첫페이지
    prevString.append("<a class=\"btnPpage page\" page='");
    prevString.append(pageInt).append("'>").append(firstImage).append("</a>");

    //한블럭안
    if (nowBlock <= 1) {
      prevString.append(prepreImage).append("");
    } else {
      prevString.append("<a class=\"btnPpage page\" page='");
      pageInt = (nowBlock - 2) * numPerBlock + 1;
      prevString.append(pageInt);
      prevString.append("'>").append(prepreImage).append("</a>");
    }



      for (int i = 0; i < numPerBlock; i++) {
        int printPage = ((nowBlock - 1) * numPerBlock) + i + 1;
        if (printPage == page) {

          nowString.append("<a class=\"page\" page='").append(printPage);
          nowString.append("'>").append("<strong>").append(printPage).append("</strong>").append("</a>");

        } else {
          nowString.append("<a class=\"page\" page='");
          nowString.append(printPage).append("'>");
          nowString.append(printPage).append("</a>");
        }
        if (printPage == totalPage) {
          break;
        }
      }


    //한블럭안
    if (totalBlock > nowBlock) {
      nextString.append("<a class=\"btnPpage page\" page='");
      pageInt = nowBlock * numPerBlock + 1;
      nextString.append(pageInt);
      nextString.append("'>").append(nextnextImage).append("</a>");
    } else {
      nextString.append(nextnextImage).append("");
    }

    //마지막페이지
    nextString.append("<a class=\"btnPpage page\" page='");
    nextString.append(totalPage).append("'>").append(lastImage).append("</a>");
    String returnStr="";
    if(totalRecord > 0){
      returnStr ="<p class=\"paging\"><input type=\"hidden\" id=\"page\" name=\"page\" value=\""+ page +"\" />" + prevString.toString() + "<span class=\"num\">" + nowString.toString() + "</span>" + nextString.toString() + "</p>";
    }
    return returnStr;
  }




  /**
   * 검색리스트에 조건을 함께 담기 위한 pagingMapPut 구성 페이징 함수 onClik에 명시
   *
   * @param  map	   검색조건을 포함한 맵
   * @param  totalRecord				전체레코드수
   *사용예제: res.put("paging", PageUtil.getPaging(req,  total));
   */
  public static String getReadingPaging(HashMap map, int totalRecord) {
    int ROW_SIZE = UnitUtil.toInt(map.get("p_size"));
    int page = UnitUtil.toInt(map.get("page"));

    int numPerBlock = PAGE_SIZE;              // @ 한페이지당 보여줄 블록수 수정가능.

    int totalPage = (int) Math.ceil((double) totalRecord / ROW_SIZE);      // 총페이지 수
    int totalBlock = (int) Math.ceil((double) totalPage / numPerBlock);      // 총블럭수
    int nowBlock = (int) Math.ceil((double) page / numPerBlock);            //지금블럭

    /////////////////////////////////////////IMAGE/////URL////////////////////////////////////////////////////////////

    String firstImage = "<img src='/imgs/pprev.jpg' alt=\"pprev\"/>";
    String prepreImage = "<img src='/imgs/prev.jpg' alt=\"prev\"/>";
    String nextnextImage = "<img src='/imgs/next.jpg' alt=\"next\"/>";
    String lastImage = "<img src='/imgs/nnext.jpg' alt=\"nnext\" />";

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    StringBuilder prevString = new StringBuilder();
    StringBuilder nextString = new StringBuilder();
    StringBuilder nowString = new StringBuilder();
    int pageInt = 1 ;

    //첫페이지
    prevString.append("<a href=\"javascript:fn_go_page("+pageInt+")\"  class=\"btnPpage page\" page='");
    prevString.append(pageInt).append("'>").append(firstImage).append("</a>");

    //한블럭안
    if (nowBlock <= 1) {
      prevString.append(prepreImage).append("");
    } else {
      pageInt = (nowBlock - 2) * numPerBlock + 1;

      prevString.append("<a href=\"javascript:fn_go_page("+pageInt+")\" class=\"btnPpage page\" page='");

      prevString.append(pageInt);
      prevString.append("'>").append(prepreImage).append("</a>");
    }



      for (int i = 0; i < numPerBlock; i++) {
        int printPage = ((nowBlock - 1) * numPerBlock) + i + 1;
        if (printPage == page) {

          nowString.append("<a href=\"javascript:fn_go_page("+printPage+")\" class=\"page\" page='").append(printPage);
          nowString.append("'>").append("<strong>").append(printPage).append("</strong>").append("</a>");

        } else {
          nowString.append("<a href=\"javascript:fn_go_page("+printPage+")\" class=\"page\" page='");
          nowString.append(printPage).append("'>");
          nowString.append(printPage).append("</a>");
        }
        if (printPage == totalPage) {
          break;
        }
      }


    //한블럭안
    if (totalBlock > nowBlock) {

      pageInt = nowBlock * numPerBlock + 1;


      nextString.append("<a href=\"javascript:fn_go_page("+pageInt+")\" class=\"btnPpage page\" page='");
      nextString.append(pageInt);
      nextString.append("'>").append(nextnextImage).append("</a>");
    } else {
      nextString.append(nextnextImage).append("");
    }

    //마지막페이지
    nextString.append("<a href=\"javascript:fn_go_page("+totalPage+")\" class=\"btnPpage page\" page='");
    nextString.append(totalPage).append("'>").append(lastImage).append("</a>");
    String returnStr="";
    if(totalRecord > 0){
      returnStr ="<p class=\"paging\"><input type=\"hidden\" id=\"page\" name=\"page\" value=\""+page+"\" />" + prevString.toString() + "<span class=\"num\">" + nowString.toString() + "</span>" + nextString.toString() + "</p>";
    }
    return returnStr;
  }

}