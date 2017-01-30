<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>지역으로 검색하기</title>
  <style>

  </style>
  <script type="text/javascript" src="/js/lib/handlebars.min.js"></script>
  <script type="text/javascript" src="/js/common_handlerbar.js"></script>
  <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3449b8f92183a8efbf5dafe9ceb3c430&libraries=services"></script>
</head>
<body>
<center>
  <section class="content-header">
    <h1 class="big-font">
      <span class="marinblue">지역</span>으로 선택하기
    </h1>
  </section>
</center>
  <!-- Main content -->
  <section class="content">
    <!-- row start -->
    <div class="row">
      <!-- col-md-12 start -->
      <ul class="all-tab" style="">
        <li class="clickTab" tab="1"><img src="/imgs/pc/bt_tab1<c:if test="${tab=='1'}">_on</c:if>.png"
                <c:if test="${tab eq '1'}">  onmouseover="swapOutImg(this,'_on');" onmouseout="swapOverImg(this,'_on');" </c:if>
                <c:if test="${tab ne '1'}">  onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');" </c:if>
                /></li>
        <li class="clickTab" tab="2"><img src="/imgs/pc/bt_tab2<c:if test="${tab=='2'}">_on</c:if>.png"
                <c:if test="${tab eq '2'}">  onmouseover="swapOutImg(this,'_on');" onmouseout="swapOverImg(this,'_on');" </c:if>
                <c:if test="${tab ne '2'}">  onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');" </c:if>
                /></li>
        <li class="clickTab" tab="3"><img src="/imgs/pc/bt_tab3<c:if test="${tab=='3'}">_on</c:if>.png"
                <c:if test="${tab eq '3'}">  onmouseover="swapOutImg(this,'_on');" onmouseout="swapOverImg(this,'_on');" </c:if>
                <c:if test="${tab ne '3'}">  onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');" </c:if>
                /></li>
      </ul>
      <%--조회start--%>
      <div class="col-md-12">
        <!-- bottom-25 start -->
        <div class="bottom-25">
          <div class="box-header-sm">
            <h3 class="box-title">위치 선택</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/pc/search"/>" class="form-horizontal" method="post">
              <input type="hidden" id="tab" name="tab" value="${tab}"/>
            <!-- box-body start -->
            <div class="box-body bg-gray" >
              <center>
                <div class="form-group left marginright3select">
                  <label for="sido" class="col-sm-3">시.도</label>
                  <div class="col-sm-9">
                    <select id="sido" name="sido" class="form-control" style="width: 230px;">
                      <option value="">시도를 선택하세요.</option>
                    <c:forEach items="${codeList}" var="item" varStatus="idx">
                     <option value="${item.code}">${item.codename}</option>
                    </c:forEach>
                    </select>
                  </div>
                </div>
                <div class="form-group left marginright3select">
                  <label for="gungu" class="col-sm-3">군.구</label>
                  <div class="col-sm-9">
                    <select id="gungu" name="gungu" class="form-control" style="width: 230px;"></select>

                  </div>
                </div>
                <div class="form-group left marginright3select">
                  <label for="dongro" class="col-sm-3">동.로</label>
                  <div class="col-sm-9">
                    <select id="dongro" name="dongro" class="form-control" style="width: 230px;"></select>
                  </div>
                </div>
              </center>


            </div>
            <!--// box-body end -->
            <div class="btn-box">
              <center>
                  <a id="searchList" class="pointer btn btn-pink-red btn-flat md-height" >리스트검색</a>
                  <a id="searchMap" class="pointer btn btn-blue-green btn-flat md-height" >맵검색</a>
              </center>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>
      <%--조회end--%>
      <%--결과start--%>
      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title"> 조회 결과</h3>
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="7%"/><%--번호--%>
                <col width="20%"/><%--이름--%>
                <col width="*"/><%--주소--%>
                <col width="15%"/><%--정보보기--%>

              </colgroup>
              <thead>
                <tr class="bg-gray text-align-center">
                  <td>번호</td>
                  <td>이름</td>
                  <td>주소</td>
                  <td>정보보기</td>
                </tr>
              </thead>
              <tbody id="result">
                <tr>
                  <td colspan="10" class="text-align-center">지역을 선택한후 검색해주세요.</td>
                </tr>
              </tbody>
            </table>

          </div>
          <div class="box-footer clearfix">

          </div>
        </div>
        <center>
          <%--<div class="btn_bottom" style="margin-top: -20px;">--%>
            <%--${paging}--%>
          <%--</div>--%>
        </center>
      </div>
      <%--결과end--%>

    </div><!-- /.row -->
  </section>


<div class="map_wrap">
  <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
  <ul id="category">
    <li id="PM9" data-order="0">
      <span class="category_bg pharmacy"></span>
      약국
    </li>
    <li id="HP8" data-order="1">
      <span class="category_bg hospital"></span>
      병원
    </li>


  </ul>
</div>
  <!-- /.content -->

<script id="gungu-template" type="text/x-handlebars-template">
  <option value="">군구를 선택하세요.</option>
  {{#codeList}}
  <option value="{{code}}">{{codename}}</option>
  {{/codeList}}
</script>
<script id="dong-template" type="text/x-handlebars-template">
  <option value="">동을 선택하세요.</option>
  {{#codeList}}
  <option value="{{code}}">{{codename}}</option>
  {{/codeList}}
</script>
<script id="result-template" type="text/x-handlebars-template">
    {{#if places.length}}
  {{#places}}

      <tr class="clickTr" idx="{{index}}">
        <td class="text-align-center">{{inc @index}}</td><%--번호--%>
        <td>{{title}}</td><%--이름--%>
        <td>{{address}}</td><%--주소--%>

        <td class="text-align-center">
            <form id="datailFrm{{@index}}" action="<c:url value="/pc/detail"/>" class="form-horizontal" method="post">
            <input id="address" name="address" value="{{address}}"/>
            <input id="addressBCode" name="addressBCode" value="{{addressBCode}}"/>
            <input id="category2" name="category" value="{{category}}"/>
            <input id="direction" name="direction" value="{{direction}}"/>
            <input id="distance" name="distance" value="{{distance}}"/>
            <input id="id" name="id" value="{{id}}"/>
            <input id="imageUrl" name="imageUrl" value="{{imageUrl}}"/>
            <input id="latitude" name="latitude" value="{{latitude}}"/>
            <input id="longitude" name="longitude" value="{{longitude}}"/>
            <input id="newAddress" name="newAddress" value="{{newAddress}}"/>
            <input id="phone" name="phone" value="{{phone}}"/>
            <input id="placeUrl" name="placeUrl" value="{{placeUrl}}"/>
            <input id="title" name="title" value="{{title}}"/>
            <input id="zipcode" name="zipcode" value="{{zipcode}}"/>

            <a class="showInfo pointer btn btn-right-green btn-flat md-height" >정보보기</a>
            </form>
        </td>

      </tr>

  {{/places}}
    {{else}}
    <tr >
        <td colspan="10">데이터가 없습니다.</td>
    </tr>
    {{/if}}
</script>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    $("#page").val(page);
    fn_search();
  };

  function fn_search(){
    $('#searchFrm').submit();
  }
  $(function() {
    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//      startDate: '+0d',
      todayBtn: true
    });

    setClickedMenuBold(1);

    $('#sido').change(function(){
      var req = {};
      req.sch_codegroup = 'gungu';
      req.sch_uppercode = this.value;
      $als.execute('/pc/searchCodeList', req, function (data) {
        console.log(data);
        if (data.result_message == 'success') {
          var source   = $("#gungu-template").html();
          var template = Handlebars.compile(source);
          var html = template(data);
          $('#gungu').html(html);

        }
      }, function (err) {
        alert(err.result_message);
      });
    });

    $('#gungu').change(function(){
      var req = {};
      req.sch_codegroup = 'dong';
      req.sch_uppercode = this.value;
      $als.execute('/pc/searchCodeList', req, function (data) {
        console.log(data);
        if (data.result_message == 'success') {
          var source   = $("#dong-template").html();
          var template = Handlebars.compile(source);

          var html = template(data);
          $('#dongro').html(html);

        }
      }, function (err) {
        alert(err.result_message);
      });
    });

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='관리'){
        $(this).addClass('active')
      }
    });


    $('#searchList').click(function(){
      // 장소 검색 객체를 생성합니다

      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}),
              contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
              markers = [], // 마커를 담을 배열입니다
              currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
              };

      // 지도를 생성합니다
      var map = new daum.maps.Map(mapContainer, mapOption);

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new daum.maps.services.Geocoder();

      // 주소로 좌표를 검색합니다

      var searchText = $('#sido').find(':selected').text()+' '+$('#gungu').find(':selected').text()+' '+$('#dongro').find(':selected').text();
      console.log('searchText : '+searchText)

      geocoder.addr2coord(searchText, function(status, result) {

        // 정상적으로 검색이 완료됐으면
        if (status === daum.maps.services.Status.OK) {
          //doCategorySearch(result);

          var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

          // 결과값으로 받은 위치를 마커로 표시합니다
//          var marker = new daum.maps.Marker({
//            map: map,
//            position: coords
//          });

          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
          map.setCenter(coords);

          //////////////////////////
          // 장소 검색 객체를 생성합니다
          var ps = new daum.maps.services.Places(map);

          // 지도에 idle 이벤트를 등록합니다
          daum.maps.event.addListener(map, 'idle', searchPlaces);

          // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
          contentNode.className = 'placeinfo_wrap';

          // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
          // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다
          addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
          addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);

          // 커스텀 오버레이 컨텐츠를 설정합니다
          placeOverlay.setContent(contentNode);

          // 각 카테고리에 클릭 이벤트를 등록합니다
          addCategoryClickEvent();

            var tab = $('#tab').val();
            console.log(tab);
            var categoriId;
            if(tab==2){
                categoriId = 'PM9';
            }else   if(tab==3){
                categoriId = 'HP8';
            }else{

            }
            var id = categoriId,
                    className = this.className;
            console.log('className');
            console.log(className);

            placeOverlay.setMap(null);

//            if (className === 'on') {
//                currCategory = '';
//                changeCategoryClass();
//                removeMarker();
//            } else {
                currCategory = id;
                changeCategoryClass(this);
                searchPlaces();
//            }

          // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
          function addEventHandle(target, type, callback) {
            if (target.addEventListener) {
              target.addEventListener(type, callback);
            } else {
              target.attachEvent('on' + type, callback);
            }
          }

          // 카테고리 검색을 요청하는 함수입니다
          function searchPlaces() {
            if (!currCategory) {
              return;
            }

            // 커스텀 오버레이를 숨깁니다
            placeOverlay.setMap(null);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});
          }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
          function placesSearchCB( status, data, pagination ) {
            if (status === daum.maps.services.Status.OK) {

                console.log(data);
              // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
              var source = $("#result-template").html();
              var template = Handlebars.compile(source);
              var html = template(data);
              $('#result').html(html);

                $('.showInfo').click(function(){
                    var frm = $(this).closest('form');
                    console.log(frm);
                    frm.submit();
                });
              displayPlaces(data.places);

            } else if (status === daum.maps.services.Status.ZERO_RESULT) {
              // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

            } else if (status === daum.maps.services.Status.ERROR) {
              // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

            }
          }

          // 지도에 마커를 표출하는 함수입니다
          function displayPlaces(places) {

            // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
            // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
            var order = document.getElementById(currCategory).getAttribute('data-order');



            for ( var i=0; i<places.length; i++ ) {

              // 마커를 생성하고 지도에 표시합니다
              var marker = addMarker(new daum.maps.LatLng(places[i].latitude, places[i].longitude), order);

              // 마커와 검색결과 항목을 클릭 했을 때
              // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
              (function(marker, place) {
                daum.maps.event.addListener(marker, 'click', function() {
                  displayPlaceInfo(place);
                });
              })(marker, places[i]);
            }
          }

          // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
          function addMarker(position, order) {
            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new daum.maps.Size(27, 28),  // 마커 이미지의 크기
                    imgOptions =  {
                      spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
                      spriteOrigin : new daum.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                      offset: new daum.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    marker = new daum.maps.Marker({
                      position: position, // 마커의 위치
                      image: markerImage
                    });

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
          }

          // 지도 위에 표시되고 있는 마커를 모두 제거합니다
          function removeMarker() {
            for ( var i = 0; i < markers.length; i++ ) {
              markers[i].setMap(null);
            }
            markers = [];
          }

        // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
          function displayPlaceInfo (place) {
            var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.placeUrl + '" target="_blank" title="' + place.title + '">' + place.title + '</a>';

            if (place.newAddress) {
              content += '    <span title="' + place.newAddress + '">' + place.newAddress + '</span>' +
                      '  <span class="jibun" title="' + place.address + '">(지번 : ' + place.address + ')</span>';
            }  else {
              content += '    <span title="' + place.address + '">' + place.address + '</span>';
            }

            content += '    <span class="tel">' + place.phone + '</span>' +
                    '</div>' +
                    '<div class="after"></div>';

            contentNode.innerHTML = content;
            placeOverlay.setPosition(new daum.maps.LatLng(place.latitude, place.longitude));
            placeOverlay.setMap(map);
          }


        // 각 카테고리에 클릭 이벤트를 등록합니다
          function addCategoryClickEvent() {
            var category = document.getElementById('category'),
                    children = category.children;

            for (var i=0; i<children.length; i++) {
              children[i].onclick = onClickCategory;
            }
          }

        // 카테고리를 클릭했을 때 호출되는 함수입니다
          function onClickCategory() {
            var id = this.id,
                    className = this.className;

            placeOverlay.setMap(null);

            if (className === 'on') {
              currCategory = '';
              changeCategoryClass();
              removeMarker();
            } else {
              currCategory = id;
              changeCategoryClass(this);
              searchPlaces();
            }
          }

          // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
          function changeCategoryClass(el) {
            var category = document.getElementById('category'),
                    children = category.children,
                    i;

            for ( i=0; i<children.length; i++ ) {
              children[i].className = '';
            }

            if (el) {
              el.className = 'on';
            }
          }
        }
      });




    });
    $('#searchMap').click(function(){
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
      console.log('idx : '+idx);
      location.href = '/member/detail/' + idx;

      <%--var change_uid = $('#isClicked').val();--%>
      <%--location.href = '<c:url value="/member/change/"/>'+change_uid;--%>
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
      var page = $(this).attr('page');
      location.href = '/member/list/' + page;
    });

    $('.clickTab').click(function(){
        var tab = $(this).attr('tab');
        $('#tab').val(tab);
        $('#searchFrm').submit();
    });



  });
  <!-- bind end -->

</script>
</body>
</html>
