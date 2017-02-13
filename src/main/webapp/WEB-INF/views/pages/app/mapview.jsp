<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>맵뷰</title>
  <style>

  </style>

</head>
<body>

  <!-- Main content -->
<section class="content">

  <div id="map" style="width:100%;height:700px;"></div>
  <div id="list_wrap" style="width:100%;height:350px;"></div>
</section>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3449b8f92183a8efbf5dafe9ceb3c430&libraries=services"></script>
<script>


  var setDataToMap = function (result) {
    // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다

    // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
    var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
            markers = [], // 마커를 담을 배열입니다
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
              center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
            };
    // 지도를 생성합니다
    var map = new daum.maps.Map(mapContainer, mapOption);
    // 마커 이미지의 이미지 주소입니다
    console.log(result);

    var imageSrc = "/imgs/picker_h_open.png";
//      var latSum = 0;
//      var lngSum = 0;
    var points=[];
    for (var i = 0; i < result.rows.length; i ++) {
      var items = result.rows[i];
      points.push(new daum.maps.LatLng(items.latitude, items.longitude));
    }

    var bounds = new daum.maps.LatLngBounds();
    for (var i = 0; i < result.rows.length; i++) {
      var items = result.rows[i];

      // 마커 이미지의 이미지 크기 입니다
      var imageSize = new daum.maps.Size(24, 35);

      var imgGubun = '';
      var imgOpen = '';

      if (result.rows[i].openflag == 1) {
        imgOpen = 'open';
      } else {
        imgOpen = 'close';
      }

      if (result.rows[i].gubun == 1) {
        imgGubun = 'p';
      } else {
        imgGubun = 'h';
      }
      imageSrc = "/imgs/picker_" + imgGubun + "_" + imgOpen + ".png";

      // 마커 이미지를 생성합니다
      var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

      // 마커를 생성합니다
      var marker = new daum.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: new daum.maps.LatLng(items.latitude, items.longitude), // 마커를 표시할 위치
        name: items.name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image: markerImage, // 마커 이미지
        clickable: true
      });


      // LatLngBounds 객체에 좌표를 추가합니다
      bounds.extend(points[i]);
      // 인포윈도우를 생성합니다


      var iwContent = '<div class="placeinfo">' +
              '<span class="closeOverlay" style=" float: right; width: 23px; text-align: center; line-height: 2.5;cursor: pointer ">x</span>' +
              '<a class="title" href="/app/detail/' + items.memberid + '"   title="' + items.name + '">' + items.name + '</a>';
      iwContent += '<span title="' + items.address + '">' + items.address + '</span>';
      iwContent += '<span class="tel">' + ((items.telephone != null) && items.telephone) ? items.telephone : "" + '</span>' +
      '</div>' +
      '<div class="after"></div>';

      var infowindow = new daum.maps.InfoWindow({
        content: iwContent
      });

      daum.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    }


    map.setBounds(bounds);


    // 인포윈도우를 표시하는 클로저를 만드는 함수입니다
    function makeOverListener(map, marker, infowindow) {
      var iw = infowindow;

      return function() {
        infowindow.open(map, marker);
        $('.closeOverlay').click(function(){
          iw.close();
        })
        var placeinfo= $('.placeinfo');
        var placeinfoParent = placeinfo.parent();
        var placeinfoParentParent = placeinfoParent.parent();
        placeinfoParent.css('width','155px');
        placeinfoParentParent.css('border','1px solid #fff');
        placeinfoParentParent.css('border-radius','6px');
      };
    }

    // 인포윈도우를 닫는 클로저를 만드는 함수입니다
    function makeOutListener(infowindow) {
      return function() {
        infowindow.close();
      };
    }

  }

  var search = function () {
    $('#map').show();
    $('#list_wrap').hide();
    var req = {};
    req.gubun = '${param['gubun']}';
    req.latitude = '${param['latitude']}';
    req.longitude = '${param['longitude']}';

    $als.execute('/app/search', req, function (data) {
      console.log(data);
      if (data.result_message == 'success') {
        if(data.rows.length>0){
          setDataToMap(data);

        }else{
          $('#map').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색 결과가 없습니다').show();

        }

      }
    }, function (err) {
      alert(err.result_message);
    });
  };


  $(function() {
    search();

  });

</script>
</body>
</html>
