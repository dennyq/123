/**
 * Usage : 숫자 3자리 단위로 콤마(,)찍기
 * 잘되야할텐데
 */
function formatNum(val) {
	var str = "" + val + "";
	
    if ((str != "")&&(str != "0")){
    	var reg = /(?=(\d{3})+$)\B/g;
    	str = str.replace(reg,',') ;
    }
	return str;
}

/**
 * Usage : document.oncontextmenu = disabledEvent;
 * window event를 막을때 사용
 */
function disabledEvent(event) {
//	event.returnValue = false;
    return false;
}
function disabledKey(event) {
	switch(event.keyCode) {
	// fucntion key
	case  112: case  113: case  114: case  115: case  116: case  117:
	case  118: case  119: case  120: case  121: case  122: case  123:
		event.keyCode = 0;
		event.returnValue = false;
		break;
	default:
		// control key
		if (event.ctrlKey)	event.returnValue = false;
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}

/**
 * Usage : onkeydown="return onlyNumber(event);" style="ime-mode:disabled"
 * input object에서 숫자만 입력받는다.
 * ime-mode : active -> 처음에 한글입력상태가 된다
 * ime-mode : inactive -> 처음에 영어입력상태가 된다
 * ime-mode : disabled -> 영어만 입력받는다(한글전환 안됨)
 */
function onlyNumber(event) {
	var keyCode = (event.which) ? event.which : event.keyCode;
	
    switch(keyCode) {
    case  8: case  9: case  13:         // backspace, tab, enter
    case 35: case 36:                   // end, home
    case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
    case 46:                            // delete
        event.returnValue = true;
        return true;
        break;
    default:
        // 0 ~ 9 || 키패드 0 ~ 9
        if (!event.shiftKey && ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105))) {
            event.returnValue = true;
            return true;
            
        } else {
            event.returnValue = false;
            return false;
        }
        break;
    }
	if(!window.event && event.returnValue == false){
		event.preventDefault();
		return false;
	}
}

function _onlyNumber(event) {
	switch(event.keyCode) {
    case  8: case  9: case  13:         // backspace, tab, enter
    case 35: case 36:                   // end, home
    case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
    case 46:                            // delete
        event.returnValue = true;
        break;
    default:
        // 0 ~ 9 || 키패드 0 ~ 9
        if (!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
        break;
    }
	if(event.returnValue == false){
		event.preventDefault();
	}
}

/**
 * Usage : onkeydown="onlySignNumber(event);" style="ime-mode:disabled"
 * input object에서 부호(+-)와 숫자만 입력받는다.
 */
function onlySignNumber(event) {
    var obj = event.srcElement;
	switch(event.keyCode) {
	case  8: case  9: case  13:         // backspace, tab, enter
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	case 187: // +
		if (event.shiftKey)	event.returnValue = true;
		else                event.returnValue = false;
	    break;
	case 189: // -
	case 107: // 키패드 +
	case 109: // 키패드 -
		if (event.shiftKey)	event.returnValue = false;
		else                event.returnValue = true;
	    break;
	default:
	    // 0 ~ 9 || 키패드 0 ~ 9
        if (!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) {
            event.returnValue = true;
        } else {
		    event.returnValue = false;
		}
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="return onlyDecimalNumber(event);" style="ime-mode:disabled"
 * input object에서 소수점(.)과 숫자만 입력받는다.
 */
function onlyDecimalNumber(event) {
	var keyCode = (event.which) ? event.which : event.keyCode;
    var obj = event.target ? event.target : event.srcElement;

	switch(keyCode) {
	case  8: case  9: case  13:         // backspace, tab, enter
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	case 190: // .
	case 110: // 키패드 .
		if (event.shiftKey)	event.returnValue = false;
		else	{
		    if (obj.value.indexOf(".") == -1) event.returnValue = true;
    	    else                              event.returnValue = false;
	    }
	    break;
	default:
	    // 0 ~ 9 || 키패드 0 ~ 9
        if (!event.shiftKey && ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105))) {
            event.returnValue = true;
        } else {
		    event.returnValue = false;
		}
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
	if(event.returnValue == false) return false;
	else return true;
}
/**
 * Usage : onkeydown="onlySignDecimalNumber(event);" style="ime-mode:disabled"
 * input object에서 부호(+-)와 소수점(.)과 숫자만 입력받는다.
 */
function onlySignDecimalNumber(event) {
	var obj = event.target ? event.target : event.srcElement;
	switch(event.keyCode) {
	case  8: case  9: case  13:         // backspace, tab, enter
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	case 190: // .
	case 110: // 키패드 .
		if (event.shiftKey)	event.returnValue = false;
		else	{
		    if (obj.value.indexOf(".") == -1) event.returnValue = true;
    	    else                              event.returnValue = false;
	    }
	    break;
	case 187: // +
		if (event.shiftKey)	event.returnValue = true;
		else                event.returnValue = false;
	    break;
	case 189: // -
	case 107: // 키패드 +
	case 109: // 키패드 -
		if (event.shiftKey)	event.returnValue = false;
		else                event.returnValue = true;
	    break;
	default:
	    // 0 ~ 9 || 키패드 0 ~ 9
        if (!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) {
            event.returnValue = true;
        } else {
		    event.returnValue = false;
		}
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyAlphabet(event);" style="ime-mode:disabled"
 * input object에서 알파벳만 입력받는다.
 */
function onlyAlphabet(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
	    // 알파벳
        if ((event.keyCode >= 65) && (event.keyCode <= 90))
            event.returnValue = true;
        else
		    event.returnValue = false;
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyHangul(event);" style="ime-mode:active"
 * input object에서 한글만 입력받는다.
 */
function onlyHangul(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
	    // 한글
        if ((event.keyCode >= 12592) && (event.keyCode <= 12687))
            event.returnValue = true;
        else
		    event.returnValue = false;
		break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyAlphabetNumber(event);" style="ime-mode:disabled"
 * input object에서 숫자와 알파벳만 입력받는다.
 */
function onlyAlphabetNumber(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
        // 0 ~ 9 || 키패드 0 ~ 9 || 알파벳
        if ((!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)))
        || ((event.keyCode >= 65) && (event.keyCode <= 90)) ) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
        break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyNumberHangul(event);"
 * input object에서 숫자와 한글만 입력받는다.
 */
function onlyNumberHangul(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
        // 0 ~ 9 || 키패드 0 ~ 9 || 한글
        if ((!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)))
        || ((event.keyCode >= 12592) && (event.keyCode <= 12687)) ) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
        break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyAlphabetHangul(event);"
 * input object에서 알파벳과 한글만 입력받는다.
 */
function onlyAlphabetHangul(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
        // 알파벳 || 한글
        if (((event.keyCode >= 65) && (event.keyCode <= 90))
        || ((event.keyCode >= 12592) && (event.keyCode <= 12687)) ) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
        break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}
/**
 * Usage : onkeydown="onlyNumberAlphabetHangul(event);"
 * input object에서 숫자와 알파벳과 한글만 입력받는다.
 */
function onlyNumberAlphabetHangul(event) {
	switch(event.keyCode) {
	case  8: case  9: case  13: case 32: // backspace, tab, enter, space
	case 35: case 36:                   // end, home
	case 37: case 38: case 39: case 40: // ←, ↑, →, ↓
	case 46:                            // delete
        event.returnValue = true;
        break;
	default:
        // 0 ~ 9 || 키패드 0 ~ 9 || 알파벳 || 한글
        if ((!event.shiftKey && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)))
        || ((event.keyCode >= 65) && (event.keyCode <= 90))
        || ((event.keyCode >= 12592) && (event.keyCode <= 12687)) ) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
        break;
	}
	if(!window.event && event.returnValue == false){
		event.preventDefault();
	}
}

/**
 * Usage : onkeyup="toComma(event);" onkeydown="onlyNumber(event);" style="ime-mode:disabled"
 * input object의 값을 3자리 마다 콤마를 찍는다.
 */
function toComma(event) {
	var obj = event.target ? event.target : event.srcElement;
	var str = obj.value.replace(/[,]/g, '');
    var arr = str.split('.');
    if (arr.length <= 2) {
        if (!isNaN(arr[0])) {
            var pattern = /([+-]?\d+)(\d{3})/;   // 정규식
            while (pattern.test(arr[0])) {
                arr[0] = arr[0].replace(pattern, '$1,$2');
            }
        }
        obj.value = arr.join('.');
    }
}
/******************************************************************************
 * fnNextFocusByLength(thisobj, nextobj)
 * input object의 값이 maxlength의 값과 같으면 다음 object로 포커스를 이동시킨다.
 * Usage : onKeyup="javascript:fnNextFocusByLength(event, this, nextobj);"
 */
function fnNextFocusByLength(event, thisobj, nextobj) {
	if ( thisobj.getAttribute("Maxlength") == thisobj.value.length) {
		nextobj.focus();
	}
}
/******************************************************************************
 * fnNextFocusByEnter(nextobj)
 * input object에서 enter를 쳤을경우 다음 object로 포커스를 이동시킨다.
 * Usage : onKeyup="javascript:fnNextFocusByEnter(event,nextobj);"
 */
function fnNextFocusByEnter(event, nextobj) {
	if(event.keyCode == 13) {
		nextobj.focus();
	}
}
/******************************************************************************
 * fnCallFunctionByEnter(function_name)
 * input object에서 enter를 쳤을경우 다음 함수를 호출한다.
 * Usage : onKeyup="javascript:fnCallFunctionByEnter(event,function_name);"
 */
function fnCallFunctionByEnter(event, function_name, arg) {
	if(event.keyCode == 13) {
		if (typeof function_name == "function") {
			if (arg) {
				function_name(arg);
			} else {
				function_name();
			}
		}
	} else return;
}

/******************************************************************************
 * fnCheckSpecialChar(this)
 * input object 에서 특수문자를 제한한다.
 * Usage : onkeyup="fnCheckSpecialChar(this.id, this.value)"
 */
function fnCheckSpecialChar(obj){
	var str = obj.value;
	re = /[~!@\#$%^&*\()\=+_']/gi;
	if(re.test(str)){
		alert("특수문자는 입력하실 수 없습니다.");
		$(obj.id).value = "";
		return;
	}
}