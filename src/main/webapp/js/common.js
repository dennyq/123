var $als = {};

$als.SERVICE_URL = "/";
$als.isDev = true;

$als.makeUrl = function(url, args) { 
	var queryString = jQuery.param(args);
	return url + "?" + queryString;
};

$als.execute = function(jobId, data, success_callback, error_callback) {
	$.ajax({
	    url: jobId,
	    type: "POST",
	    cache: false,
	    timeout: 3000000,
	    dataType: "json",
	    data: data,
	    success: function(data) { 
	    		var jsonData;
	    		if(typeof data == 'object') {
	    			jsonData = data;
	    		}
	    		else {
	    			jsonData = $.parseJSON(data);
	    		}
	        if(jsonData.result_code != '0000') {
	        		// alert(jsonData.result_message);
	        		if(error_callback != null && error_callback != 'undefined') {
		    			error_callback(data);
		    		}
		    		else {
		    			alert("server error:" + data.result_message);
		    		}
	        		return;
	        }
	        
	        success_callback(jsonData);
	    },
	    error: function(error){
	    		if(error_callback != null && error_callback != 'undefined') {

						if(error.responseText!=undefined){
							error = eval('(' + error.responseText + ')');;
						}
	    			error_callback(error);
	    		}
	    		else {
						var error = {result_code:'9999', result_message:error.status + 'error'};

						error_callback(data);
						//console.log("error=" + error.status);
	    		}
	    },
	    complete: function() {

	    }
	});
};


function frm_submit(obj){
	var form = $(obj).closest('form');
    var req = {};	
    var data = form.serialize();
    req.data=  JSON.stringify(data);
   /* var data = form.serializeObject();
    req.data =  JSON.stringify(data);*/
    
//    console.log(form);
//    console.log(data);
    validateForm(form);
    form.submit();
};
function validateForm(obj){
//	 console.log('validateForm');
//	 console.log(obj);

};


Array.prototype.insert = function (index, item) {
	  this.splice(index, 0, item);
};


//다운로드 파일.
function downFile(url,req){
	//console.log(url);
	//console.log(req);
	if(confirm("다운로드 하시겠습니까?")){
		window.location=$als.makeUrl(url,req);
	}
}
$.fn.clickToggle = function(func1, func2) {
	var funcs = [func1, func2];
	this.data('toggleclicked', 0);
	this.click(function() {
		var data = $(this).data();
		var tc = data.toggleclicked;
		$.proxy(funcs[tc], this)();
		data.toggleclicked = (tc + 1) % 2;
	});
	return this;
};



$.fn.serializeObject = function()
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
// First, checks if it isn't implemented yet.
//if (!String.prototype.format) {
//    String.prototype.format = function() {
//        var args = arguments;
//        return this.replace(/{(\d+)}/g, function(match, number) {
//            return typeof args[number] != 'undefined'
//                ? args[number]
//                : match
//                ;
//        });
//    };
//}


Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
function isNumber(s) {
    s += ''; // 문자열로 변환
    s = s.replace(/^\s*|\s*$/g, ''); // 좌우 공백 제거
    if (s == '' || isNaN(s)) return false;
    return true;
}

function dtformatter(date){
  var y = date.getFullYear();
  var m = date.getMonth()+1;
  var d = date.getDate();
  return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

function dtparser(s){
  if (!s) return new Date();
  var ss = (s.split('-'));
  var y = parseInt(ss[0],10);
  var m = parseInt(ss[1],10);
  var d = parseInt(ss[2],10);
  if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
    return new Date(y,m-1,d);
  } else {
    return new Date();
  }
}

//이메일형식체크 string email, element ele
function valid_email(email,ele) {
	re=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(email.length<6 || !re.test(email)) {
		alert("메일형식이 맞지 않습니다.\n 다시 입력해주세요.");
		ele.select();
		ele.focus();
		return false;
	} else {
		return true;
	}
}
//레이어 화면 중앙 띄우기
jQuery.fn.center = function () {
	this.css("position","absolute");
	this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	return this;
}

//스피너 설정
var prog = function() {
	var opts = {
		lines: 11, 				// The number of lines to draw
		length: 15, 			// The length of each line
		width: 7, 				// The line thickness
		radius: 20, 			// The radius of the inner circle
		corners: 1, 			// Corner roundness (0..1)
		rotate: 0, 				// The rotation offset
		color: '#5AAEFF', 			// #rgb or #rrggbb
		speed: 1.4, 			// Rounds per second
		trail: 100, 			// Afterglow percentage
		shadow: false, 			// Whether to render a shadow
		hwaccel: false, 			// Whether to use hardware acceleration
		className: 'spinner', 	// The CSS class to assign to the spinner
		zIndex: 2e9, 			// The z-index (defaults to 2000000000)
		top: 'auto', 			// Top position relative to parent in px
		left: 'auto' 			// Left position relative to parent in px
	};

	var target = document.getElementById('progressIndicator');
	if(target == null){
		target = $('body').append('<div id="progressIndicator" style="display: none">').find('#progressIndicator')[0];
	}
	var spinner = new Spinner(opts);

	return {
		startSpinner: function() {
			$(target).fadeIn('fast');
			spinner.spin(target);
		},
		stopSpinner:function () {
			$(target).fadeOut('fast');
			spinner.stop();

		},
		getSpinnerTarget:function () {
			return target;
		}
	};
};
// popup
function popupHandler(){
	$(".popup_close , .close").click(function(e){
		e.preventDefault();
		$(".modal-dialog , .bg_popup").fadeOut();
	});
	$(".pop_open").click(function(e){
		var idx = $(this).attr("rel");
		var _w = $("#"+idx).width();
		var _h = $("#"+idx).height();
		e.preventDefault();
		$("#"+idx).fadeIn();
		$(".modal-dialog ").css({"margin-left":-_w/2 , "margin-top":-_h/2});
		$(".bg_popup").fadeIn();
	});
}


function popupTxt(infoTxt) {

  //var idx = $(this).attr("rel");
  var _w = $("#main_popup").width();
  var _h = $("#main_popup").height();
  $('#main_popup .infoTxt').html(infoTxt);
  //e.preventDefault();
  $("#main_popup").fadeIn();
  $(".layer_popup").css({"margin-left": -_w / 2, "margin-top": -_h / 2});
  $(".bg_popup").fadeIn();
}

function popupTxtNoBg(layerName) {

	//var idx = $(this).attr("rel");
	var _w = $("#"+layerName).width();
	var _h = $("#"+layerName).height();
	//$('#'+layerName+' .infoTxt').html(infoTxt);
	var docHeight =window.innerHeight;
	//console.log(docHeight);
	//e.preventDefault();
	$("#"+layerName).fadeIn();
	$(".layer_popup").css({"margin-left": -_w / 2, "margin-top": (-_h / 2) - (docHeight/2)+170});
	//$(".bg_popup").fadeIn();
}



function preventDefault(e) {
	e = e || window.event;
	if (e.preventDefault)
		e.preventDefault();
	e.returnValue = false;
}
//
function keydown(keys,e) {
	for (var i = keys.length; i--;) {
		if (e.keyCode === keys[i]) {
			preventDefault(e);
			return;
		}
	}
}

function wheel(e) {
	preventDefault(e);
}


//스크롤막음
function disable_scroll() {
	if (window.addEventListener) {
		window.addEventListener('DOMMouseScroll', wheel, false);
	}
	window.onmousewheel = document.onmousewheel = wheel;
	document.onkeydown = keydown;
}

function enable_scroll() {
	if (window.removeEventListener) {
		window.removeEventListener('DOMMouseScroll', wheel, false);
	}
	window.onmousewheel = document.onmousewheel = document.onkeydown = null;
}




function saveid(email_el_id,checkbox_id) {
	var expdate = new Date();

	//console.log($('#'+checkbox_id).val());
	if ($('#'+checkbox_id+':checked').val() == 'Y') {
		expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일.
	}else {
		expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건.
	}
	setCookie("saveid", $('#'+email_el_id).val(), expdate);


}

function saveCookie(value,saveId) {
	var expdate = new Date();
	expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일.
	setCookie(saveId, value, expdate);
}

function setCookie (name, value, expires) {
	document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getid(email_el_id,checkbox_id) {
	$('#'+email_el_id).val(getCookie("saveid"));
	var isChecked = ($('#'+email_el_id).val() != "" ? true : false);

	$('#'+checkbox_id).prop('checked',isChecked);
}

function getCookie1(Name) {
	var search = Name + "=";
	if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면.
		offset = document.cookie.indexOf(search);
		if (offset != -1) { // 쿠키가 존재하면.
			offset += search.length;
			// set index of beginning of value.
			end = document.cookie.indexOf(";", offset);
			// 쿠키 값의 마지막 위치 인덱스 번호 설정.
			if (end == -1)
				end = document.cookie.length;
			return unescape(document.cookie.substring(offset, end));
		}
	}
	return "";
}
function getCookie( name ) {
	var nameOfCookie = name + '=';
	var x = 0;
	while (x <= document.cookie.length) {
		var y = (x + nameOfCookie.length);
		if (document.cookie.substring(x, y) == nameOfCookie) {
			if ((endOfCookie = document.cookie.indexOf(';', y)) == -1)
				endOfCookie = document.cookie.length;
			return unescape(document.cookie.substring(y, endOfCookie));
		}
		x = document.cookie.indexOf(' ', x) + 1;
		if (x == 0)
			break;
	}
	return '';
}
	function doScroll() {
	var currentPosition = parseInt($("#right_section").css("top"));
	$(window).scroll(function () {
		var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
		$("#right_section").stop().animate({"top": position + currentPosition - 0 + "px"}, 500);
	});
}

function isValidDate(dateStr) {
	if(!dateStr.match(/^\d+/)){
		alert('유효한 날짜를 적어주세요');
		return false;
	}

	if(dateStr.length != 8){
		alert("8자리로 날짜를 적어주세요.");
		return false;
	}

	var year = Number(dateStr.substr(0,4));


	if(dateStr.substr(0,4).length != 4){
		alert("연도는 4자리로적어주세요.");
		return false;
	}

	var month = Number(dateStr.substr(4,2));

	if(dateStr.substr(4,2).length != 2){
		alert("월은 2자리로적어주세요.");
		return false;
	}

	var day = Number(dateStr.substr(6,2));


	if(dateStr.substr(6,2).length!=2){
		alert("일은 2자리로 적어주세요");
		return false;
	}

	if (month < 1 || month > 12) { // check month range
		//alert("Month must be between 1 and 12.       ");
		alert("유효한 날짜를 적어주세요");
		return false;
	}

	if (day < 1 || day > 31) {
		//alert("Day must be between 1 and 31.       ");
		alert("유효한 날짜를 적어주세요");
		return false;
	}

	if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		//alert("Month "+month+" doesn't have 31 days!       ");
		alert("유효한 날짜를 적어주세요");
		return false
	}

	if (month == 2) { // check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap)) {
			//alert("February " + year + " doesn't have " + day + " days!       ");
			alert("유효한 날짜를 적어주세요");
			return false;
		}
	}

	return true;
}


function chk_tel(str, field) {

	var str;
	str = checkDigit(str, field);
	var len = str.length;
	if (len == 0) {
		return false;
	}
	if (len == 8) {
		if (str.substring(0, 2) == 02) {
			error_numbr(str, field);
		} else {
			field.value = phone_format(1, str);
		}
	} else if (len == 9) {
		if (str.substring(0, 2) == 02) {
			field.value = phone_format(2, str);
		} else {
			error_numbr(str, field);
		}
	} else if (len == 10) {
		if (str.substring(0, 2) == 02) {
			field.value = phone_format(2, str);
		} else {
			field.value = phone_format(3, str);
		}
	} else if (len == 11) {
		if (str.substring(0, 2) == 02) {

			error_numbr(str, field);
		} else {
			var mylist = ['010', '011', '016', '017', '018', '019', '031', '032', '033', '041', '042', '043', '051', '052', '053', '054', '055', '061', '062', '063', '064', '070'];
			var result = $.inArray(str.substring(0, 3), mylist);

			field.value = phone_format(3, str);
			if (result == -1) {
				error_numbr(str, field);
			}
		}
	} else {
		error_numbr(str, field);
	}
}
function checkDigit(num, field) {
	var Digit = "1234567890";
	var string = num;
	var len = string.length
	var retVal = "";
	var errChk = false;
	var phoneChar = "0123456789-)";
	if (Digit.indexOf(string.substring(0, 1)) == '-1') {
		string = string.substring(1, len);
		len = string.length
	}
	for (var i = 0; i < len; i++) {

		var temp;
		temp = string.substring(i, i + 1);
		if (phoneChar.indexOf(temp) == '-1') {
			errChk = true;
		}
		if (Digit.indexOf(string.substring(i, i + 1)) >= 0) {
			retVal = retVal + string.substring(i, i + 1);

		}
	}

	if (retVal == '' && string.length != 0) errChk = true;
	if (errChk == true) error_numbr('', field);


	return retVal;
}
function phone_format(type, num) {
	if (type == 1) {
		return num.replace(/([0-9]{4})([0-9]{4})/, "$1-$2");
	} else if (type == 2) {
		return num.replace(/([0-9]{2})([0-9]+)([0-9]{4})/, "$1-$2-$3");
	} else {
		return num.replace(/(^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
	}
}
function error_numbr(str, field) {
	alert("잘못된 번호입니다..");
	field.value = "";
	field.focus();
	return;
}

// 디버그모드
var DEBUG_MODE;
try{
	if (DEBUG_MODE == null) {
		DEBUG_MODE = true;	// true, false
	}
}
catch(e){
	DEBUG_MODE = false;
}

function newOpenPost(p_form, p_url, p_pos, p_resz, p_name, p_w, p_h, p_t, p_l, p_s, max_flag) {
	// p_url        : URL
	// p_pos        : c - CenterScreen
	// p_resz       : resizable
	// p_name       : target
	// p_w          : width
	// p_h          : height
	// p_t          : top
	// p_l          : left
	// p_s          : scrollbars

	var pxWidth = "1015";
	var pxHeight = "690";
	//var pxWidth = "800";
	//var pxHeight = "600";

	if(max_flag == "yes"){
		p_w = screen.availWidth + "";
		p_h = screen.availHeight + "";
	}

	if (p_pos == undefined || p_pos =='') p_pos = "l" ;
	if (p_w == undefined || p_w == 0 || p_w == '') p_w = pxWidth ;
	if (p_h == undefined || p_h == 0 || p_h == '') p_h = pxHeight ;
	if (p_t == undefined || p_t == '') p_t = 0;
	if (p_l == undefined || p_l == '') p_l = 0;
	if (p_name == undefined) p_name = '';
	if (p_resz == undefined) p_resz = '0';
	if (p_s == undefined) p_s = 'no';

	if (p_pos == 'c'){
		p_t = (window.screen.availHeight - p_h)/2;
		p_l = (window.screen.availWidth - p_w)/2;
	}

	var sProp = '';
	if (DEBUG_MODE) {
		sProp = 'left=' + p_l + ',top=' + p_t + ',width='  + p_w + ',height=' + p_h + ',resizable='+ p_resz +',scrollbars='+p_s+',menubars=no,status=yes';
	}
	else {
		sProp = 'left=' + p_l + ',top=' + p_t + ',width='  + p_w + ',height=' + p_h + ',resizable='+ p_resz +',scrollbars='+p_s+',menubars=no,status=no';
	}
	popupWindow = window.open( '', p_name, sProp );

	var old_target = p_form.target;
	var old_action = p_form.action;

	p_form.target = p_name;
	p_form.action = p_url;
	p_form.submit();

	p_form.target = old_target;
	p_form.action = old_action;

	//popupWindow.focus();

	return popupWindow;
}

function autoHypenPhone(str){
	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	if( str.length < 4){
		return str;
	}else if(str.length < 7){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	}else if(str.length < 11){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
	}else{
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}
	return str;
}

function setClickedMenuBold(idx) {
	$('#bs-example-navbar-collapse-1 > ul > li:nth-child('+idx+')').find('a').addClass('bolder');
}

function getAjax(rootUrl,url,alert_msg){
	var req = $('#detailFrm').serialize();

	var p = new prog();
	p.startSpinner();
	$als.execute(url, req, function (data) {
		p.stopSpinner();
		var url = "";
		if (data.result_message == 'success') {
			alert(alert_msg);
			url = rootUrl + 'list';
			location.href = url;
		} else {
			alert(data.result_message);
			url = rootUrl + 'list';
			location.href = url;
		}

	}, function (err) {
		p.stopSpinner();
		alert(err.result_message);
	});
}


function getAjax(rootUrl,url,alert_msg,Frm){
	var req = $('#'+Frm).serialize();

	var p = new prog();
	p.startSpinner();
	$als.execute(url, req, function (data) {
		p.stopSpinner();
		var url = "";
		if (data.result_message == 'success') {
			alert(alert_msg);
			url = rootUrl + 'list';
			location.href = url;
		} else {
			alert(data.result_message);
			url = rootUrl + 'list';
			location.href = url;
		}

	}, function (err) {
		p.stopSpinner();
		alert(err.result_message);
	});
}

function imgHover(){
	$('.box-footer.text-align-center.box-bg-foot > a img,.imgHover > img,.imgHover > a > img').hover(function(){
		var src = $(this).attr('src');
		src= src.replace('_off','_on');
		$(this).attr('src',src);
	},function(){
		var src = $(this).attr('src');
		src= src.replace('_on','_off');
		$(this).attr('src',src);
	});
};

//var monitorSetTimeOut = null;

function startLoading(){
	$('.overlay').removeClass('active').addClass('active');
}
function endLoading(){
	//setTimeout(function(){$('.overlay').removeClass('active');},5000);
	$('.overlay').removeClass('active');
}
function chageImgSrc(thisObj){
	console.log($(thisObj).find('img').attr('src'));
}

function swapOverImg(thisObj,addStr){
	var src =$(thisObj).attr('src').split('.')[0];
	var ext =$(thisObj).attr('src').split('.')[1];
    $(thisObj).attr('src', src + addStr +'.'+ ext);
}
function swapOutImg(thisObj,addStr){
    var src =$(thisObj).attr('src').split('.')[0];

    src = src.substring(0,src.indexOf(addStr));
    var ext =$(thisObj).attr('src').split('.')[1];
    $(thisObj).attr('src', src  +'.'+ ext);
}


function popupOpen(popUrl, width, height) {
	var popUrl = popUrl;//"popup.jsp";	//팝업창에 출력될 페이지 URL
	var popOption = "width="+width+", height="+height+", resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	window.open(popUrl,"",popOption);
}