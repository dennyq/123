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

  <div id="map" style="width:100%;height:150px;"></div>

</section>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=74c56e6f2090bf55cdcae9f05e8e0baa&libraries=services"></script>
<script>


    var setDataToMap = function (result) {
        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다


        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng('${param['latitude']}', '${param['longitude']}'), // 지도의 중심좌표
            level: 4 // 지도의 확대 레벨
        };


        // 지도를 생성합니다
        var map = new daum.maps.Map(mapContainer, mapOption);
        // 마커 이미지의 이미지 주소입니다
        console.log(result);


        var imageSrc = "/imgs/pc/picker_h_open2_small.png?vs=2";

        var points = [];
        for (var i = 0; i < result.rows.length; i++) {
            var items = result.rows[i];
            if (parseInt(items.latitude) != 0 && parseInt(items.longitude) != 0) {
                points.push(new daum.maps.LatLng(items.latitude, items.longitude));
            }

        }

        var bounds = new daum.maps.LatLngBounds();


        var laloList = [];
        for (var i = 0; i < result.rows.length; i++) {
            var items = result.rows[i];
            laloList.push(items.latitude + ',' + items.longitude);
        }


        var cnt = 0;
        for (var i = 0; i < result.rows.length; i++) {
            var items = result.rows[i];

            if (parseInt(items.latitude) != 0 && parseInt(items.longitude) != 0) {


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

                imageSrc = "/imgs/img_recent_location.png?vs=2";

                //todo: 마커 이미지를 생성합니다
                var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

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
                        '<a class="title"  title="' + items.name + '">' + items.name + '</a>';
                iwContent += '<span title="' + items.address + '">' + items.address + '</span>';
                iwContent += '<span class="tel">' + ((items.telephone != null) && items.telephone) ? items.telephone : "" + '</span>' +
                '</div>' +
                '<div class="after"></div>';

                var infowindow = new daum.maps.InfoWindow({
                    content: iwContent
                });

//                map.setBounds(bounds);
                map.setCenter(new daum.maps.LatLng(items.latitude , items.longitude-0.0006));
            }

        }


        // 인포윈도우를 표시하는 클로저를 만드는 함수입니다
        function makeOverListener(map, marker, infowindow) {
            var iw = infowindow;

            return function () {
                infowindow.open(map, marker);
                $('.closeOverlay').click(function () {
                    iw.close();
                })
                var placeinfo = $('.placeinfo');
                var placeinfoParent = placeinfo.parent();
                var placeinfoParentParent = placeinfoParent.parent();
                placeinfoParent.css('width', '155px');
                placeinfoParentParent.css('border', '1px solid #fff');
                placeinfoParentParent.css('border-radius', '6px');
                placeinfoParentParent.css('width', '100%');
            };
        }

        // 인포윈도우를 닫는 클로저를 만드는 함수입니다
        function makeOutListener(infowindow) {
            return function () {
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
      var data = {};
      data.rows = [];
      data.rows.push(req);

      setDataToMap(data);

  };



  $(function() {
    search();
//    playlist();
    $('.container').css({'width':'100%','padding':'0px'});
    $('.content').css({'padding':'0px'});
//      $('#map').css({'heigth':'100%'})
  });

</script>
</body>
</html>
