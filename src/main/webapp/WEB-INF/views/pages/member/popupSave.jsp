<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<link rel="stylesheet" href="/dist/css/style.css?vs=170226">
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="/js/common.js"></script>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/member/excelSave"/>" method="post"
      enctype="multipart/form-data">
    <%--<div class="form-group">--%>
    <%--<label for="excelfile" class="col-sm-4 ">일괄등록파일</label>--%>

    <%--<div class="col-sm-6">--%>
    <%--<input type="file" name="excelfile" id="excelfile" placeholder="일괄등록파일" class="form-control">--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<div class="btn-box centeringContainer ">--%>
    <%--<span class="centered">--%>
    <%--<a id="saveFileBtn" class="pointer btn btn-blue-green btn-flat md-height" style="cursor:pointer">일괄등록</a>--%>
    <%--</span>--%>
    <%--</div>--%>
        <div></div>

    <c:if test="${not empty list}">
        <table>
            <tr>
                <td>idx</td>
                <td>gubun</td>
                <td>no</td>
                <td>openflag</td>
                <td>name</td>
                <td>password</td>
                <td>telephone</td>
                <td>zipcode</td>
                <td>address</td>
                <td>introduce</td>
            </tr>
            <c:forEach items="${list}" var="item" varStatus="index">
                <tr>
                    <td><input id="idx${index.index}" name="idx" value="${item.idx}"></td>
                    <td><input id="gubun${index.index}" name="gubun" value="${item.gubun}"></td>
                    <td><input id="no${index.index}" name="no" value="${item.no}"></td>
                    <td><input id="openflag${index.index}" name="openflag" value="${item.openflag}"></td>
                    <td><input id="name${index.index}" name="name" value="${item.name}"></td>
                    <td><input id="password${index.index}" name="password" value="${item.password}"></td>
                    <td><input id="telephone${index.index}" name="telephone" value="${item.telephone}"></td>
                    <td><input id="zipcode${index.index}" name="zipcode" value="${item.zipcode}"></td>
                    <td><input id="address${index.index}" name="address" value="${item.address}"></td>
                    <td><input id="introduce${index.index}" name="introduce" value="${item.introduce}"></td>
                    <td><input id="latitude${index.index}" name="latitude"></td>
                    <td><input id="longitude${index.index}" name="longitude"></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

</form>
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script>
    var searchAddressAndSave = function (idx,listLength) {
        var address = $('#address'+idx).val();
        if (address != null && address != '') {
            $.ajax({
                url: "https://apis.daum.net/local/geo/addr2coord?apikey=3449b8f92183a8efbf5dafe9ceb3c430&q=" + encodeURIComponent(address) + "&output=json",
                dataType: 'jsonp',
                jsonpCallback: "myCallback",
                success: function (data) {
                    console.log('성공 - ', data);
                    if (data) {
                        if (data.channel) {
                            if (data.channel.item.length >= 1) {
                                if (data.channel.item[0].lat) {
                                    var lat = data.channel.item[0].lat;
                                    console.log('lat - ', lat);
                                    $('#latitude'+idx).val(lat);
                                }
                                if (data.channel.item[0].lng) {
                                    var lng = data.channel.item[0].lng;

                                    console.log('lng - ', lng);

                                    $('#longitude'+idx).val(lng);
                                }


                            }

                        }

                    }

                    saveFunction(idx,listLength);
                },
                error: function (xhr) {
                    console.log('실패 - ', xhr);
                    saveFunction(idx,listLength);
                }
            });
        } else {
            saveFunction();
        }
    }

    var saveFunction = function (index,listLength) {
        console.log('idx : '+index);

        var latitude = $('#latitude'+index).val();
        var longitude = $('#longitude'+index).val();
        console.log(latitude);
        console.log(longitude);

//        $('#detailFrm').submit();
        var req = {};
//        req = $('#detailFrm').serialize();


        req.idx = $('#idx'+index).val();
        req.gubun = $('#gubun'+index).val();
        req.no = $('#no'+index).val();
        req.openflag = $('#openflag'+index).val();
        req.name = $('#name'+index).val();
        req.password = $('#password'+index).val();
        req.telephone = $('#telephone'+index).val();
        req.zipcode = $('#zipcode'+index).val();
        req.address = $('#address'+index).val();
        req.introduce = $('#introduce'+index).val();
        req.latitude = $('#latitude'+index).val();
        req.longitude = $('#longitude'+index).val();

        console.log('req========== : '+index);
        console.log(req);

        $als.execute('<c:url value="/member/excelSave"/>', req, function (data) {
            console.log(data);
            console.log('index : '+index);
            if (data.result_message == 'success') {
//                return 'success';
//        alert('삭제되었습니다.');
//        location.href='/member/list';
                nextSave(index+1,listLength);
            }
        }, function (err) {
            alert(err.result_message);
        });

    }
    var nextSave = function (index) {
        console.log('nextSave index : ' + index);
        if (listLength == index) {
            alert('저장되었습니다.');
        } else if (listLength > index) {

            searchAddressAndSave(index);
        }

    }


    $(function () {
        <c:if test="${not empty list}">
        var listLength = ${fn:length(list)}
        console.log(listLength);
//        for (var i = 0; i < listLength; i++) {
            searchAddressAndSave(0,listLength);
//        }

        </c:if>
//        $('#saveFileBtn').click(function () {
//            console.log('aaa');
//            $('#detailFrm').submit();
//        })
    });
</script>
