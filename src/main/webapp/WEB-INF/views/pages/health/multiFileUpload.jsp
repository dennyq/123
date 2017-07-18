<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>

<link rel="stylesheet" href="/css/jquery.fileupload.css"/>
<table class="table table-hover pointer">
    <colgroup>
        <col width="1%"/><%--번호--%>
        <col width="7%"/><%--파일명--%>
        <col width="*"/><%--사진--%>
        <col width="10%"/><%--사진순서(위로이동)--%>
        <col width="10%"/><%--사진순서(아래로이동)--%>
        <col width="8%"/><%--삭제--%>
    </colgroup>
    <thead>
    <tr class="bg-gray text-align-center">
        <td>번호</td>
        <td>파일명</td>
        <td>사진</td>
        <td>사진순서<br/>(위로이동)</td>
        <td>사진순서<br/>(아래로이동)</td>
        <td>삭제</td>
    </tr>
    </thead>
    <tbody id="files" class="files" style=" overflow: auto;">


    </tbody>
</table>




<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<%--<script type="text/javascript" src="/js/vendor/jquery.ui.widget.js"></script>--%>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script type="text/javascript" src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script type="text/javascript" src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
<%--<script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>--%>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script type="text/javascript" src="/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script type="text/javascript" src="/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script type="text/javascript" src="/js/jquery.fileupload-image.js"></script>

<!-- The File Upload validation plugin -->
<script type="text/javascript" src="/js/jquery.fileupload-validate.js"></script>
<script type="text/javascript">
    /*jslint unparam: true, regexp: true */
    /*global window, $ */

    $(function () {
        'use strict';
        // Change this to the location of your server-side upload handler:
        var url = '/',
                deleteButton = $('<a/>')
                        .addClass('btn btn-danger delete-btn')
                        .prop('disabled', true)
                        .text('Processing...')
                        .on('click', function () {
                            var $this = $(this),
                                    data = $this.data();
                            $this.parent().parent().remove();
                            //todo: list 삭제


                        })
                ,upButton= $('<a/>')
                        .addClass('btn btn-primary up-btn')
                        .prop('disabled', true)
                        .text('Processing...')
                        .on('click', function () {
                            var $this = $(this),
                                    data = $this.data();
                            var rowData =  $this.parent().parent();
                            var index = rowData.find('[name=pictureorder]');
                            console.log('index : '+index.val());

                            var $tr = rowData; // 클릭한 버튼이 속한 tr 요소
                            $tr.prev().find('[name=pictureorder]').val(index.val());
                            $tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
                            $tr.find('[name=pictureorder]').val(eval(index.val()-1));
//                            rowData.clone();
                        })
                ,downButton= $('<a/>')
                        .addClass('btn btn-primary down-btn')
                        .prop('disabled', true)
                        .text('Processing...')
                        .on('click', function () {
                            var $this = $(this),
                                    data = $this.data();
                            var rowData =  $this.parent().parent();
//                            $this
//                                    .off('click')
//                                    .text('Abort')
//                                    .on('click', function () {
////                                        $this.remove();
////                                        data.abort();
//                                    });
                            var $tr = rowData; // 클릭한 버튼이 속한 tr 요소
                            $tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
//                            data.submit().always(function () {
//                                $this.remove();
//                            });
                        });
        var fileIndex= 0,prevIndex=0;
        $('#fileupload').fileupload({//test
            url: url,
            dataType: 'json',
            autoUpload: false,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
            maxFileSize: 999000,
            // Enable image resizing, except for Android and Opera,
            // which actually support image resizing, but fail to
            // send Blob objects via XHR requests:
            disableImageResize: /Android(?!.*Chrome)|Opera/
                    .test(window.navigator.userAgent),
            previewMaxWidth: 100,
            previewMaxHeight: 100,
            previewCrop: true
        }).on('fileuploadadd', function (e, data) {

            //todo: make table
            console.log(data);
            data.context = $('#files');
            $.each(data.files, function (index, file) {
                var node = $('<tr/>');
                fileIndex++;
                if (!index) {
                    node .append($('<td/>').html('<input id="pictureorder'+fileIndex+'" name="pictureorder" value="'+fileIndex+'"/>'+fileIndex))/*번호*/
                            .append($('<td/>').html(file.name))   /*파일명*/
                            .append($('<td/>').html('<span class="preview"></span>'))   /*사진*/
                            .append($('<td/>').html(upButton.clone(true).data(data)))/*위로버튼*/
                            .append($('<td/>').html(downButton.clone(true).data(data)))/*아래버튼*/
                            .append($('<td/>').html(deleteButton.clone(true).data(data)));/*삭제버튼*/

                }
                node.appendTo(data.context);
            });
        }).on('fileuploadprocessalways', function (e, data) {
            var index = data.index,
                    file = data.files[index],
                    node = $(data.context.find('tr').eq(prevIndex));
            if (file.preview) {
                node.find('.preview').prepend(file.preview);
                prevIndex++;
            }
            if (file.error) {
                node
                        .append('<br>')
                        .append($('<span class="text-danger"/>').text(file.error));
            }
            if (index + 1 === data.files.length) {
                data.context.find('a.up-btn')
                        .html('<i class="fa fa-fw fa-arrow-up"></i>')
                        .prop('disabled', !!data.files.error);
                data.context.find('a.down-btn')
                        .html('<i class="fa fa-fw fa-arrow-down"></i>')
                        .prop('disabled', !!data.files.error);
                data.context.find('a.delete-btn')
                        .html('삭제')
                        .prop('disabled', !!data.files.error);
            }
        }).on('fileuploadprogressall', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                    'width',
                    progress + '%'
            );
        }).on('fileuploaddone', function (e, data) {
            $.each(data.result.files, function (index, file) {
                if (file.url) {
                    var link = $('<a>')
                            .attr('target', '_blank')
                            .prop('href', file.url);
                    $(data.context.children()[index])
                            .wrap(link);
                } else if (file.error) {
                    var error = $('<span class="text-danger"/>').text(file.error);
                    $(data.context.children()[index])
                            .append('<br>')
                            .append(error);
                }
            });
        }).on('fileuploadfail', function (e, data) {
            $.each(data.files, function (index) {
                var error = $('<span class="text-danger"/>').text('File upload failed.');
                $(data.context.children()[index])
                        .append('<br>')
                        .append(error);
            });
        }).prop('disabled', !$.support.fileInput)
                .parent().addClass($.support.fileInput ? undefined : 'disabled');


    });
</script>
