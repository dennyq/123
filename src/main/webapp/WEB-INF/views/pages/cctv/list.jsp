<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>사용자 관리</title>

  <%--<script src="<c:url value="/WEB-INF/views/list.js"/>"></script>--%>
</head>
<body>
<section class="content-header">
  <h1>
    사용자 관리
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/member/list"/>">영상 보기</a></li>
    <li ><a href="<c:url value="/member/list"/>">영상 보기</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="paddingInside">

      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <div class="box-header-sm">
              <h3 class="box-title"><img src="/imgs/h3_bullet.png"/>영상보기</h3>
            </div>
            <input type="hidden" id="loginip" name="loginip" value="${loginip}"/>
            <input type="hidden" id="port" name="port" value="${port}"/>
            <input type="hidden" id="username" name="username" value="${username}"/>
            <input type="hidden" id="password" name="password" value="${password}"/>

            <select id="streamtype" class="sel none">
              <option value="1">Main stream</option>
              <option value="2">Sub stream</option>
            </select>
            <select id="ip" class="sel none" onchange="getChannelInfo();"></select>



          </div>
          <!-- bottm25 -->
          <div><a href="/download.do">* dvr 필요 실행파일 다운로드</a></div>
          <div class="wrap-box">
            <div class="gray-box left">
              <div class="upper-gray-box">
                <span class="left">

                     <select id="channels" class="sel" onchange="clickStartRealPlay();"></select>
                </span>
              <span class="right">
                <input type="radio" name="camera1" checked onclick="clickStartRealPlay();"/> 켜기
                <input type="radio" name="camera1" onclick="clickStopRealPlay();" checked/> 끄기
              </span>
              </div>
              <div id="plugin-box1" class="lower-gray-box">
                <div  id="divPlugin" class="plugin"></div>
                <%--<div  id="divPlugin" class="plugin"></div>--%>
              </div>
            </div>

            <%--<div class="gray-box right">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">2번 카메라</span>--%>
              <%--<span class="right">--%>
                 <%--<input type="radio" name="camera2" checked onclick="clickStartRealPlay(2);"/> 켜기--%>
                <%--<input type="radio" name="camera2" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box2" class="lower-gray-box">--%>
                <%--<div  id="divPlugin2" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<!-- row end -->--%>
            <%--<div class="gray-box left">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">3번 카메라</span>--%>
              <%--<span class="right">--%>
                <%--<input type="radio" name="camera3" checked onclick="clickStartRealPlay(3);"/> 켜기--%>
                <%--<input type="radio" name="camera3" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box3" class="lower-gray-box">--%>
                <%--<div  id="divPlugin3" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>

            <%--<div class="gray-box right">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">4번 카메라</span>--%>
              <%--<span class="right">--%>
               <%--<input type="radio" name="camera4" checked onclick="clickStartRealPlay(4);"/> 켜기--%>
                <%--<input type="radio" name="camera4" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box4" class="lower-gray-box">--%>
                <%--<div  id="divPlugin4" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<!-- row end -->--%>
            <%--<div class="gray-box left">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">5번 카메라</span>--%>
              <%--<span class="right">--%>
                 <%--<input type="radio" name="camera5" checked onclick="clickStartRealPlay(5);"/> 켜기--%>
                <%--<input type="radio" name="camera5" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box5" class="lower-gray-box">--%>
                <%--<div  id="divPlugin5" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>

            <%--<div class="gray-box right">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">6번 카메라</span>--%>
              <%--<span class="right">--%>
                <%--<input type="radio" name="camera6" checked onclick="clickStartRealPlay(6);"/> 켜기--%>
                <%--<input type="radio" name="camera6" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box6" class="lower-gray-box">--%>
                <%--<div  id="divPlugin6" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<!-- row end -->--%>
            <%--<div class="gray-box left">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">7번 카메라</span>--%>
              <%--<span class="right">--%>
                  <%--<input type="radio" name="camera7" checked onclick="clickStartRealPlay(7);"/> 켜기--%>
                <%--<input type="radio" name="camera7" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box7" class="lower-gray-box">--%>
                <%--<div  id="divPlugin7" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>

            <%--<div class="gray-box right">--%>
              <%--<div class="upper-gray-box">--%>
                <%--<span class="left">8번 카메라</span>--%>
              <%--<span class="right">--%>
                 <%--<input type="radio" name="camera8" checked onclick="clickStartRealPlay(8);"/> 켜기--%>
                <%--<input type="radio" name="camera8" onclick="clickStopRealPlay();" checked/> 끄기--%>
              <%--</span>--%>
              <%--</div>--%>
              <%--<div id="plugin-box8" class="lower-gray-box">--%>
                <%--<div  id="divPlugin8" class="plugin"></div>--%>
              <%--</div>--%>
            <%--</div>--%>
            <!-- row end -->

          </div>


        </div>
        <!-- /.col-md-12 -->
      </div>
      <!-- /.row -->
    <%--<div><a href="WebComponents.exe">dvr 필요 실행파일</a></div>--%>


  </div>
</section>

<!-- /.content -->
<%--<script src="jquery-1.7.1.min.js"></script>--%>
<script src="<c:url value="/js/lib/webVideoCtrl.js"/>"></script>
<script src="<c:url value="/js/cctv.js"/>"></script>
<%--<script src="<c:url value="/js/cctv2.js"/>"></script>--%>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    //alert(11);
    //var page = $(this).attr('page');
    console.log(page)
    //alert(page)
    $("#page").val(page);
    fn_search();
  };
  function fn_search(){
    $('#searchFrm').submit();
  }
  $(function() {

    setClickedMenuBold(1);

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')

      var menu = $(this).attr('menu');

      if(menu=='영상보기'){
        $(this).addClass('active');
        $('.content-header>h1').text(menu);
      }
    });
    changeWndNum(1);
    var result = '${result}';
    if(result != 'no_data'){
      clickLogin();
    }else{
      alert('영상보기에 필요한 정보가 없습니다.\n사용자정보에서 ipaddress와 카메라정보를 확인하세요');
    }



    $('#searchBtn').click(function(){
      $('#searchFrm').submit();
    });

    $('.clickTr').on('click',function(){

      var idx = $(this).attr('idx');
      var trid = $('.clickTr').attr('idx');
      $('.clickTr').each(function(index){
        $(this).find('td').removeClass('click-bg');
        $(this).find('th').removeClass('click-bg');
        var trid = $(this).attr('idx');
        if(idx==trid){
          $(this).find('td').addClass('click-bg');
          $(this).find('th').addClass('click-bg');
        }
      });


      $('#isClicked').val(idx);

    });

    $('.clickTr').on('dblclick',function(){

      var idx = $(this).attr('idx');



      location.href = '/member/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
//      location.href = '/member/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/member/list/' + page;
//      $('#searchFrm').submit();
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
