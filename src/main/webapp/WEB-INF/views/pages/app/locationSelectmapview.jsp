<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>지역으로 검색하기</title>
    <style>
        .content {
            min-height: 0
        }
    </style>
    <script type="text/javascript" src="/js/lib/handlebars.min.js"></script>
    <script type="text/javascript" src="/js/common_handlerbar.js"></script>
    <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=74c56e6f2090bf55cdcae9f05e8e0baa&libraries=services"></script>
</head>
<body>

<!-- Main content -->
<section class="content margin-padding-none">
    <!-- row start -->
    <div class="row margin-padding-none">
        <%--조회start--%>

        <!-- form start -->
        <form id="searchFrm" action="<c:url value="/pc/listSearchRegion"/>" class="form-horizontal" method="post">
            <input type="hidden" id="tab" name="tab" value="${tab}"/>
            <!-- box-body start -->
            <div class="box-body-noline" >
                <div class="form-group">
                    <label for="sido" class="">시.도</label>
                    <div class=" inline">
                        <select id="sido" name="sido" class="form-control" style="width: 70px;">
                            <option value="">시도를 선택하세요.</option>
                            <c:if test="${not empty param['sido']}">
                                <option value="${param['sido']}">${param['sido']}</option>
                            </c:if>
                        </select>
                    </div>

                    <label for="gungu" class="">군.구</label>
                    <div class=" inline">
                        <select id="gungu" name="gungu" class="form-control" style="width: 70px;"></select>

                    </div>

                    <label for="dongro" class="">동.로</label>
                    <div class=" inline">
                        <select id="dongro" name="dongro" class="form-control" style="width: 70px;"></select>
                    </div>
                </div>

            </div>

            <!--// box-body end -->
            <div class="btn-box">
                <center>
                    <%--<a id="searchList" class="pointer btn btn-pink-red btn-flat md-height" >리스트검색</a>--%>
                    <a id="searchMap" class="pointer btn btn-blue-green btn-flat md-height" >맵검색</a>
                </center>
            </div>
        </form>
        <!--// form end-->

        <%--조회end--%>

    </div><!-- /.row -->
</section>

<div id="map" style="width:100%;height:550px;"></div>


<script id="sido-template" type="text/x-handlebars-template">
    <option value="">시도를 선택하세요.</option>
    {{#codeList}}
    <option value="{{big_addr}}">{{big_addr}}</option>
    {{/codeList}}
</script>
<script id="gungu-template" type="text/x-handlebars-template">
    <option value="">군구를 선택하세요.</option>
    {{#codeList}}
    <option value="{{middle_addr}}">{{middle_addr}}</option>
    {{/codeList}}
</script>
<script id="dong-template" type="text/x-handlebars-template">
    <optgroup label="읍/면/동/로 선택"/>
    <optgroup label="읍/면/동">
        {{#codeList}}
        {{#if small_addr}}
        <option value="{{small_addr}}">{{small_addr}}</option>
        {{/if}}
        {{/codeList}}
        {{#codeList}}
        {{#if dong_addr}}
        <option value="{{dong_addr}}">{{dong_addr}}</option>
        {{/if}}
        {{/codeList}}
    </optgroup>
    <optgroup label="도로명">
        {{#codeListRo}}

        <option value="{{road_addr}}">{{road_addr}}</option>

        {{/codeListRo}}
    </optgroup>
</script>
<script id="result-template" type="text/x-handlebars-template">
    {{#if rows.length}}
    {{#rows}}

    <tr class="clickTr" idx="{{index}}">
        <td class="text-align-center">{{inc @index}}</td><%--번호--%>
        <td>{{name}}</td><%--이름--%>
        <td>{{address}}</td><%--주소--%>

        <td class="text-align-center">
            <form id="datailFrm{{@index}}" action="<c:url value="/app/detail"/>" class="form-horizontal" method="post">
                <input type="hidden" id="memberid" name="memberid" value="{{memberid}}"/>
                <input type="hidden" id="password" name="password" value="{{password}}"/>
                <input type="hidden" id="grade" name="grade" value="{{grade}}"/>
                <input type="hidden" id="gubun" name="gubun" value="{{gubun}}"/>
                <input type="hidden" id="openflag" name="openflag" value="{{openflag}}"/>
                <input type="hidden" id="name" name="name" value="{{name}}"/>
                <input type="hidden" id="telephone" name="telephone" value="{{telephone}}"/>
                <input type="hidden" id="handphone" name="handphone" value="{{handphone}}"/>
                <input type="hidden" id="address" name="address" value="{{address}}"/>
                <input type="hidden" id="address_etc" name="address_etc" value="{{address_etc}}"/>
                <input type="hidden" id="introduce" name="introduce" value="{{introduce}}"/>
                <input type="hidden" id="latitude" name="latitude" value="{{latitude}}"/>
                <input type="hidden" id="longitude" name="longitude" value="{{longitude}}"/>
                <input type="hidden" id="usestartdate" name="usestartdate" value="{{usestartdate}}"/>
                <input type="hidden" id="useenddate" name="useenddate" value="{{useenddate}}"/>
                <input type="hidden" id="deleteyn" name="deleteyn" value="{{deleteyn}}"/>
                <input type="hidden" id="lastconnecttime" name="lastconnecttime" value="{{lastconnecttime}}"/>
                <input type="hidden" id="regtime" name="regtime" value="{{regtime}}"/>


                <a class="showInfo pointer btn btn-right-green btn-flat md-height" idx="{{memberid}}">정보보기</a>
            </form>
        </td>

    </tr>

    {{/rows}}
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

    var tableevent = function(){
        //정보보기
        $('.showInfo').click(function(){

            console.log(this)
            var idx =$(this).attr('idx');
            location.href = '/app/detail/'+idx;

        });
    }

    var searchBigAddr = function(){
        var req = {};
        req.searchCode = '1';
        req.big_addr = this.value;
        $als.execute('/pc/searchCodeList', req, function (data) {
            console.log(data);
            if (data.result_message == 'success') {
                var source   = $("#sido-template").html();
                var template = Handlebars.compile(source);
                var html = template(data);
                $('#sido').html(html);


            }
        }, function (err) {
            alert(err.result_message);
        });
    }

    var searchMidAddr = function(thisObj){
        var req = {};
        req.searchCode = '2';
//      req.big_addr = $('#sido').val();
        req.big_addr = thisObj.value;
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
    };

    var searchSmallAddr = function(thisObj){
        var req = {};
        req.searchCode = '3';
        req.big_addr = $('#sido').val();
        req.middle_addr = thisObj.value;
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
    };

    var fn_search = function () {
        $('#searchFrm').submit();
    };



    /*var searchByAddr = function () {
        $('#map').hide();
        $('#list_wrap').show();
        // 주소로 좌표를 검색합니다
        var searchText = $('#sido').find(':selected').text()+' '+$('#gungu').find(':selected').text()+' '+$('#dongro').find(':selected').text();
        console.log('searchText : '+searchText);

        var req = {};

        req.gubun = ${gubun};
        req.searchCode = '3';
        req.addrSidoStr = $('#sido').find(':selected').text();
        req.addrLastStr = $('#gungu').find(':selected').text()+' '+$('#dongro').find(':selected').text();
        $als.execute('/pc/searchByAddr', req, function (data) {
            console.log(data);
            if (data.result_message == 'success') {
                var source   = $("#result-template").html();
                var template = Handlebars.compile(source);
                var html = template(data);
                $('#result').html(html);
                tableevent();
            }
        }, function (err) {
            alert(err.result_message);
        });

    };*/


    var setDataToMap = function (result) {
        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다

        // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
        var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}),
                contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
                markers = [], // 마커를 담을 배열입니다
                currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new daum.maps.LatLng('${param['latitude']}', '${param['longitude']}'), // 지도의 중심좌표
                    level: 4 // 지도의 확대 레벨
                };
        // 지도를 생성합니다
        var map = new daum.maps.Map(mapContainer, mapOption);
        // 마커 이미지의 이미지 주소입니다
        console.log(result);





        var imageSrc = "/imgs/pc/picker_h_open2_small.png";
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
            imageSrc = "/imgs/pc/picker_" + imgGubun + "_" + imgOpen + "2_small.png";


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
                placeinfoParentParent.css('width','100%');
            };
        }

        // 인포윈도우를 닫는 클로저를 만드는 함수입니다
        function makeOutListener(infowindow) {
            return function() {
                infowindow.close();
            };
        }

    }

    var searchByAddrMap = function () {
        $('#map').show();
        $('#list_wrap').hide();
        var req = {};
//        var tab = $('#tab').val();
        req.gubun = '${gubun}';
        req.searchCode = '3';
        req.addrSidoStr = $('#sido').find(':selected').text();
        req.addrLastStr = $('#gungu').find(':selected').text()+' '+$('#dongro').find(':selected').text();
        $als.execute('/pc/searchByAddr', req, function (data) {
            console.log(data);
            if (data.result_message == 'success') {
                if (data.rows.length > 0) {
                    setDataToMap(data);
                } else {
//                    $('#map').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색 결과가 없습니다').show();
                    setDataToMap(data);
                }

            }
        }, function (err) {
            alert(err.result_message);
        });
    };



    $(function() {
        $('.datepicker').datepicker({
            format: "yyyy.mm.dd",
            todayBtn: true
        });

        setClickedMenuBold(1);
        searchBigAddr();

        $('#sido').change(function () {
            searchMidAddr(this);
        });

        $('#gungu').change(function () {
            searchSmallAddr(this);
        });

        $('ul.sidebar-menu li.treeview').each(function(index){
            $(this).removeClass('active');
            var menu = $(this).attr('menu');
            if(menu=='관리'){
                $(this).addClass('active')
            }
        });


//        $('#searchList').click(function(){
//            searchByAddr();
//        });



        $('#searchMap').click(function(){
            searchByAddrMap();
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
