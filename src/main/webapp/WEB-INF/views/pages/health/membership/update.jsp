<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>
<input   type="hidden" id="healthindex"  name="healthindex" value="${data.healthindex}"/>
<div class="col-md-12">
    <div class="form-group">
        <label for="regid" class="col-sm-1">아이디</label>
        <div class="col-sm-2">
            <input name="regid" id="regid" placeholder="제목" class="form-control" value="${data.regid}" readonly>
        </div>
        <label for="name" class="col-sm-1">이름</label>
        <div class="col-sm-2">
            <input name="name" id="name" placeholder="제목" class="form-control" value="${data.name}" readonly>
        </div>
        <label for="telephone" class="col-sm-1">전화번호</label>
        <div class="col-sm-2">
            <input name="telephone" id="telephone" placeholder="제목" class="form-control" value="${data.telephone}" readonly>
        </div>
        <label for="handphone" class="col-sm-1">휴대폰번호</label>
        <div class="col-sm-2">
            <input name="handphone" id="handphone" placeholder="제목" class="form-control" value="${data.handphone}" readonly>
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="job" class="col-sm-1">직업</label>
        <div class="col-sm-2">
            <input name="job" id="job" placeholder="제목" class="form-control" value="${data.job}" readonly>
        </div>
        <label for="specialty" class="col-sm-1">전문</label>
        <div class="col-sm-2">
            <input name="specialty" id="specialty" placeholder="제목" class="form-control" value="${data.specialty}" readonly>
        </div>
        <label for="belongto" class="col-sm-1">소속</label>
        <div class="col-sm-2">
            <input name="belongto" id="belongto" placeholder="제목" class="form-control" value="${data.belongto}" readonly>
        </div>
        <label for="career" class="col-sm-1">경력</label>
        <div class="col-sm-2">
            <input name="career" id="career" placeholder="제목" class="form-control" value="${data.career}" readonly>
        </div>
    </div>
</div>


<div class="col-md-12">
    <div class="form-group">
        <label for="healthtitle" class="col-sm-1">제목</label>
        <div class="col-sm-11">
            <input name="healthtitle" id="healthtitle" placeholder="제목" class="form-control" value="${data.healthtitle}">
        </div>
    </div>
</div>



<div class="col-md-12">
    <div class="form-group">
        <label for="searchcount" class="col-sm-1">조회수</label>

        <div class="col-sm-2">
            <input name="searchcount" id="searchcount" placeholder="조회수" class="form-control" value="${data.searchcount}" readonly style="border: none;background: white;padding: 0 0 9px 0">
        </div>
        <label for="specialty" class="col-sm-1">하트수</label>

        <div class="col-sm-2">
            <input name="heartcount" id="heartcount" placeholder="하트수" class="form-control" value="${data.heartcount}" readonly style="border: none;background: white;padding: 0 0 9px 0">
        </div>
        <label for="regtime" class="col-sm-3">등록 시간</label>

        <div class="col-sm-3">
            <input name="regtime" id="regtime" placeholder="등록 시간" class="form-control" value="${data.regtime}" readonly style="border: none;background: white;padding: 0 0 9px 0">
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <textarea name="healthcontent" id="editor1" rows="10" cols="10">${data.healthcontent}</textarea>
        <script>CKEDITOR.replace('editor1')</script>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="thumbnailfile" class="col-sm-2 ">썸네일 : </label>
        <div class="col-sm-10">
            <a href="/upload/healthinfo/thumbnailfile/${data.thumbnailfile}" style="cursor: pointer;text-decoration: underline;color: blue"> ${data.thumbnailfile}</a>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="thumbnailfile" class="col-sm-2 ">썸네일파일수정</label>
        <div class="col-sm-10">
            <input name="thumbnailfile" id="thumbnailfile" placeholder="썸네일파일첨부" class="form-control" type="file" >
        </div>
    </div>
</div>




<div class="col-md-12">
    <div class="form-group">
        <label for="health_file" class="col-sm-2 ">사진파일</label>
        <div class="col-sm-10">
            <input name="health_file" id="health_file" placeholder="썸네일파일첨부" class="form-control" type="file" >
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="box-body table-responsive no-padding">
        <table class="table table-hover pointer">
            <colgroup>
                <col width="5%"/>
                <%--번호--%>
                <col width="*"/>
                <%--파일명 --%>
                <col width="10%"/>
                <%--사진 --%>
                <col width="5%"/>
                <%--사진순서 --%>
                <col width="10%"/>
                <%--사진순서 --%>
                <col width="10%"/>
                <%--삭제--%>
            </colgroup>
            <thead>
            <tr class="bg-gray text-align-center">
                <td>번호</td>
                <td>파일명</td>
                <td>사진</td>
                <td>사진순서</td>
                <td>사진순서</td>
                <td>삭제</td>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty fileData}">
                <c:forEach items="${fileData}" var="items" varStatus="idx">
                    <input type="hidden" id="isClicked"/>
                    <tr class="clickTr" idx="${items.healthindex}">
                        <td>${items.sequencenum}</td><%--번호--%>
                        <td>${items.filename}</td><%--파일명--%>
                        <td><img src="/upload/healthinfo/healthfiles/${healthidx}/${items.filename}" width="100"></td><%--사진--%>
                        <td><a class="upOrder" index="${items.healthindex}" order="${items.pictureorder}" seq="${items.sequencenum}"><img src="/imgs/bt_up.png" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a></td><%--플레이순서(위로이동)--%>
                        <td><a class="downOrder" index="${items.healthindex}" order="${items.pictureorder}" seq="${items.sequencenum}"><img src="/imgs/bt_down.png" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a></td><%--플레이순서(위로이동)--%>
                        <td>
                            <a class="deleteFile" index="${items.healthindex}" order="${items.pictureorder}" seq="${items.sequencenum}" filename="${items.filename}"><img width="30" height="30" src="/imgs/bt_x.png" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a>

                        </td><%--플레이순서(위로이동)--%>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty fileData}">
                <tr>
                    <td colspan="10">데이터가 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>

    </div>
</div>
<script>
    $(function () {
        $('.upOrder').click(function () {
            var ordermax = '${ordermax}';
            var ordermin = '${ordermin}';

            var index = $(this).attr('index');
            var seq = $(this).attr('seq');
            var order = $(this).attr('order');

            if (eval(ordermin) == eval(index)) {
                alert('위로 이동할수없습니다.');
                return;
            }

            var req = {};
            req = $(this).closest('form').serialize();
            $als.execute('/health/upOrder/' + index + '/' + order + '/' + seq, req, function (data) {
                if (data.result_message == 'success') {
                    alert('순서가 변경되었습니다.');
                    location.href = '/health/list';
                }
            }, function (err) {
                alert(err.result_message);
            });
        });
        $('.downOrder').click(function () {
            var ordermax = '${ordermax}';
            var ordermin = '${ordermin}';

            var index = $(this).attr('index');
            var seq = $(this).attr('seq');
            var order = $(this).attr('order');


            if (eval(ordermax) <= eval(index)) {
                alert('아래로 이동할수없습니다.');
                return;
            }
            var req = {};
            req = $(this).closest('form').serialize();
            $als.execute('/health/downOrder/' + index + '/' + order + '/' + seq, req, function (data) {
                if (data.result_message == 'success') {
                    alert('순서가 변경되었습니다.');
                    location.href = '/health/list';
                }
            }, function (err) {
                alert(err.result_message);
            });
        });
        $('.deleteFile').click(function () {
            var ordermax = '${ordermax}';
            var ordermin = '${ordermin}';

            var index = $(this).attr('index');
            var seq = $(this).attr('seq');
            var order = $(this).attr('order');
            var filename = $(this).attr('filename');

            var req = {};
            req = $(this).closest('form').serialize();
            console.log('req');
            console.log(req);
            req = req + "&filename=" + filename;
            $als.execute('/health/deleteHealthFile/' + index + '/' + order + '/' + seq, req, function (data) {

                if (data.result_message == 'success') {
                    alert('삭제되었습니다.');

                } else {
                    console.log(data.result_message);

                }
                location.href = '/health/detail/' + index;
            }, function (err) {
                alert(err.result_message);
            });
        });
    });
</script>