//! moment.js
//! version : 2.10.6
//! authors : Tim Wood, Iskren Chernev, Moment.js contributors
//! license : MIT
//! momentjs.com
!function(a,b){"object"==typeof exports&&"undefined"!=typeof module?module.exports=b():"function"==typeof define&&define.amd?define(b):a.moment=b()}(this,function(){"use strict";function a(){return Hc.apply(null,arguments)}function b(a){Hc=a}function c(a){return"[object Array]"===Object.prototype.toString.call(a)}function d(a){return a instanceof Date||"[object Date]"===Object.prototype.toString.call(a)}function e(a,b){var c,d=[];for(c=0;c<a.length;++c)d.push(b(a[c],c));return d}function f(a,b){return Object.prototype.hasOwnProperty.call(a,b)}function g(a,b){for(var c in b)f(b,c)&&(a[c]=b[c]);return f(b,"toString")&&(a.toString=b.toString),f(b,"valueOf")&&(a.valueOf=b.valueOf),a}function h(a,b,c,d){return Ca(a,b,c,d,!0).utc()}function i(){return{empty:!1,unusedTokens:[],unusedInput:[],overflow:-2,charsLeftOver:0,nullInput:!1,invalidMonth:null,invalidFormat:!1,userInvalidated:!1,iso:!1}}function j(a){return null==a._pf&&(a._pf=i()),a._pf}function k(a){if(null==a._isValid){var b=j(a);a._isValid=!(isNaN(a._d.getTime())||!(b.overflow<0)||b.empty||b.invalidMonth||b.invalidWeekday||b.nullInput||b.invalidFormat||b.userInvalidated),a._strict&&(a._isValid=a._isValid&&0===b.charsLeftOver&&0===b.unusedTokens.length&&void 0===b.bigHour)}return a._isValid}function l(a){var b=h(NaN);return null!=a?g(j(b),a):j(b).userInvalidated=!0,b}function m(a,b){var c,d,e;if("undefined"!=typeof b._isAMomentObject&&(a._isAMomentObject=b._isAMomentObject),"undefined"!=typeof b._i&&(a._i=b._i),"undefined"!=typeof b._f&&(a._f=b._f),"undefined"!=typeof b._l&&(a._l=b._l),"undefined"!=typeof b._strict&&(a._strict=b._strict),"undefined"!=typeof b._tzm&&(a._tzm=b._tzm),"undefined"!=typeof b._isUTC&&(a._isUTC=b._isUTC),"undefined"!=typeof b._offset&&(a._offset=b._offset),"undefined"!=typeof b._pf&&(a._pf=j(b)),"undefined"!=typeof b._locale&&(a._locale=b._locale),Jc.length>0)for(c in Jc)d=Jc[c],e=b[d],"undefined"!=typeof e&&(a[d]=e);return a}function n(b){m(this,b),this._d=new Date(null!=b._d?b._d.getTime():NaN),Kc===!1&&(Kc=!0,a.updateOffset(this),Kc=!1)}function o(a){return a instanceof n||null!=a&&null!=a._isAMomentObject}function p(a){return 0>a?Math.ceil(a):Math.floor(a)}function q(a){var b=+a,c=0;return 0!==b&&isFinite(b)&&(c=p(b)),c}function r(a,b,c){var d,e=Math.min(a.length,b.length),f=Math.abs(a.length-b.length),g=0;for(d=0;e>d;d++)(c&&a[d]!==b[d]||!c&&q(a[d])!==q(b[d]))&&g++;return g+f}function s(){}function t(a){return a?a.toLowerCase().replace("_","-"):a}function u(a){for(var b,c,d,e,f=0;f<a.length;){for(e=t(a[f]).split("-"),b=e.length,c=t(a[f+1]),c=c?c.split("-"):null;b>0;){if(d=v(e.slice(0,b).join("-")))return d;if(c&&c.length>=b&&r(e,c,!0)>=b-1)break;b--}f++}return null}function v(a){var b=null;if(!Lc[a]&&"undefined"!=typeof module&&module&&module.exports)try{b=Ic._abbr,require("./locale/"+a),w(b)}catch(c){}return Lc[a]}function w(a,b){var c;return a&&(c="undefined"==typeof b?y(a):x(a,b),c&&(Ic=c)),Ic._abbr}function x(a,b){return null!==b?(b.abbr=a,Lc[a]=Lc[a]||new s,Lc[a].set(b),w(a),Lc[a]):(delete Lc[a],null)}function y(a){var b;if(a&&a._locale&&a._locale._abbr&&(a=a._locale._abbr),!a)return Ic;if(!c(a)){if(b=v(a))return b;a=[a]}return u(a)}function z(a,b){var c=a.toLowerCase();Mc[c]=Mc[c+"s"]=Mc[b]=a}function A(a){return"string"==typeof a?Mc[a]||Mc[a.toLowerCase()]:void 0}function B(a){var b,c,d={};for(c in a)f(a,c)&&(b=A(c),b&&(d[b]=a[c]));return d}function C(b,c){return function(d){return null!=d?(E(this,b,d),a.updateOffset(this,c),this):D(this,b)}}function D(a,b){return a._d["get"+(a._isUTC?"UTC":"")+b]()}function E(a,b,c){return a._d["set"+(a._isUTC?"UTC":"")+b](c)}function F(a,b){var c;if("object"==typeof a)for(c in a)this.set(c,a[c]);else if(a=A(a),"function"==typeof this[a])return this[a](b);return this}function G(a,b,c){var d=""+Math.abs(a),e=b-d.length,f=a>=0;return(f?c?"+":"":"-")+Math.pow(10,Math.max(0,e)).toString().substr(1)+d}function H(a,b,c,d){var e=d;"string"==typeof d&&(e=function(){return this[d]()}),a&&(Qc[a]=e),b&&(Qc[b[0]]=function(){return G(e.apply(this,arguments),b[1],b[2])}),c&&(Qc[c]=function(){return this.localeData().ordinal(e.apply(this,arguments),a)})}function I(a){return a.match(/\[[\s\S]/)?a.replace(/^\[|\]$/g,""):a.replace(/\\/g,"")}function J(a){var b,c,d=a.match(Nc);for(b=0,c=d.length;c>b;b++)Qc[d[b]]?d[b]=Qc[d[b]]:d[b]=I(d[b]);return function(e){var f="";for(b=0;c>b;b++)f+=d[b]instanceof Function?d[b].call(e,a):d[b];return f}}function K(a,b){return a.isValid()?(b=L(b,a.localeData()),Pc[b]=Pc[b]||J(b),Pc[b](a)):a.localeData().invalidDate()}function L(a,b){function c(a){return b.longDateFormat(a)||a}var d=5;for(Oc.lastIndex=0;d>=0&&Oc.test(a);)a=a.replace(Oc,c),Oc.lastIndex=0,d-=1;return a}function M(a){return"function"==typeof a&&"[object Function]"===Object.prototype.toString.call(a)}function N(a,b,c){dd[a]=M(b)?b:function(a){return a&&c?c:b}}function O(a,b){return f(dd,a)?dd[a](b._strict,b._locale):new RegExp(P(a))}function P(a){return a.replace("\\","").replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g,function(a,b,c,d,e){return b||c||d||e}).replace(/[-\/\\^$*+?.()|[\]{}]/g,"\\$&")}function Q(a,b){var c,d=b;for("string"==typeof a&&(a=[a]),"number"==typeof b&&(d=function(a,c){c[b]=q(a)}),c=0;c<a.length;c++)ed[a[c]]=d}function R(a,b){Q(a,function(a,c,d,e){d._w=d._w||{},b(a,d._w,d,e)})}function S(a,b,c){null!=b&&f(ed,a)&&ed[a](b,c._a,c,a)}function T(a,b){return new Date(Date.UTC(a,b+1,0)).getUTCDate()}function U(a){return this._months[a.month()]}function V(a){return this._monthsShort[a.month()]}function W(a,b,c){var d,e,f;for(this._monthsParse||(this._monthsParse=[],this._longMonthsParse=[],this._shortMonthsParse=[]),d=0;12>d;d++){if(e=h([2e3,d]),c&&!this._longMonthsParse[d]&&(this._longMonthsParse[d]=new RegExp("^"+this.months(e,"").replace(".","")+"$","i"),this._shortMonthsParse[d]=new RegExp("^"+this.monthsShort(e,"").replace(".","")+"$","i")),c||this._monthsParse[d]||(f="^"+this.months(e,"")+"|^"+this.monthsShort(e,""),this._monthsParse[d]=new RegExp(f.replace(".",""),"i")),c&&"MMMM"===b&&this._longMonthsParse[d].test(a))return d;if(c&&"MMM"===b&&this._shortMonthsParse[d].test(a))return d;if(!c&&this._monthsParse[d].test(a))return d}}function X(a,b){var c;return"string"==typeof b&&(b=a.localeData().monthsParse(b),"number"!=typeof b)?a:(c=Math.min(a.date(),T(a.year(),b)),a._d["set"+(a._isUTC?"UTC":"")+"Month"](b,c),a)}function Y(b){return null!=b?(X(this,b),a.updateOffset(this,!0),this):D(this,"Month")}function Z(){return T(this.year(),this.month())}function $(a){var b,c=a._a;return c&&-2===j(a).overflow&&(b=c[gd]<0||c[gd]>11?gd:c[hd]<1||c[hd]>T(c[fd],c[gd])?hd:c[id]<0||c[id]>24||24===c[id]&&(0!==c[jd]||0!==c[kd]||0!==c[ld])?id:c[jd]<0||c[jd]>59?jd:c[kd]<0||c[kd]>59?kd:c[ld]<0||c[ld]>999?ld:-1,j(a)._overflowDayOfYear&&(fd>b||b>hd)&&(b=hd),j(a).overflow=b),a}function _(b){a.suppressDeprecationWarnings===!1&&"undefined"!=typeof console&&console.warn&&console.warn("Deprecation warning: "+b)}function aa(a,b){var c=!0;return g(function(){return c&&(_(a+"\n"+(new Error).stack),c=!1),b.apply(this,arguments)},b)}function ba(a,b){od[a]||(_(b),od[a]=!0)}function ca(a){var b,c,d=a._i,e=pd.exec(d);if(e){for(j(a).iso=!0,b=0,c=qd.length;c>b;b++)if(qd[b][1].exec(d)){a._f=qd[b][0];break}for(b=0,c=rd.length;c>b;b++)if(rd[b][1].exec(d)){a._f+=(e[6]||" ")+rd[b][0];break}d.match(ad)&&(a._f+="Z"),va(a)}else a._isValid=!1}function da(b){var c=sd.exec(b._i);return null!==c?void(b._d=new Date(+c[1])):(ca(b),void(b._isValid===!1&&(delete b._isValid,a.createFromInputFallback(b))))}function ea(a,b,c,d,e,f,g){var h=new Date(a,b,c,d,e,f,g);return 1970>a&&h.setFullYear(a),h}function fa(a){var b=new Date(Date.UTC.apply(null,arguments));return 1970>a&&b.setUTCFullYear(a),b}function ga(a){return ha(a)?366:365}function ha(a){return a%4===0&&a%100!==0||a%400===0}function ia(){return ha(this.year())}function ja(a,b,c){var d,e=c-b,f=c-a.day();return f>e&&(f-=7),e-7>f&&(f+=7),d=Da(a).add(f,"d"),{week:Math.ceil(d.dayOfYear()/7),year:d.year()}}function ka(a){return ja(a,this._week.dow,this._week.doy).week}function la(){return this._week.dow}function ma(){return this._week.doy}function na(a){var b=this.localeData().week(this);return null==a?b:this.add(7*(a-b),"d")}function oa(a){var b=ja(this,1,4).week;return null==a?b:this.add(7*(a-b),"d")}function pa(a,b,c,d,e){var f,g=6+e-d,h=fa(a,0,1+g),i=h.getUTCDay();return e>i&&(i+=7),c=null!=c?1*c:e,f=1+g+7*(b-1)-i+c,{year:f>0?a:a-1,dayOfYear:f>0?f:ga(a-1)+f}}function qa(a){var b=Math.round((this.clone().startOf("day")-this.clone().startOf("year"))/864e5)+1;return null==a?b:this.add(a-b,"d")}function ra(a,b,c){return null!=a?a:null!=b?b:c}function sa(a){var b=new Date;return a._useUTC?[b.getUTCFullYear(),b.getUTCMonth(),b.getUTCDate()]:[b.getFullYear(),b.getMonth(),b.getDate()]}function ta(a){var b,c,d,e,f=[];if(!a._d){for(d=sa(a),a._w&&null==a._a[hd]&&null==a._a[gd]&&ua(a),a._dayOfYear&&(e=ra(a._a[fd],d[fd]),a._dayOfYear>ga(e)&&(j(a)._overflowDayOfYear=!0),c=fa(e,0,a._dayOfYear),a._a[gd]=c.getUTCMonth(),a._a[hd]=c.getUTCDate()),b=0;3>b&&null==a._a[b];++b)a._a[b]=f[b]=d[b];for(;7>b;b++)a._a[b]=f[b]=null==a._a[b]?2===b?1:0:a._a[b];24===a._a[id]&&0===a._a[jd]&&0===a._a[kd]&&0===a._a[ld]&&(a._nextDay=!0,a._a[id]=0),a._d=(a._useUTC?fa:ea).apply(null,f),null!=a._tzm&&a._d.setUTCMinutes(a._d.getUTCMinutes()-a._tzm),a._nextDay&&(a._a[id]=24)}}function ua(a){var b,c,d,e,f,g,h;b=a._w,null!=b.GG||null!=b.W||null!=b.E?(f=1,g=4,c=ra(b.GG,a._a[fd],ja(Da(),1,4).year),d=ra(b.W,1),e=ra(b.E,1)):(f=a._locale._week.dow,g=a._locale._week.doy,c=ra(b.gg,a._a[fd],ja(Da(),f,g).year),d=ra(b.w,1),null!=b.d?(e=b.d,f>e&&++d):e=null!=b.e?b.e+f:f),h=pa(c,d,e,g,f),a._a[fd]=h.year,a._dayOfYear=h.dayOfYear}function va(b){if(b._f===a.ISO_8601)return void ca(b);b._a=[],j(b).empty=!0;var c,d,e,f,g,h=""+b._i,i=h.length,k=0;for(e=L(b._f,b._locale).match(Nc)||[],c=0;c<e.length;c++)f=e[c],d=(h.match(O(f,b))||[])[0],d&&(g=h.substr(0,h.indexOf(d)),g.length>0&&j(b).unusedInput.push(g),h=h.slice(h.indexOf(d)+d.length),k+=d.length),Qc[f]?(d?j(b).empty=!1:j(b).unusedTokens.push(f),S(f,d,b)):b._strict&&!d&&j(b).unusedTokens.push(f);j(b).charsLeftOver=i-k,h.length>0&&j(b).unusedInput.push(h),j(b).bigHour===!0&&b._a[id]<=12&&b._a[id]>0&&(j(b).bigHour=void 0),b._a[id]=wa(b._locale,b._a[id],b._meridiem),ta(b),$(b)}function wa(a,b,c){var d;return null==c?b:null!=a.meridiemHour?a.meridiemHour(b,c):null!=a.isPM?(d=a.isPM(c),d&&12>b&&(b+=12),d||12!==b||(b=0),b):b}function xa(a){var b,c,d,e,f;if(0===a._f.length)return j(a).invalidFormat=!0,void(a._d=new Date(NaN));for(e=0;e<a._f.length;e++)f=0,b=m({},a),null!=a._useUTC&&(b._useUTC=a._useUTC),b._f=a._f[e],va(b),k(b)&&(f+=j(b).charsLeftOver,f+=10*j(b).unusedTokens.length,j(b).score=f,(null==d||d>f)&&(d=f,c=b));g(a,c||b)}function ya(a){if(!a._d){var b=B(a._i);a._a=[b.year,b.month,b.day||b.date,b.hour,b.minute,b.second,b.millisecond],ta(a)}}function za(a){var b=new n($(Aa(a)));return b._nextDay&&(b.add(1,"d"),b._nextDay=void 0),b}function Aa(a){var b=a._i,e=a._f;return a._locale=a._locale||y(a._l),null===b||void 0===e&&""===b?l({nullInput:!0}):("string"==typeof b&&(a._i=b=a._locale.preparse(b)),o(b)?new n($(b)):(c(e)?xa(a):e?va(a):d(b)?a._d=b:Ba(a),a))}function Ba(b){var f=b._i;void 0===f?b._d=new Date:d(f)?b._d=new Date(+f):"string"==typeof f?da(b):c(f)?(b._a=e(f.slice(0),function(a){return parseInt(a,10)}),ta(b)):"object"==typeof f?ya(b):"number"==typeof f?b._d=new Date(f):a.createFromInputFallback(b)}function Ca(a,b,c,d,e){var f={};return"boolean"==typeof c&&(d=c,c=void 0),f._isAMomentObject=!0,f._useUTC=f._isUTC=e,f._l=c,f._i=a,f._f=b,f._strict=d,za(f)}function Da(a,b,c,d){return Ca(a,b,c,d,!1)}function Ea(a,b){var d,e;if(1===b.length&&c(b[0])&&(b=b[0]),!b.length)return Da();for(d=b[0],e=1;e<b.length;++e)(!b[e].isValid()||b[e][a](d))&&(d=b[e]);return d}function Fa(){var a=[].slice.call(arguments,0);return Ea("isBefore",a)}function Ga(){var a=[].slice.call(arguments,0);return Ea("isAfter",a)}function Ha(a){var b=B(a),c=b.year||0,d=b.quarter||0,e=b.month||0,f=b.week||0,g=b.day||0,h=b.hour||0,i=b.minute||0,j=b.second||0,k=b.millisecond||0;this._milliseconds=+k+1e3*j+6e4*i+36e5*h,this._days=+g+7*f,this._months=+e+3*d+12*c,this._data={},this._locale=y(),this._bubble()}function Ia(a){return a instanceof Ha}function Ja(a,b){H(a,0,0,function(){var a=this.utcOffset(),c="+";return 0>a&&(a=-a,c="-"),c+G(~~(a/60),2)+b+G(~~a%60,2)})}function Ka(a){var b=(a||"").match(ad)||[],c=b[b.length-1]||[],d=(c+"").match(xd)||["-",0,0],e=+(60*d[1])+q(d[2]);return"+"===d[0]?e:-e}function La(b,c){var e,f;return c._isUTC?(e=c.clone(),f=(o(b)||d(b)?+b:+Da(b))-+e,e._d.setTime(+e._d+f),a.updateOffset(e,!1),e):Da(b).local()}function Ma(a){return 15*-Math.round(a._d.getTimezoneOffset()/15)}function Na(b,c){var d,e=this._offset||0;return null!=b?("string"==typeof b&&(b=Ka(b)),Math.abs(b)<16&&(b=60*b),!this._isUTC&&c&&(d=Ma(this)),this._offset=b,this._isUTC=!0,null!=d&&this.add(d,"m"),e!==b&&(!c||this._changeInProgress?bb(this,Ya(b-e,"m"),1,!1):this._changeInProgress||(this._changeInProgress=!0,a.updateOffset(this,!0),this._changeInProgress=null)),this):this._isUTC?e:Ma(this)}function Oa(a,b){return null!=a?("string"!=typeof a&&(a=-a),this.utcOffset(a,b),this):-this.utcOffset()}function Pa(a){return this.utcOffset(0,a)}function Qa(a){return this._isUTC&&(this.utcOffset(0,a),this._isUTC=!1,a&&this.subtract(Ma(this),"m")),this}function Ra(){return this._tzm?this.utcOffset(this._tzm):"string"==typeof this._i&&this.utcOffset(Ka(this._i)),this}function Sa(a){return a=a?Da(a).utcOffset():0,(this.utcOffset()-a)%60===0}function Ta(){return this.utcOffset()>this.clone().month(0).utcOffset()||this.utcOffset()>this.clone().month(5).utcOffset()}function Ua(){if("undefined"!=typeof this._isDSTShifted)return this._isDSTShifted;var a={};if(m(a,this),a=Aa(a),a._a){var b=a._isUTC?h(a._a):Da(a._a);this._isDSTShifted=this.isValid()&&r(a._a,b.toArray())>0}else this._isDSTShifted=!1;return this._isDSTShifted}function Va(){return!this._isUTC}function Wa(){return this._isUTC}function Xa(){return this._isUTC&&0===this._offset}function Ya(a,b){var c,d,e,g=a,h=null;return Ia(a)?g={ms:a._milliseconds,d:a._days,M:a._months}:"number"==typeof a?(g={},b?g[b]=a:g.milliseconds=a):(h=yd.exec(a))?(c="-"===h[1]?-1:1,g={y:0,d:q(h[hd])*c,h:q(h[id])*c,m:q(h[jd])*c,s:q(h[kd])*c,ms:q(h[ld])*c}):(h=zd.exec(a))?(c="-"===h[1]?-1:1,g={y:Za(h[2],c),M:Za(h[3],c),d:Za(h[4],c),h:Za(h[5],c),m:Za(h[6],c),s:Za(h[7],c),w:Za(h[8],c)}):null==g?g={}:"object"==typeof g&&("from"in g||"to"in g)&&(e=_a(Da(g.from),Da(g.to)),g={},g.ms=e.milliseconds,g.M=e.months),d=new Ha(g),Ia(a)&&f(a,"_locale")&&(d._locale=a._locale),d}function Za(a,b){var c=a&&parseFloat(a.replace(",","."));return(isNaN(c)?0:c)*b}function $a(a,b){var c={milliseconds:0,months:0};return c.months=b.month()-a.month()+12*(b.year()-a.year()),a.clone().add(c.months,"M").isAfter(b)&&--c.months,c.milliseconds=+b-+a.clone().add(c.months,"M"),c}function _a(a,b){var c;return b=La(b,a),a.isBefore(b)?c=$a(a,b):(c=$a(b,a),c.milliseconds=-c.milliseconds,c.months=-c.months),c}function ab(a,b){return function(c,d){var e,f;return null===d||isNaN(+d)||(ba(b,"moment()."+b+"(period, number) is deprecated. Please use moment()."+b+"(number, period)."),f=c,c=d,d=f),c="string"==typeof c?+c:c,e=Ya(c,d),bb(this,e,a),this}}function bb(b,c,d,e){var f=c._milliseconds,g=c._days,h=c._months;e=null==e?!0:e,f&&b._d.setTime(+b._d+f*d),g&&E(b,"Date",D(b,"Date")+g*d),h&&X(b,D(b,"Month")+h*d),e&&a.updateOffset(b,g||h)}function cb(a,b){var c=a||Da(),d=La(c,this).startOf("day"),e=this.diff(d,"days",!0),f=-6>e?"sameElse":-1>e?"lastWeek":0>e?"lastDay":1>e?"sameDay":2>e?"nextDay":7>e?"nextWeek":"sameElse";return this.format(b&&b[f]||this.localeData().calendar(f,this,Da(c)))}function db(){return new n(this)}function eb(a,b){var c;return b=A("undefined"!=typeof b?b:"millisecond"),"millisecond"===b?(a=o(a)?a:Da(a),+this>+a):(c=o(a)?+a:+Da(a),c<+this.clone().startOf(b))}function fb(a,b){var c;return b=A("undefined"!=typeof b?b:"millisecond"),"millisecond"===b?(a=o(a)?a:Da(a),+a>+this):(c=o(a)?+a:+Da(a),+this.clone().endOf(b)<c)}function gb(a,b,c){return this.isAfter(a,c)&&this.isBefore(b,c)}function hb(a,b){var c;return b=A(b||"millisecond"),"millisecond"===b?(a=o(a)?a:Da(a),+this===+a):(c=+Da(a),+this.clone().startOf(b)<=c&&c<=+this.clone().endOf(b))}function ib(a,b,c){var d,e,f=La(a,this),g=6e4*(f.utcOffset()-this.utcOffset());return b=A(b),"year"===b||"month"===b||"quarter"===b?(e=jb(this,f),"quarter"===b?e/=3:"year"===b&&(e/=12)):(d=this-f,e="second"===b?d/1e3:"minute"===b?d/6e4:"hour"===b?d/36e5:"day"===b?(d-g)/864e5:"week"===b?(d-g)/6048e5:d),c?e:p(e)}function jb(a,b){var c,d,e=12*(b.year()-a.year())+(b.month()-a.month()),f=a.clone().add(e,"months");return 0>b-f?(c=a.clone().add(e-1,"months"),d=(b-f)/(f-c)):(c=a.clone().add(e+1,"months"),d=(b-f)/(c-f)),-(e+d)}function kb(){return this.clone().locale("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ")}function lb(){var a=this.clone().utc();return 0<a.year()&&a.year()<=9999?"function"==typeof Date.prototype.toISOString?this.toDate().toISOString():K(a,"YYYY-MM-DD[T]HH:mm:ss.SSS[Z]"):K(a,"YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]")}function mb(b){var c=K(this,b||a.defaultFormat);return this.localeData().postformat(c)}function nb(a,b){return this.isValid()?Ya({to:this,from:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function ob(a){return this.from(Da(),a)}function pb(a,b){return this.isValid()?Ya({from:this,to:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function qb(a){return this.to(Da(),a)}function rb(a){var b;return void 0===a?this._locale._abbr:(b=y(a),null!=b&&(this._locale=b),this)}function sb(){return this._locale}function tb(a){switch(a=A(a)){case"year":this.month(0);case"quarter":case"month":this.date(1);case"week":case"isoWeek":case"day":this.hours(0);case"hour":this.minutes(0);case"minute":this.seconds(0);case"second":this.milliseconds(0)}return"week"===a&&this.weekday(0),"isoWeek"===a&&this.isoWeekday(1),"quarter"===a&&this.month(3*Math.floor(this.month()/3)),this}function ub(a){return a=A(a),void 0===a||"millisecond"===a?this:this.startOf(a).add(1,"isoWeek"===a?"week":a).subtract(1,"ms")}function vb(){return+this._d-6e4*(this._offset||0)}function wb(){return Math.floor(+this/1e3)}function xb(){return this._offset?new Date(+this):this._d}function yb(){var a=this;return[a.year(),a.month(),a.date(),a.hour(),a.minute(),a.second(),a.millisecond()]}function zb(){var a=this;return{years:a.year(),months:a.month(),date:a.date(),hours:a.hours(),minutes:a.minutes(),seconds:a.seconds(),milliseconds:a.milliseconds()}}function Ab(){return k(this)}function Bb(){return g({},j(this))}function Cb(){return j(this).overflow}function Db(a,b){H(0,[a,a.length],0,b)}function Eb(a,b,c){return ja(Da([a,11,31+b-c]),b,c).week}function Fb(a){var b=ja(this,this.localeData()._week.dow,this.localeData()._week.doy).year;return null==a?b:this.add(a-b,"y")}function Gb(a){var b=ja(this,1,4).year;return null==a?b:this.add(a-b,"y")}function Hb(){return Eb(this.year(),1,4)}function Ib(){var a=this.localeData()._week;return Eb(this.year(),a.dow,a.doy)}function Jb(a){return null==a?Math.ceil((this.month()+1)/3):this.month(3*(a-1)+this.month()%3)}function Kb(a,b){return"string"!=typeof a?a:isNaN(a)?(a=b.weekdaysParse(a),"number"==typeof a?a:null):parseInt(a,10)}function Lb(a){return this._weekdays[a.day()]}function Mb(a){return this._weekdaysShort[a.day()]}function Nb(a){return this._weekdaysMin[a.day()]}function Ob(a){var b,c,d;for(this._weekdaysParse=this._weekdaysParse||[],b=0;7>b;b++)if(this._weekdaysParse[b]||(c=Da([2e3,1]).day(b),d="^"+this.weekdays(c,"")+"|^"+this.weekdaysShort(c,"")+"|^"+this.weekdaysMin(c,""),this._weekdaysParse[b]=new RegExp(d.replace(".",""),"i")),this._weekdaysParse[b].test(a))return b}function Pb(a){var b=this._isUTC?this._d.getUTCDay():this._d.getDay();return null!=a?(a=Kb(a,this.localeData()),this.add(a-b,"d")):b}function Qb(a){var b=(this.day()+7-this.localeData()._week.dow)%7;return null==a?b:this.add(a-b,"d")}function Rb(a){return null==a?this.day()||7:this.day(this.day()%7?a:a-7)}function Sb(a,b){H(a,0,0,function(){return this.localeData().meridiem(this.hours(),this.minutes(),b)})}function Tb(a,b){return b._meridiemParse}function Ub(a){return"p"===(a+"").toLowerCase().charAt(0)}function Vb(a,b,c){return a>11?c?"pm":"PM":c?"am":"AM"}function Wb(a,b){b[ld]=q(1e3*("0."+a))}function Xb(){return this._isUTC?"UTC":""}function Yb(){return this._isUTC?"Coordinated Universal Time":""}function Zb(a){return Da(1e3*a)}function $b(){return Da.apply(null,arguments).parseZone()}function _b(a,b,c){var d=this._calendar[a];return"function"==typeof d?d.call(b,c):d}function ac(a){var b=this._longDateFormat[a],c=this._longDateFormat[a.toUpperCase()];return b||!c?b:(this._longDateFormat[a]=c.replace(/MMMM|MM|DD|dddd/g,function(a){return a.slice(1)}),this._longDateFormat[a])}function bc(){return this._invalidDate}function cc(a){return this._ordinal.replace("%d",a)}function dc(a){return a}function ec(a,b,c,d){var e=this._relativeTime[c];return"function"==typeof e?e(a,b,c,d):e.replace(/%d/i,a)}function fc(a,b){var c=this._relativeTime[a>0?"future":"past"];return"function"==typeof c?c(b):c.replace(/%s/i,b)}function gc(a){var b,c;for(c in a)b=a[c],"function"==typeof b?this[c]=b:this["_"+c]=b;this._ordinalParseLenient=new RegExp(this._ordinalParse.source+"|"+/\d{1,2}/.source)}function hc(a,b,c,d){var e=y(),f=h().set(d,b);return e[c](f,a)}function ic(a,b,c,d,e){if("number"==typeof a&&(b=a,a=void 0),a=a||"",null!=b)return hc(a,b,c,e);var f,g=[];for(f=0;d>f;f++)g[f]=hc(a,f,c,e);return g}function jc(a,b){return ic(a,b,"months",12,"month")}function kc(a,b){return ic(a,b,"monthsShort",12,"month")}function lc(a,b){return ic(a,b,"weekdays",7,"day")}function mc(a,b){return ic(a,b,"weekdaysShort",7,"day")}function nc(a,b){return ic(a,b,"weekdaysMin",7,"day")}function oc(){var a=this._data;return this._milliseconds=Wd(this._milliseconds),this._days=Wd(this._days),this._months=Wd(this._months),a.milliseconds=Wd(a.milliseconds),a.seconds=Wd(a.seconds),a.minutes=Wd(a.minutes),a.hours=Wd(a.hours),a.months=Wd(a.months),a.years=Wd(a.years),this}function pc(a,b,c,d){var e=Ya(b,c);return a._milliseconds+=d*e._milliseconds,a._days+=d*e._days,a._months+=d*e._months,a._bubble()}function qc(a,b){return pc(this,a,b,1)}function rc(a,b){return pc(this,a,b,-1)}function sc(a){return 0>a?Math.floor(a):Math.ceil(a)}function tc(){var a,b,c,d,e,f=this._milliseconds,g=this._days,h=this._months,i=this._data;return f>=0&&g>=0&&h>=0||0>=f&&0>=g&&0>=h||(f+=864e5*sc(vc(h)+g),g=0,h=0),i.milliseconds=f%1e3,a=p(f/1e3),i.seconds=a%60,b=p(a/60),i.minutes=b%60,c=p(b/60),i.hours=c%24,g+=p(c/24),e=p(uc(g)),h+=e,g-=sc(vc(e)),d=p(h/12),h%=12,i.days=g,i.months=h,i.years=d,this}function uc(a){return 4800*a/146097}function vc(a){return 146097*a/4800}function wc(a){var b,c,d=this._milliseconds;if(a=A(a),"month"===a||"year"===a)return b=this._days+d/864e5,c=this._months+uc(b),"month"===a?c:c/12;switch(b=this._days+Math.round(vc(this._months)),a){case"week":return b/7+d/6048e5;case"day":return b+d/864e5;case"hour":return 24*b+d/36e5;case"minute":return 1440*b+d/6e4;case"second":return 86400*b+d/1e3;case"millisecond":return Math.floor(864e5*b)+d;default:throw new Error("Unknown unit "+a)}}function xc(){return this._milliseconds+864e5*this._days+this._months%12*2592e6+31536e6*q(this._months/12)}function yc(a){return function(){return this.as(a)}}function zc(a){return a=A(a),this[a+"s"]()}function Ac(a){return function(){return this._data[a]}}function Bc(){return p(this.days()/7)}function Cc(a,b,c,d,e){return e.relativeTime(b||1,!!c,a,d)}function Dc(a,b,c){var d=Ya(a).abs(),e=ke(d.as("s")),f=ke(d.as("m")),g=ke(d.as("h")),h=ke(d.as("d")),i=ke(d.as("M")),j=ke(d.as("y")),k=e<le.s&&["s",e]||1===f&&["m"]||f<le.m&&["mm",f]||1===g&&["h"]||g<le.h&&["hh",g]||1===h&&["d"]||h<le.d&&["dd",h]||1===i&&["M"]||i<le.M&&["MM",i]||1===j&&["y"]||["yy",j];return k[2]=b,k[3]=+a>0,k[4]=c,Cc.apply(null,k)}function Ec(a,b){return void 0===le[a]?!1:void 0===b?le[a]:(le[a]=b,!0)}function Fc(a){var b=this.localeData(),c=Dc(this,!a,b);return a&&(c=b.pastFuture(+this,c)),b.postformat(c)}function Gc(){var a,b,c,d=me(this._milliseconds)/1e3,e=me(this._days),f=me(this._months);a=p(d/60),b=p(a/60),d%=60,a%=60,c=p(f/12),f%=12;var g=c,h=f,i=e,j=b,k=a,l=d,m=this.asSeconds();return m?(0>m?"-":"")+"P"+(g?g+"Y":"")+(h?h+"M":"")+(i?i+"D":"")+(j||k||l?"T":"")+(j?j+"H":"")+(k?k+"M":"")+(l?l+"S":""):"P0D"}var Hc,Ic,Jc=a.momentProperties=[],Kc=!1,Lc={},Mc={},Nc=/(\[[^\[]*\])|(\\)?(Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Q|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|mm?|ss?|S{1,9}|x|X|zz?|ZZ?|.)/g,Oc=/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g,Pc={},Qc={},Rc=/\d/,Sc=/\d\d/,Tc=/\d{3}/,Uc=/\d{4}/,Vc=/[+-]?\d{6}/,Wc=/\d\d?/,Xc=/\d{1,3}/,Yc=/\d{1,4}/,Zc=/[+-]?\d{1,6}/,$c=/\d+/,_c=/[+-]?\d+/,ad=/Z|[+-]\d\d:?\d\d/gi,bd=/[+-]?\d+(\.\d{1,3})?/,cd=/[0-9]*['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+|[\u0600-\u06FF\/]+(\s*?[\u0600-\u06FF]+){1,2}/i,dd={},ed={},fd=0,gd=1,hd=2,id=3,jd=4,kd=5,ld=6;H("M",["MM",2],"Mo",function(){return this.month()+1}),H("MMM",0,0,function(a){return this.localeData().monthsShort(this,a)}),H("MMMM",0,0,function(a){return this.localeData().months(this,a)}),z("month","M"),N("M",Wc),N("MM",Wc,Sc),N("MMM",cd),N("MMMM",cd),Q(["M","MM"],function(a,b){b[gd]=q(a)-1}),Q(["MMM","MMMM"],function(a,b,c,d){var e=c._locale.monthsParse(a,d,c._strict);null!=e?b[gd]=e:j(c).invalidMonth=a});var md="January_February_March_April_May_June_July_August_September_October_November_December".split("_"),nd="Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),od={};a.suppressDeprecationWarnings=!1;var pd=/^\s*(?:[+-]\d{6}|\d{4})-(?:(\d\d-\d\d)|(W\d\d$)|(W\d\d-\d)|(\d\d\d))((T| )(\d\d(:\d\d(:\d\d(\.\d+)?)?)?)?([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,qd=[["YYYYYY-MM-DD",/[+-]\d{6}-\d{2}-\d{2}/],["YYYY-MM-DD",/\d{4}-\d{2}-\d{2}/],["GGGG-[W]WW-E",/\d{4}-W\d{2}-\d/],["GGGG-[W]WW",/\d{4}-W\d{2}/],["YYYY-DDD",/\d{4}-\d{3}/]],rd=[["HH:mm:ss.SSSS",/(T| )\d\d:\d\d:\d\d\.\d+/],["HH:mm:ss",/(T| )\d\d:\d\d:\d\d/],["HH:mm",/(T| )\d\d:\d\d/],["HH",/(T| )\d\d/]],sd=/^\/?Date\((\-?\d+)/i;a.createFromInputFallback=aa("moment construction falls back to js Date. This is discouraged and will be removed in upcoming major release. Please refer to https://github.com/moment/moment/issues/1407 for more info.",function(a){a._d=new Date(a._i+(a._useUTC?" UTC":""))}),H(0,["YY",2],0,function(){return this.year()%100}),H(0,["YYYY",4],0,"year"),H(0,["YYYYY",5],0,"year"),H(0,["YYYYYY",6,!0],0,"year"),z("year","y"),N("Y",_c),N("YY",Wc,Sc),N("YYYY",Yc,Uc),N("YYYYY",Zc,Vc),N("YYYYYY",Zc,Vc),Q(["YYYYY","YYYYYY"],fd),Q("YYYY",function(b,c){c[fd]=2===b.length?a.parseTwoDigitYear(b):q(b)}),Q("YY",function(b,c){c[fd]=a.parseTwoDigitYear(b)}),a.parseTwoDigitYear=function(a){return q(a)+(q(a)>68?1900:2e3)};var td=C("FullYear",!1);H("w",["ww",2],"wo","week"),H("W",["WW",2],"Wo","isoWeek"),z("week","w"),z("isoWeek","W"),N("w",Wc),N("ww",Wc,Sc),N("W",Wc),N("WW",Wc,Sc),R(["w","ww","W","WW"],function(a,b,c,d){b[d.substr(0,1)]=q(a)});var ud={dow:0,doy:6};H("DDD",["DDDD",3],"DDDo","dayOfYear"),z("dayOfYear","DDD"),N("DDD",Xc),N("DDDD",Tc),Q(["DDD","DDDD"],function(a,b,c){c._dayOfYear=q(a)}),a.ISO_8601=function(){};var vd=aa("moment().min is deprecated, use moment.min instead. https://github.com/moment/moment/issues/1548",function(){var a=Da.apply(null,arguments);return this>a?this:a}),wd=aa("moment().max is deprecated, use moment.max instead. https://github.com/moment/moment/issues/1548",function(){var a=Da.apply(null,arguments);return a>this?this:a});Ja("Z",":"),Ja("ZZ",""),N("Z",ad),N("ZZ",ad),Q(["Z","ZZ"],function(a,b,c){c._useUTC=!0,c._tzm=Ka(a)});var xd=/([\+\-]|\d\d)/gi;a.updateOffset=function(){};var yd=/(\-)?(?:(\d*)\.)?(\d+)\:(\d+)(?:\:(\d+)\.?(\d{3})?)?/,zd=/^(-)?P(?:(?:([0-9,.]*)Y)?(?:([0-9,.]*)M)?(?:([0-9,.]*)D)?(?:T(?:([0-9,.]*)H)?(?:([0-9,.]*)M)?(?:([0-9,.]*)S)?)?|([0-9,.]*)W)$/;Ya.fn=Ha.prototype;var Ad=ab(1,"add"),Bd=ab(-1,"subtract");a.defaultFormat="YYYY-MM-DDTHH:mm:ssZ";var Cd=aa("moment().lang() is deprecated. Instead, use moment().localeData() to get the language configuration. Use moment().locale() to change languages.",function(a){return void 0===a?this.localeData():this.locale(a)});H(0,["gg",2],0,function(){return this.weekYear()%100}),H(0,["GG",2],0,function(){return this.isoWeekYear()%100}),Db("gggg","weekYear"),Db("ggggg","weekYear"),Db("GGGG","isoWeekYear"),Db("GGGGG","isoWeekYear"),z("weekYear","gg"),z("isoWeekYear","GG"),N("G",_c),N("g",_c),N("GG",Wc,Sc),N("gg",Wc,Sc),N("GGGG",Yc,Uc),N("gggg",Yc,Uc),N("GGGGG",Zc,Vc),N("ggggg",Zc,Vc),R(["gggg","ggggg","GGGG","GGGGG"],function(a,b,c,d){b[d.substr(0,2)]=q(a)}),R(["gg","GG"],function(b,c,d,e){c[e]=a.parseTwoDigitYear(b)}),H("Q",0,0,"quarter"),z("quarter","Q"),N("Q",Rc),Q("Q",function(a,b){b[gd]=3*(q(a)-1)}),H("D",["DD",2],"Do","date"),z("date","D"),N("D",Wc),N("DD",Wc,Sc),N("Do",function(a,b){return a?b._ordinalParse:b._ordinalParseLenient}),Q(["D","DD"],hd),Q("Do",function(a,b){b[hd]=q(a.match(Wc)[0],10)});var Dd=C("Date",!0);H("d",0,"do","day"),H("dd",0,0,function(a){return this.localeData().weekdaysMin(this,a)}),H("ddd",0,0,function(a){return this.localeData().weekdaysShort(this,a)}),H("dddd",0,0,function(a){return this.localeData().weekdays(this,a)}),H("e",0,0,"weekday"),H("E",0,0,"isoWeekday"),z("day","d"),z("weekday","e"),z("isoWeekday","E"),N("d",Wc),N("e",Wc),N("E",Wc),N("dd",cd),N("ddd",cd),N("dddd",cd),R(["dd","ddd","dddd"],function(a,b,c){var d=c._locale.weekdaysParse(a);null!=d?b.d=d:j(c).invalidWeekday=a}),R(["d","e","E"],function(a,b,c,d){b[d]=q(a)});var Ed="Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),Fd="Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),Gd="Su_Mo_Tu_We_Th_Fr_Sa".split("_");H("H",["HH",2],0,"hour"),H("h",["hh",2],0,function(){return this.hours()%12||12}),Sb("a",!0),Sb("A",!1),z("hour","h"),N("a",Tb),N("A",Tb),N("H",Wc),N("h",Wc),N("HH",Wc,Sc),N("hh",Wc,Sc),Q(["H","HH"],id),Q(["a","A"],function(a,b,c){c._isPm=c._locale.isPM(a),c._meridiem=a}),Q(["h","hh"],function(a,b,c){b[id]=q(a),j(c).bigHour=!0});var Hd=/[ap]\.?m?\.?/i,Id=C("Hours",!0);H("m",["mm",2],0,"minute"),z("minute","m"),N("m",Wc),N("mm",Wc,Sc),Q(["m","mm"],jd);var Jd=C("Minutes",!1);H("s",["ss",2],0,"second"),z("second","s"),N("s",Wc),N("ss",Wc,Sc),Q(["s","ss"],kd);var Kd=C("Seconds",!1);H("S",0,0,function(){return~~(this.millisecond()/100)}),H(0,["SS",2],0,function(){return~~(this.millisecond()/10)}),H(0,["SSS",3],0,"millisecond"),H(0,["SSSS",4],0,function(){return 10*this.millisecond()}),H(0,["SSSSS",5],0,function(){return 100*this.millisecond()}),H(0,["SSSSSS",6],0,function(){return 1e3*this.millisecond()}),H(0,["SSSSSSS",7],0,function(){return 1e4*this.millisecond()}),H(0,["SSSSSSSS",8],0,function(){return 1e5*this.millisecond()}),H(0,["SSSSSSSSS",9],0,function(){return 1e6*this.millisecond()}),z("millisecond","ms"),N("S",Xc,Rc),N("SS",Xc,Sc),N("SSS",Xc,Tc);var Ld;for(Ld="SSSS";Ld.length<=9;Ld+="S")N(Ld,$c);for(Ld="S";Ld.length<=9;Ld+="S")Q(Ld,Wb);var Md=C("Milliseconds",!1);H("z",0,0,"zoneAbbr"),H("zz",0,0,"zoneName");var Nd=n.prototype;Nd.add=Ad,Nd.calendar=cb,Nd.clone=db,Nd.diff=ib,Nd.endOf=ub,Nd.format=mb,Nd.from=nb,Nd.fromNow=ob,Nd.to=pb,Nd.toNow=qb,Nd.get=F,Nd.invalidAt=Cb,Nd.isAfter=eb,Nd.isBefore=fb,Nd.isBetween=gb,Nd.isSame=hb,Nd.isValid=Ab,Nd.lang=Cd,Nd.locale=rb,Nd.localeData=sb,Nd.max=wd,Nd.min=vd,Nd.parsingFlags=Bb,Nd.set=F,Nd.startOf=tb,Nd.subtract=Bd,Nd.toArray=yb,Nd.toObject=zb,Nd.toDate=xb,Nd.toISOString=lb,Nd.toJSON=lb,Nd.toString=kb,Nd.unix=wb,Nd.valueOf=vb,Nd.year=td,Nd.isLeapYear=ia,Nd.weekYear=Fb,Nd.isoWeekYear=Gb,Nd.quarter=Nd.quarters=Jb,Nd.month=Y,Nd.daysInMonth=Z,Nd.week=Nd.weeks=na,Nd.isoWeek=Nd.isoWeeks=oa,Nd.weeksInYear=Ib,Nd.isoWeeksInYear=Hb,Nd.date=Dd,Nd.day=Nd.days=Pb,Nd.weekday=Qb,Nd.isoWeekday=Rb,Nd.dayOfYear=qa,Nd.hour=Nd.hours=Id,Nd.minute=Nd.minutes=Jd,Nd.second=Nd.seconds=Kd,
		Nd.millisecond=Nd.milliseconds=Md,Nd.utcOffset=Na,Nd.utc=Pa,Nd.local=Qa,Nd.parseZone=Ra,Nd.hasAlignedHourOffset=Sa,Nd.isDST=Ta,Nd.isDSTShifted=Ua,Nd.isLocal=Va,Nd.isUtcOffset=Wa,Nd.isUtc=Xa,Nd.isUTC=Xa,Nd.zoneAbbr=Xb,Nd.zoneName=Yb,Nd.dates=aa("dates accessor is deprecated. Use date instead.",Dd),Nd.months=aa("months accessor is deprecated. Use month instead",Y),Nd.years=aa("years accessor is deprecated. Use year instead",td),Nd.zone=aa("moment().zone is deprecated, use moment().utcOffset instead. https://github.com/moment/moment/issues/1779",Oa);var Od=Nd,Pd={sameDay:"[Today at] LT",nextDay:"[Tomorrow at] LT",nextWeek:"dddd [at] LT",lastDay:"[Yesterday at] LT",lastWeek:"[Last] dddd [at] LT",sameElse:"L"},Qd={LTS:"h:mm:ss A",LT:"h:mm A",L:"MM/DD/YYYY",LL:"MMMM D, YYYY",LLL:"MMMM D, YYYY h:mm A",LLLL:"dddd, MMMM D, YYYY h:mm A"},Rd="",Sd="%d",Td=/\d{1,2}/,Ud={future:"in %s",past:"%s ago",s:"a few seconds",m:"a minute",mm:"%d minutes",h:"an hour",hh:"%d hours",d:"a day",dd:"%d days",M:"a month",MM:"%d months",y:"a year",yy:"%d years"},Vd=s.prototype;Vd._calendar=Pd,Vd.calendar=_b,Vd._longDateFormat=Qd,Vd.longDateFormat=ac,Vd._invalidDate=Rd,Vd.invalidDate=bc,Vd._ordinal=Sd,Vd.ordinal=cc,Vd._ordinalParse=Td,Vd.preparse=dc,Vd.postformat=dc,Vd._relativeTime=Ud,Vd.relativeTime=ec,Vd.pastFuture=fc,Vd.set=gc,Vd.months=U,Vd._months=md,Vd.monthsShort=V,Vd._monthsShort=nd,Vd.monthsParse=W,Vd.week=ka,Vd._week=ud,Vd.firstDayOfYear=ma,Vd.firstDayOfWeek=la,Vd.weekdays=Lb,Vd._weekdays=Ed,Vd.weekdaysMin=Nb,Vd._weekdaysMin=Gd,Vd.weekdaysShort=Mb,Vd._weekdaysShort=Fd,Vd.weekdaysParse=Ob,Vd.isPM=Ub,Vd._meridiemParse=Hd,Vd.meridiem=Vb,w("en",{ordinalParse:/\d{1,2}(th|st|nd|rd)/,ordinal:function(a){var b=a%10,c=1===q(a%100/10)?"th":1===b?"st":2===b?"nd":3===b?"rd":"th";return a+c}}),a.lang=aa("moment.lang is deprecated. Use moment.locale instead.",w),a.langData=aa("moment.langData is deprecated. Use moment.localeData instead.",y);var Wd=Math.abs,Xd=yc("ms"),Yd=yc("s"),Zd=yc("m"),$d=yc("h"),_d=yc("d"),ae=yc("w"),be=yc("M"),ce=yc("y"),de=Ac("milliseconds"),ee=Ac("seconds"),fe=Ac("minutes"),ge=Ac("hours"),he=Ac("days"),ie=Ac("months"),je=Ac("years"),ke=Math.round,le={s:45,m:45,h:22,d:26,M:11},me=Math.abs,ne=Ha.prototype;ne.abs=oc,ne.add=qc,ne.subtract=rc,ne.as=wc,ne.asMilliseconds=Xd,ne.asSeconds=Yd,ne.asMinutes=Zd,ne.asHours=$d,ne.asDays=_d,ne.asWeeks=ae,ne.asMonths=be,ne.asYears=ce,ne.valueOf=xc,ne._bubble=tc,ne.get=zc,ne.milliseconds=de,ne.seconds=ee,ne.minutes=fe,ne.hours=ge,ne.days=he,ne.weeks=Bc,ne.months=ie,ne.years=je,ne.humanize=Fc,ne.toISOString=Gc,ne.toString=Gc,ne.toJSON=Gc,ne.locale=rb,ne.localeData=sb,ne.toIsoString=aa("toIsoString() is deprecated. Please use toISOString() instead (notice the capitals)",Gc),ne.lang=Cd,H("X",0,0,"unix"),H("x",0,0,"valueOf"),N("x",_c),N("X",bd),Q("X",function(a,b,c){c._d=new Date(1e3*parseFloat(a,10))}),Q("x",function(a,b,c){c._d=new Date(q(a))}),a.version="2.10.6",b(Da),a.fn=Od,a.min=Fa,a.max=Ga,a.utc=h,a.unix=Zb,a.months=jc,a.isDate=d,a.locale=w,a.invalid=l,a.duration=Ya,a.isMoment=o,a.weekdays=lc,a.parseZone=$b,a.localeData=y,a.isDuration=Ia,a.monthsShort=kc,a.weekdaysMin=nc,a.defineLocale=x,a.weekdaysShort=mc,a.normalizeUnits=A,a.relativeTimeThreshold=Ec;var oe=a;return oe});

//http://www.daterangepicker.com/#config

(function(root, factory) {

	if (typeof define === 'function' && define.amd) {
		define(['moment', 'jquery', 'exports'], function(momentjs, $, exports) {
			root.daterangepicker = factory(root, exports, momentjs, $);
		});

	} else if (typeof exports !== 'undefined') {
		var momentjs = require('moment');
		var jQuery = window.jQuery;
		if (jQuery === undefined) {
			try {
				jQuery = require('jquery');
			} catch (err) {
				if (!jQuery) throw new Error('jQuery dependency not found');
			}
		}

		factory(root, exports, momentjs, jQuery);

		// Finally, as a browser global.
	} else {
		root.daterangepicker = factory(root, {}, root.moment || moment, (root.jQuery || root.Zepto || root.ender || root.$));
	}

}(this, function(root, daterangepicker, moment, $) {

	var DateRangePicker = function(element, options, cb) {

		//default settings for options
		this.parentEl = 'body';
		this.element = $(element);
		this.startDate = moment().startOf('day');
		this.endDate = moment().endOf('day');
		this.timeZone = moment().utcOffset();
		this.minDate = false;
		this.maxDate = false;
		this.dateLimit = false;
		this.autoApply = false;
		this.singleDatePicker = false;
		this.showDropdowns = false;
		this.showWeekNumbers = false;
		this.timePicker = false;
		this.timePicker24Hour = false;
		this.timePickerIncrement = 1;
		this.timePickerSeconds = false;
		this.linkedCalendars = true;
		this.autoUpdateInput = true;
		this.ranges = {};

		this.opens = 'right';
		if (this.element.hasClass('pull-right'))
			this.opens = 'left';

		this.drops = 'down';
		if (this.element.hasClass('dropup'))
			this.drops = 'up';

		this.buttonClasses = 'btn btn-sm';
		this.applyClass = 'btn-success';
		this.cancelClass = 'btn-default';

		this.locale = {
			format: 'MM/DD/YYYY',
			separator: ' - ',
			applyLabel: '적용',
			cancelLabel: '취소',
			weekLabel: 'W',
			customRangeLabel: 'Custom Range',
			daysOfWeek: moment.weekdaysMin(),
			monthNames: moment.monthsShort(),
			firstDay: moment.localeData().firstDayOfWeek()
		};

		this.callback = function() { };

		//some state information
		this.isShowing = false;
		this.leftCalendar = {};
		this.rightCalendar = {};

		//custom options from user
		if (typeof options !== 'object' || options === null)
			options = {};

		//allow setting options with data attributes
		//data-api options will be overwritten with custom javascript options
		options = $.extend(this.element.data(), options);

		//html template for the picker UI
		if (typeof options.template !== 'string')
			options.template = '<div class="daterangepicker dropdown-menu">' +
					'<div class="calendar left">' +
					'<div class="daterangepicker_input">' +
					'<input class="input-mini" type="text" name="daterangepicker_start" value="" />' +
					'<i class="fa fa-calendar glyphicon glyphicon-calendar"></i>' +
					'<div class="calendar-time">' +
					'<div></div>' +
					'<i class="fa fa-clock-o glyphicon glyphicon-time"></i>' +
					'</div>' +
					'</div>' +
					'<div class="calendar-table"></div>' +
					'</div>' +
					'<div class="calendar right">' +
					'<div class="daterangepicker_input">' +
					'<input class="input-mini" type="text" name="daterangepicker_end" value="" />' +
					'<i class="fa fa-calendar glyphicon glyphicon-calendar"></i>' +
					'<div class="calendar-time">' +
					'<div></div>' +
					'<i class="fa fa-clock-o glyphicon glyphicon-time"></i>' +
					'</div>' +
					'</div>' +
					'<div class="calendar-table"></div>' +
					'</div>' +
					'<div class="ranges">' +
					'<div class="range_inputs">' +
					'<button class="applyBtn" disabled="disabled" type="button"></button> ' +
					'<button class="cancelBtn" type="button"></button>' +
					'</div>' +
					'</div>' +
					'</div>';

		this.parentEl = (options.parentEl && $(options.parentEl).length) ? $(options.parentEl) : $(this.parentEl);
		this.container = $(options.template).appendTo(this.parentEl);

		//
		// handle all the possible options overriding defaults
		//

		if (typeof options.locale === 'object') {

			if (typeof options.locale.format === 'string')
				this.locale.format = options.locale.format;

			if (typeof options.locale.separator === 'string')
				this.locale.separator = options.locale.separator;

			if (typeof options.locale.daysOfWeek === 'object')
				this.locale.daysOfWeek = options.locale.daysOfWeek.slice();

			if (typeof options.locale.monthNames === 'object')
				this.locale.monthNames = options.locale.monthNames.slice();

			if (typeof options.locale.firstDay === 'number')
				this.locale.firstDay = options.locale.firstDay;

			if (typeof options.locale.applyLabel === 'string')
				this.locale.applyLabel = options.locale.applyLabel;

			if (typeof options.locale.cancelLabel === 'string')
				this.locale.cancelLabel = options.locale.cancelLabel;

			if (typeof options.locale.weekLabel === 'string')
				this.locale.weekLabel = options.locale.weekLabel;

			if (typeof options.locale.customRangeLabel === 'string')
				this.locale.customRangeLabel = options.locale.customRangeLabel;

		}

		if (typeof options.startDate === 'string')
			this.startDate = moment(options.startDate, this.locale.format);

		if (typeof options.endDate === 'string')
			this.endDate = moment(options.endDate, this.locale.format);

		if (typeof options.minDate === 'string')
			this.minDate = moment(options.minDate, this.locale.format);

		if (typeof options.maxDate === 'string')
			this.maxDate = moment(options.maxDate, this.locale.format);

		if (typeof options.startDate === 'object')
			this.startDate = moment(options.startDate);

		if (typeof options.endDate === 'object')
			this.endDate = moment(options.endDate);

		if (typeof options.minDate === 'object')
			this.minDate = moment(options.minDate);

		if (typeof options.maxDate === 'object')
			this.maxDate = moment(options.maxDate);

		// sanity check for bad options
		if (this.minDate && this.startDate.isBefore(this.minDate))
			this.startDate = this.minDate.clone();

		// sanity check for bad options
		if (this.maxDate && this.endDate.isAfter(this.maxDate))
			this.endDate = this.maxDate.clone();

		if (typeof options.applyClass === 'string')
			this.applyClass = options.applyClass;

		if (typeof options.cancelClass === 'string')
			this.cancelClass = options.cancelClass;

		if (typeof options.dateLimit === 'object')
			this.dateLimit = options.dateLimit;

		if (typeof options.opens === 'string')
			this.opens = options.opens;

		if (typeof options.drops === 'string')
			this.drops = options.drops;

		if (typeof options.showWeekNumbers === 'boolean')
			this.showWeekNumbers = options.showWeekNumbers;

		if (typeof options.buttonClasses === 'string')
			this.buttonClasses = options.buttonClasses;

		if (typeof options.buttonClasses === 'object')
			this.buttonClasses = options.buttonClasses.join(' ');

		if (typeof options.showDropdowns === 'boolean')
			this.showDropdowns = options.showDropdowns;

		if (typeof options.singleDatePicker === 'boolean') {
			this.singleDatePicker = options.singleDatePicker;
			if (this.singleDatePicker)
				this.endDate = this.startDate.clone();
		}

		if (typeof options.timePicker === 'boolean')
			this.timePicker = options.timePicker;

		if (typeof options.timePickerSeconds === 'boolean')
			this.timePickerSeconds = options.timePickerSeconds;

		if (typeof options.timePickerIncrement === 'number')
			this.timePickerIncrement = options.timePickerIncrement;

		if (typeof options.timePicker24Hour === 'boolean')
			this.timePicker24Hour = options.timePicker24Hour;

		if (typeof options.autoApply === 'boolean')
			this.autoApply = options.autoApply;

		if (typeof options.autoUpdateInput === 'boolean')
			this.autoUpdateInput = options.autoUpdateInput;

		if (typeof options.linkedCalendars === 'boolean')
			this.linkedCalendars = options.linkedCalendars;

		if (typeof options.isInvalidDate === 'function')
			this.isInvalidDate = options.isInvalidDate;

		// update day names order to firstDay
		if (this.locale.firstDay != 0) {
			var iterator = this.locale.firstDay;
			while (iterator > 0) {
				this.locale.daysOfWeek.push(this.locale.daysOfWeek.shift());
				iterator--;
			}
		}

		var start, end, range;

		//if no start/end dates set, check if an input element contains initial values
		if (typeof options.startDate === 'undefined' && typeof options.endDate === 'undefined') {
			if ($(this.element).is('input[type=text]')) {
				var val = $(this.element).val(),
						split = val.split(this.locale.separator);

				start = end = null;

				if (split.length == 2) {
					start = moment(split[0], this.locale.format);
					end = moment(split[1], this.locale.format);
				} else if (this.singleDatePicker && val !== "") {
					start = moment(val, this.locale.format);
					end = moment(val, this.locale.format);
				}
				if (start !== null && end !== null) {
					this.setStartDate(start);
					this.setEndDate(end);
				}
			}
		}

		// bind the time zone used to build the calendar to either the timeZone passed in through the options or the zone of the startDate (which will be the local time zone by default)
		if (typeof options.timeZone === 'string' || typeof options.timeZone === 'number') {
			if (typeof options.timeZone === 'string' && typeof moment.tz !== 'undefined') {
				this.timeZone = moment.tz.zone(options.timeZone).parse(new Date) * -1;  // Offset is positive if the timezone is behind UTC and negative if it is ahead.
			} else {
				this.timeZone = options.timeZone;
			}
			this.startDate.utcOffset(this.timeZone);
			this.endDate.utcOffset(this.timeZone);
		} else {
			this.timeZone = moment(this.startDate).utcOffset();
		}

		if (typeof options.ranges === 'object') {
			for (range in options.ranges) {

				if (typeof options.ranges[range][0] === 'string')
					start = moment(options.ranges[range][0], this.locale.format);
				else
					start = moment(options.ranges[range][0]);

				if (typeof options.ranges[range][1] === 'string')
					end = moment(options.ranges[range][1], this.locale.format);
				else
					end = moment(options.ranges[range][1]);

				// If the start or end date exceed those allowed by the minDate or dateLimit
				// options, shorten the range to the allowable period.
				if (this.minDate && start.isBefore(this.minDate))
					start = this.minDate.clone();

				var maxDate = this.maxDate;
				if (this.dateLimit && start.clone().add(this.dateLimit).isAfter(maxDate))
					maxDate = start.clone().add(this.dateLimit);
				if (maxDate && end.isAfter(maxDate))
					end = maxDate.clone();

				// If the end of the range is before the minimum or the start of the range is
				// after the maximum, don't display this range option at all.
				if ((this.minDate && end.isBefore(this.minDate)) || (maxDate && start.isAfter(maxDate)))
					continue;

				this.ranges[range] = [start, end];
			}

			var list = '<ul>';
			for (range in this.ranges) {
				list += '<li>' + range + '</li>';
			}
			list += '<li>' + this.locale.customRangeLabel + '</li>';
			list += '</ul>';
			this.container.find('.ranges ul').remove();
			this.container.find('.ranges').prepend(list);
		}

		if (typeof cb === 'function') {
			this.callback = cb;
		}

		if (!this.timePicker) {
			this.startDate = this.startDate.startOf('day');
			this.endDate = this.endDate.endOf('day');
			this.container.find('.calendar-time').hide();
		}

		//can't be used together for now
		if (this.timePicker && this.autoApply)
			this.autoApply = false;

		if (this.autoApply && typeof options.ranges !== 'object') {
			this.container.find('.ranges').hide();
		} else if (this.autoApply) {
			this.container.find('.applyBtn, .cancelBtn').addClass('hide');
		}

		if (this.singleDatePicker) {
			this.container.addClass('single');
			this.container.find('.calendar.left').addClass('single');
			this.container.find('.calendar.left').show();
			this.container.find('.calendar.right').hide();
			this.container.find('.daterangepicker_input input, .daterangepicker_input i').hide();
			if (!this.timePicker) {
				this.container.find('.ranges').hide();
			}
		}

		if (typeof options.ranges === 'undefined' && !this.singleDatePicker) {
			this.container.addClass('show-calendar');
		}

		this.container.removeClass('opensleft opensright').addClass('opens' + this.opens);

		//apply CSS classes and labels to buttons
		this.container.find('.applyBtn, .cancelBtn').addClass(this.buttonClasses);
		if (this.applyClass.length)
			this.container.find('.applyBtn').addClass(this.applyClass);
		if (this.cancelClass.length)
			this.container.find('.cancelBtn').addClass(this.cancelClass);
		this.container.find('.applyBtn').html(this.locale.applyLabel);
		this.container.find('.cancelBtn').html(this.locale.cancelLabel);

		//
		// event listeners
		//

		this.container.find('.calendar')
				.on('click.daterangepicker', '.prev', $.proxy(this.clickPrev, this))
				.on('click.daterangepicker', '.next', $.proxy(this.clickNext, this))
				.on('click.daterangepicker', 'td.available', $.proxy(this.clickDate, this))
				.on('mouseenter.daterangepicker', 'td.available', $.proxy(this.hoverDate, this))
				.on('mouseleave.daterangepicker', 'td.available', $.proxy(this.updateFormInputs, this))
				.on('change.daterangepicker', 'select.yearselect', $.proxy(this.monthOrYearChanged, this))
				.on('change.daterangepicker', 'select.monthselect', $.proxy(this.monthOrYearChanged, this))
				.on('change.daterangepicker', 'select.hourselect,select.minuteselect,select.secondselect,select.ampmselect', $.proxy(this.timeChanged, this))
				.on('click.daterangepicker', '.daterangepicker_input input', $.proxy(this.showCalendars, this))
			//.on('keyup.daterangepicker', '.daterangepicker_input input', $.proxy(this.formInputsChanged, this))
				.on('change.daterangepicker', '.daterangepicker_input input', $.proxy(this.formInputsChanged, this));

		this.container.find('.ranges')
				.on('click.daterangepicker', 'button.applyBtn', $.proxy(this.clickApply, this))
				.on('click.daterangepicker', 'button.cancelBtn', $.proxy(this.clickCancel, this))
				.on('click.daterangepicker', 'li', $.proxy(this.clickRange, this))
				.on('mouseenter.daterangepicker', 'li', $.proxy(this.hoverRange, this))
				.on('mouseleave.daterangepicker', 'li', $.proxy(this.updateFormInputs, this));

		if (this.element.is('input')) {
			this.element.on({
				'click.daterangepicker': $.proxy(this.show, this),
				'focus.daterangepicker': $.proxy(this.show, this),
				'keyup.daterangepicker': $.proxy(this.controlChanged, this),
				'keydown.daterangepicker': $.proxy(this.keydown, this)
			});
		} else {
			this.element.on('click.daterangepicker', $.proxy(this.toggle, this));
		}

		//
		// if attached to a text input, set the initial value
		//

		if (this.element.is('input') && !this.singleDatePicker && this.autoUpdateInput) {
			this.element.val(this.startDate.format(this.locale.format) + this.locale.separator + this.endDate.format(this.locale.format));
			this.element.trigger('change');
		} else if (this.element.is('input') && this.autoUpdateInput) {
			this.element.val(this.startDate.format(this.locale.format));
			this.element.trigger('change');
		}

	};

	DateRangePicker.prototype = {

		constructor: DateRangePicker,

		setStartDate: function(startDate) {
			if (typeof startDate === 'string')
				this.startDate = moment(startDate, this.locale.format).utcOffset(this.timeZone);

			if (typeof startDate === 'object')
				this.startDate = moment(startDate);

			if (!this.timePicker)
				this.startDate = this.startDate.startOf('day');

			if (this.timePicker && this.timePickerIncrement)
				this.startDate.minute(Math.round(this.startDate.minute() / this.timePickerIncrement) * this.timePickerIncrement);

			if (this.minDate && this.startDate.isBefore(this.minDate))
				this.startDate = this.minDate;

			if (this.maxDate && this.startDate.isAfter(this.maxDate))
				this.startDate = this.maxDate;

			this.updateMonthsInView();
		},

		setEndDate: function(endDate) {
			if (typeof endDate === 'string')
				this.endDate = moment(endDate, this.locale.format).utcOffset(this.timeZone);

			if (typeof endDate === 'object')
				this.endDate = moment(endDate);

			if (!this.timePicker)
				this.endDate = this.endDate.endOf('day');

			if (this.timePicker && this.timePickerIncrement)
				this.endDate.minute(Math.round(this.endDate.minute() / this.timePickerIncrement) * this.timePickerIncrement);

			if (this.endDate.isBefore(this.startDate))
				this.endDate = this.startDate.clone();

			if (this.maxDate && this.endDate.isAfter(this.maxDate))
				this.endDate = this.maxDate;

			if (this.dateLimit && this.startDate.clone().add(this.dateLimit).isBefore(this.endDate))
				this.endDate = this.startDate.clone().add(this.dateLimit);

			this.updateMonthsInView();
		},

		isInvalidDate: function() {
			return false;
		},

		updateView: function() {
			if (this.timePicker) {
				this.renderTimePicker('left');
				this.renderTimePicker('right');
				if (!this.endDate) {
					this.container.find('.right .calendar-time select').attr('disabled', 'disabled').addClass('disabled');
				} else {
					this.container.find('.right .calendar-time select').removeAttr('disabled').removeClass('disabled');
				}
			}
			if (this.endDate) {
				this.container.find('input[name="daterangepicker_end"]').removeClass('active');
				this.container.find('input[name="daterangepicker_start"]').addClass('active');
			} else {
				this.container.find('input[name="daterangepicker_end"]').addClass('active');
				this.container.find('input[name="daterangepicker_start"]').removeClass('active');
			}
			this.updateMonthsInView();
			this.updateCalendars();
			this.updateFormInputs();
		},

		updateMonthsInView: function() {
			if (this.endDate) {
				this.leftCalendar.month = this.startDate.clone().date(2);
				if (!this.linkedCalendars && (this.endDate.month() != this.startDate.month() || this.endDate.year() != this.startDate.year())) {
					this.rightCalendar.month = this.endDate.clone().date(2);
				} else {
					this.rightCalendar.month = this.startDate.clone().date(2).add(1, 'month');
				}
			} else {
				if (this.leftCalendar.month.format('YYYY-MM') != this.startDate.format('YYYY-MM') && this.rightCalendar.month.format('YYYY-MM') != this.startDate.format('YYYY-MM')) {
					this.leftCalendar.month = this.startDate.clone().date(2);
					this.rightCalendar.month = this.startDate.clone().date(2).add(1, 'month');
				}
			}
		},

		updateCalendars: function() {

			if (this.timePicker) {
				var hour, minute, second;
				if (this.endDate) {
					hour = parseInt(this.container.find('.left .hourselect').val(), 10);
					minute = parseInt(this.container.find('.left .minuteselect').val(), 10);
					second = this.timePickerSeconds ? parseInt(this.container.find('.left .secondselect').val(), 10) : 0;
					if (!this.timePicker24Hour) {
						var ampm = this.container.find('.left .ampmselect').val();
						if (ampm === 'PM' && hour < 12)
							hour += 12;
						if (ampm === 'AM' && hour === 12)
							hour = 0;
					}
				} else {
					hour = parseInt(this.container.find('.right .hourselect').val(), 10);
					minute = parseInt(this.container.find('.right .minuteselect').val(), 10);
					second = this.timePickerSeconds ? parseInt(this.container.find('.right .secondselect').val(), 10) : 0;
					if (!this.timePicker24Hour) {
						var ampm = this.container.find('.left .ampmselect').val();
						if (ampm === 'PM' && hour < 12)
							hour += 12;
						if (ampm === 'AM' && hour === 12)
							hour = 0;
					}
				}
				this.leftCalendar.month.hour(hour).minute(minute).second(second);
				this.rightCalendar.month.hour(hour).minute(minute).second(second);
			}

			this.renderCalendar('left');
			this.renderCalendar('right');

			//highlight any predefined range matching the current start and end dates
			this.container.find('.ranges li').removeClass('active');
			if (this.endDate == null) return;

			var customRange = true;
			var i = 0;
			for (var range in this.ranges) {
				if (this.timePicker) {
					if (this.startDate.isSame(this.ranges[range][0]) && this.endDate.isSame(this.ranges[range][1])) {
						customRange = false;
						this.chosenLabel = this.container.find('.ranges li:eq(' + i + ')').addClass('active').html();
						break;
					}
				} else {
					//ignore times when comparing dates if time picker is not enabled
					if (this.startDate.format('YYYY-MM-DD') == this.ranges[range][0].format('YYYY-MM-DD') && this.endDate.format('YYYY-MM-DD') == this.ranges[range][1].format('YYYY-MM-DD')) {
						customRange = false;
						this.chosenLabel = this.container.find('.ranges li:eq(' + i + ')').addClass('active').html();
						break;
					}
				}
				i++;
			}
			if (customRange) {
				this.chosenLabel = this.container.find('.ranges li:last').addClass('active').html();
				this.showCalendars();
			}

		},

		renderCalendar: function(side) {

			//
			// Build the matrix of dates that will populate the calendar
			//

			var calendar = side == 'left' ? this.leftCalendar : this.rightCalendar;
			var month = calendar.month.month();
			var year = calendar.month.year();
			var hour = calendar.month.hour();
			var minute = calendar.month.minute();
			var second = calendar.month.second();
			var daysInMonth = moment([year, month]).daysInMonth();
			var firstDay = moment([year, month, 1]);
			var lastDay = moment([year, month, daysInMonth]);
			var lastMonth = moment(firstDay).subtract(1, 'month').month();
			var lastYear = moment(firstDay).subtract(1, 'month').year();
			var daysInLastMonth = moment([lastYear, lastMonth]).daysInMonth();
			var dayOfWeek = firstDay.day();

			//initialize a 6 rows x 7 columns array for the calendar
			var calendar = [];
			calendar.firstDay = firstDay;
			calendar.lastDay = lastDay;

			for (var i = 0; i < 6; i++) {
				calendar[i] = [];
			}

			//populate the calendar with date objects
			var startDay = daysInLastMonth - dayOfWeek + this.locale.firstDay + 1;
			if (startDay > daysInLastMonth)
				startDay -= 7;

			if (dayOfWeek == this.locale.firstDay)
				startDay = daysInLastMonth - 6;

			// Possible patch for issue #626 https://github.com/dangrossman/bootstrap-daterangepicker/issues/626
			var curDate = moment([lastYear, lastMonth, startDay, 12, minute, second]).utcOffset(this.timeZone); // .utcOffset(this.timeZone);

			var col, row;
			for (var i = 0, col = 0, row = 0; i < 42; i++, col++, curDate = moment(curDate).add(24, 'hour')) {
				if (i > 0 && col % 7 === 0) {
					col = 0;
					row++;
				}
				calendar[row][col] = curDate.clone().hour(hour).minute(minute).second(second);
				curDate.hour(12);

				if (this.minDate && calendar[row][col].format('YYYY-MM-DD') == this.minDate.format('YYYY-MM-DD') && calendar[row][col].isBefore(this.minDate) && side == 'left') {
					calendar[row][col] = this.minDate.clone();
				}

				if (this.maxDate && calendar[row][col].format('YYYY-MM-DD') == this.maxDate.format('YYYY-MM-DD') && calendar[row][col].isAfter(this.maxDate) && side == 'right') {
					calendar[row][col] = this.maxDate.clone();
				}

			}

			//make the calendar object available to hoverDate/clickDate
			if (side == 'left') {
				this.leftCalendar.calendar = calendar;
			} else {
				this.rightCalendar.calendar = calendar;
			}

			//
			// Display the calendar
			//

			var minDate = side == 'left' ? this.minDate : this.startDate;
			var maxDate = this.maxDate;
			var selected = side == 'left' ? this.startDate : this.endDate;

			var html = '<table class="table-condensed">';
			html += '<thead>';
			html += '<tr>';

			// add empty cell for week number
			if (this.showWeekNumbers)
				html += '<th></th>';

			if ((!minDate || minDate.isBefore(calendar.firstDay)) && (!this.linkedCalendars || side == 'left')) {
				html += '<th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th>';
			} else {
				html += '<th></th>';
			}

			var dateHtml = this.locale.monthNames[calendar[1][1].month()] + calendar[1][1].format(" YYYY");

			if (this.showDropdowns) {
				var currentMonth = calendar[1][1].month();
				var currentYear = calendar[1][1].year();
				var maxYear = (maxDate && maxDate.year()) || (currentYear + 5);
				var minYear = (minDate && minDate.year()) || (currentYear - 50);
				var inMinYear = currentYear == minYear;
				var inMaxYear = currentYear == maxYear;

				var monthHtml = '<select class="monthselect">';
				for (var m = 0; m < 12; m++) {
					if ((!inMinYear || m >= minDate.month()) && (!inMaxYear || m <= maxDate.month())) {
						monthHtml += "<option value='" + m + "'" +
								(m === currentMonth ? " selected='selected'" : "") +
								">" + this.locale.monthNames[m] + "</option>";
					} else {
						monthHtml += "<option value='" + m + "'" +
								(m === currentMonth ? " selected='selected'" : "") +
								" disabled='disabled'>" + this.locale.monthNames[m] + "</option>";
					}
				}
				monthHtml += "</select>";

				var yearHtml = '<select class="yearselect">';
				for (var y = minYear; y <= maxYear; y++) {
					yearHtml += '<option value="' + y + '"' +
							(y === currentYear ? ' selected="selected"' : '') +
							'>' + y + '</option>';
				}
				yearHtml += '</select>';

				dateHtml = monthHtml + yearHtml;
			}

			html += '<th colspan="5" class="month">' + dateHtml + '</th>';
			if ((!maxDate || maxDate.isAfter(calendar.lastDay)) && (!this.linkedCalendars || side == 'right' || this.singleDatePicker)) {
				html += '<th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th>';
			} else {
				html += '<th></th>';
			}

			html += '</tr>';
			html += '<tr>';

			// add week number label
			if (this.showWeekNumbers)
				html += '<th class="week">' + this.locale.weekLabel + '</th>';

			$.each(this.locale.daysOfWeek, function(index, dayOfWeek) {
				html += '<th>' + dayOfWeek + '</th>';
			});

			html += '</tr>';
			html += '</thead>';
			html += '<tbody>';

			//adjust maxDate to reflect the dateLimit setting in order to
			//grey out end dates beyond the dateLimit
			if (this.endDate == null && this.dateLimit) {
				var maxLimit = this.startDate.clone().add(this.dateLimit).endOf('day');
				if (!maxDate || maxLimit.isBefore(maxDate)) {
					maxDate = maxLimit;
				}
			}

			for (var row = 0; row < 6; row++) {
				html += '<tr>';

				// add week number
				if (this.showWeekNumbers)
					html += '<td class="week">' + calendar[row][0].week() + '</td>';

				for (var col = 0; col < 7; col++) {

					var classes = [];

					//highlight today's date
					if (calendar[row][col].isSame(new Date(), "day"))
						classes.push('today');

					//highlight weekends
					if (calendar[row][col].isoWeekday() > 5)
						classes.push('weekend');

					//grey out the dates in other months displayed at beginning and end of this calendar
					if (calendar[row][col].month() != calendar[1][1].month())
						classes.push('off');

					//don't allow selection of dates before the minimum date
					if (this.minDate && calendar[row][col].isBefore(this.minDate, 'day'))
						classes.push('off', 'disabled');

					//don't allow selection of dates after the maximum date
					if (maxDate && calendar[row][col].isAfter(maxDate, 'day'))
						classes.push('off', 'disabled');

					//don't allow selection of date if a custom function decides it's invalid
					if (this.isInvalidDate(calendar[row][col]))
						classes.push('off', 'disabled');

					//highlight the currently selected start date
					if (calendar[row][col].format('YYYY-MM-DD') == this.startDate.format('YYYY-MM-DD'))
						classes.push('active', 'start-date');

					//highlight the currently selected end date
					if (this.endDate != null && calendar[row][col].format('YYYY-MM-DD') == this.endDate.format('YYYY-MM-DD'))
						classes.push('active', 'end-date');

					//highlight dates in-between the selected dates
					if (this.endDate != null && calendar[row][col] > this.startDate && calendar[row][col] < this.endDate)
						classes.push('in-range');

					var cname = '', disabled = false;
					for (var i = 0; i < classes.length; i++) {
						cname += classes[i] + ' ';
						if (classes[i] == 'disabled')
							disabled = true;
					}
					if (!disabled)
						cname += 'available';

					html += '<td class="' + cname.replace(/^\s+|\s+$/g, '') + '" data-title="' + 'r' + row + 'c' + col + '">' + calendar[row][col].date() + '</td>';

				}
				html += '</tr>';
			}

			html += '</tbody>';
			html += '</table>';

			this.container.find('.calendar.' + side + ' .calendar-table').html(html);

		},

		renderTimePicker: function(side) {

			var selected, minDate, maxDate = this.maxDate;

			if (this.dateLimit && (!this.maxDate || this.startDate.clone().add(this.dateLimit).isAfter(this.maxDate)))
				maxDate = this.startDate.clone().add(this.dateLimit);

			if (side == 'left') {
				selected = this.startDate.clone();
				minDate = this.minDate;
			} else if (side == 'right') {
				selected = this.endDate ? this.endDate.clone() : this.startDate.clone();
				minDate = this.startDate;
			}

			//
			// hours
			//

			html = '<select class="hourselect">';

			var start = this.timePicker24Hour ? 0 : 1;
			var end = this.timePicker24Hour ? 23 : 12;

			for (var i = start; i <= end; i++) {
				var i_in_24 = i;
				if (!this.timePicker24Hour)
					i_in_24 = selected.hour() >= 12 ? (i == 12 ? 12 : i + 12) : (i == 12 ? 0 : i);

				var time = selected.clone().hour(i_in_24);
				var disabled = false;
				if (minDate && time.minute(59).isBefore(minDate))
					disabled = true;
				if (maxDate && time.minute(0).isAfter(maxDate))
					disabled = true;

				if (i_in_24 == selected.hour() && !disabled) {
					html += '<option value="' + i + '" selected="selected">' + i + '</option>';
				} else if (disabled) {
					html += '<option value="' + i + '" disabled="disabled" class="disabled">' + i + '</option>';
				} else {
					html += '<option value="' + i + '">' + i + '</option>';
				}
			}

			html += '</select> ';

			//
			// minutes
			//

			html += ': <select class="minuteselect">';

			for (var i = 0; i < 60; i += this.timePickerIncrement) {
				var padded = i < 10 ? '0' + i : i;
				var time = selected.clone().minute(i);

				var disabled = false;
				if (minDate && time.second(59).isBefore(minDate))
					disabled = true;
				if (maxDate && time.second(0).isAfter(maxDate))
					disabled = true;

				if (selected.minute() == i && !disabled) {
					html += '<option value="' + i + '" selected="selected">' + padded + '</option>';
				} else if (disabled) {
					html += '<option value="' + i + '" disabled="disabled" class="disabled">' + padded + '</option>';
				} else {
					html += '<option value="' + i + '">' + padded + '</option>';
				}
			}

			html += '</select> ';

			//
			// seconds
			//

			if (this.timePickerSeconds) {
				html += ': <select class="secondselect">';

				for (var i = 0; i < 60; i++) {
					var padded = i < 10 ? '0' + i : i;
					var time = selected.clone().second(i);

					var disabled = false;
					if (minDate && time.isBefore(minDate))
						disabled = true;
					if (maxDate && time.isAfter(maxDate))
						disabled = true;

					if (selected.second() == i && !disabled) {
						html += '<option value="' + i + '" selected="selected">' + padded + '</option>';
					} else if (disabled) {
						html += '<option value="' + i + '" disabled="disabled" class="disabled">' + padded + '</option>';
					} else {
						html += '<option value="' + i + '">' + padded + '</option>';
					}
				}

				html += '</select> ';
			}

			//
			// AM/PM
			//

			if (!this.timePicker24Hour) {
				html += '<select class="ampmselect">';

				var am_html = '';
				var pm_html = '';

				if (minDate && selected.clone().hour(12).minute(0).second(0).isBefore(minDate))
					am_html = ' disabled="disabled" class="disabled"';

				if (maxDate && selected.clone().hour(0).minute(0).second(0).isAfter(maxDate))
					pm_html = ' disabled="disabled" class="disabled"';

				if (selected.hour() >= 12) {
					html += '<option value="AM"' + am_html + '>AM</option><option value="PM" selected="selected"' + pm_html + '>PM</option>';
				} else {
					html += '<option value="AM" selected="selected"' + am_html + '>AM</option><option value="PM"' + pm_html + '>PM</option>';
				}

				html += '</select>';
			}

			this.container.find('.calendar.' + side + ' .calendar-time div').html(html);

		},

		updateFormInputs: function() {
			this.container.find('input[name=daterangepicker_start]').val(this.startDate.format(this.locale.format));
			if (this.endDate)
				this.container.find('input[name=daterangepicker_end]').val(this.endDate.format(this.locale.format));

			if (this.singleDatePicker || (this.endDate && (this.startDate.isBefore(this.endDate) || this.startDate.isSame(this.endDate)))) {
				this.container.find('button.applyBtn').removeAttr('disabled');
			} else {
				this.container.find('button.applyBtn').attr('disabled', 'disabled');
			}
		},

		move: function() {
			var parentOffset = { top: 0, left: 0 },
					containerTop;
			var parentRightEdge = $(window).width();
			if (!this.parentEl.is('body')) {
				parentOffset = {
					top: this.parentEl.offset().top - this.parentEl.scrollTop(),
					left: this.parentEl.offset().left - this.parentEl.scrollLeft()
				};
				parentRightEdge = this.parentEl[0].clientWidth + this.parentEl.offset().left;
			}

			if (this.drops == 'up')
				containerTop = this.element.offset().top - this.container.outerHeight() - parentOffset.top;
			else
				containerTop = this.element.offset().top + this.element.outerHeight() - parentOffset.top;
			this.container[this.drops == 'up' ? 'addClass' : 'removeClass']('dropup');

			if (this.opens == 'left') {
				this.container.css({
					top: containerTop,
					right: parentRightEdge - this.element.offset().left - this.element.outerWidth(),
					left: 'auto'
				});
				if (this.container.offset().left < 0) {
					this.container.css({
						right: 'auto',
						left: 9
					});
				}
			} else if (this.opens == 'center') {
				this.container.css({
					top: containerTop,
					left: this.element.offset().left - parentOffset.left + this.element.outerWidth() / 2
					- this.container.outerWidth() / 2,
					right: 'auto'
				});
				if (this.container.offset().left < 0) {
					this.container.css({
						right: 'auto',
						left: 9
					});
				}
			} else {
				this.container.css({
					top: containerTop,
					left: this.element.offset().left - parentOffset.left,
					right: 'auto'
				});
				if (this.container.offset().left + this.container.outerWidth() > $(window).width()) {
					this.container.css({
						left: 'auto',
						right: 0
					});
				}
			}
		},

		show: function(e) {
			if (this.isShowing) return;

			// Create a click proxy that is private to this instance of datepicker, for unbinding
			this._outsideClickProxy = $.proxy(function(e) { this.outsideClick(e); }, this);
			// Bind global datepicker mousedown for hiding and
			$(document)
					.on('mousedown.daterangepicker', this._outsideClickProxy)
				// also support mobile devices
					.on('touchend.daterangepicker', this._outsideClickProxy)
				// also explicitly play nice with Bootstrap dropdowns, which stopPropagation when clicking them
					.on('click.daterangepicker', '[data-toggle=dropdown]', this._outsideClickProxy)
				// and also close when focus changes to outside the picker (eg. tabbing between controls)
					.on('focusin.daterangepicker', this._outsideClickProxy);

			this.oldStartDate = this.startDate.clone();
			this.oldEndDate = this.endDate.clone();

			this.updateView();
			this.container.show();
			this.move();
			this.element.trigger('show.daterangepicker', this);
			this.isShowing = true;
		},

		hide: function(e) {
			if (!this.isShowing) return;

			//incomplete date selection, revert to last values
			if (!this.endDate) {
				this.startDate = this.oldStartDate.clone();
				this.endDate = this.oldEndDate.clone();
			}

			//if a new date range was selected, invoke the user callback function
			if (!this.startDate.isSame(this.oldStartDate) || !this.endDate.isSame(this.oldEndDate))
				this.callback(this.startDate, this.endDate, this.chosenLabel);

			//if picker is attached to a text input, update it
			if (this.element.is('input') && !this.singleDatePicker && this.autoUpdateInput) {
				this.element.val(this.startDate.format(this.locale.format) + this.locale.separator + this.endDate.format(this.locale.format));
				this.element.trigger('change');
			} else if (this.element.is('input') && this.autoUpdateInput) {
				this.element.val(this.startDate.format(this.locale.format));
				this.element.trigger('change');
			}

			$(document).off('.daterangepicker');
			this.container.hide();
			this.element.trigger('hide.daterangepicker', this);
			this.isShowing = false;
		},

		toggle: function(e) {
			if (this.isShowing) {
				this.hide();
			} else {
				this.show();
			}
		},

		outsideClick: function(e) {
			var target = $(e.target);
			// if the page is clicked anywhere except within the daterangerpicker/button
			// itself then call this.hide()
			if (
					// ie modal dialog fix
			e.type == "focusin" ||
			target.closest(this.element).length ||
			target.closest(this.container).length ||
			target.closest('.calendar-table').length
			) return;
			this.hide();
		},

		showCalendars: function() {
			this.container.addClass('show-calendar');
			this.move();
			this.element.trigger('showCalendar.daterangepicker', this);
		},

		hideCalendars: function() {
			this.container.removeClass('show-calendar');
			this.element.trigger('hideCalendar.daterangepicker', this);
		},

		hoverRange: function(e) {
			var label = e.target.innerHTML;
			if (label == this.locale.customRangeLabel) {
				this.updateView();
			} else {
				var dates = this.ranges[label];
				this.container.find('input[name=daterangepicker_start]').val(dates[0].format(this.locale.format));
				this.container.find('input[name=daterangepicker_end]').val(dates[1].format(this.locale.format));
			}
		},

		clickRange: function(e) {
			var label = e.target.innerHTML;
			this.chosenLabel = label;
			if (label == this.locale.customRangeLabel) {
				this.showCalendars();
			} else {
				var dates = this.ranges[label];
				this.startDate = dates[0];
				this.endDate = dates[1];

				if (!this.timePicker) {
					this.startDate.startOf('day');
					this.endDate.endOf('day');
				}

				this.hideCalendars();
				this.clickApply();
			}
		},

		clickPrev: function(e) {
			var cal = $(e.target).parents('.calendar');
			if (cal.hasClass('left')) {
				this.leftCalendar.month.subtract(1, 'month');
				if (this.linkedCalendars)
					this.rightCalendar.month.subtract(1, 'month');
			} else {
				this.rightCalendar.month.subtract(1, 'month');
			}
			this.updateCalendars();
		},

		clickNext: function(e) {
			var cal = $(e.target).parents('.calendar');
			if (cal.hasClass('left')) {
				this.leftCalendar.month.add(1, 'month');
			} else {
				this.rightCalendar.month.add(1, 'month');
				if (this.linkedCalendars)
					this.leftCalendar.month.add(1, 'month');
			}
			this.updateCalendars();
		},

		hoverDate: function(e) {

			//ignore dates that can't be selected
			if (!$(e.target).hasClass('available')) return;

			//have the text inputs above calendars reflect the date being hovered over
			var title = $(e.target).attr('data-title');
			var row = title.substr(1, 1);
			var col = title.substr(3, 1);
			var cal = $(e.target).parents('.calendar');
			var date = cal.hasClass('left') ? this.leftCalendar.calendar[row][col] : this.rightCalendar.calendar[row][col];

			if (this.endDate) {
				this.container.find('input[name=daterangepicker_start]').val(date.format(this.locale.format));
			} else {
				this.container.find('input[name=daterangepicker_end]').val(date.format(this.locale.format));
			}

			//highlight the dates between the start date and the date being hovered as a potential end date
			var leftCalendar = this.leftCalendar;
			var rightCalendar = this.rightCalendar;
			var startDate = this.startDate;
			if (!this.endDate) {
				this.container.find('.calendar td').each(function(index, el) {

					//skip week numbers, only look at dates
					if ($(el).hasClass('week')) return;

					var title = $(el).attr('data-title');
					var row = title.substr(1, 1);
					var col = title.substr(3, 1);
					var cal = $(el).parents('.calendar');
					var dt = cal.hasClass('left') ? leftCalendar.calendar[row][col] : rightCalendar.calendar[row][col];

					if (dt.isAfter(startDate) && dt.isBefore(date)) {
						$(el).addClass('in-range');
					} else {
						$(el).removeClass('in-range');
					}

				});
			}

		},

		clickDate: function(e) {

			if (!$(e.target).hasClass('available')) return;

			var title = $(e.target).attr('data-title');
			var row = title.substr(1, 1);
			var col = title.substr(3, 1);
			var cal = $(e.target).parents('.calendar');
			var date = cal.hasClass('left') ? this.leftCalendar.calendar[row][col] : this.rightCalendar.calendar[row][col];

			//
			// this function needs to do a few things:
			// * alternate between selecting a start and end date for the range,
			// * if the time picker is enabled, apply the hour/minute/second from the select boxes to the clicked date
			// * if autoapply is enabled, and an end date was chosen, apply the selection
			// * if single date picker mode, and time picker isn't enabled, apply the selection immediately
			//

			if (this.endDate || date.isBefore(this.startDate)) {
				if (this.timePicker) {
					var hour = parseInt(this.container.find('.left .hourselect').val(), 10);
					if (!this.timePicker24Hour) {
						var ampm = cal.find('.ampmselect').val();
						if (ampm === 'PM' && hour < 12)
							hour += 12;
						if (ampm === 'AM' && hour === 12)
							hour = 0;
					}
					var minute = parseInt(this.container.find('.left .minuteselect').val(), 10);
					var second = this.timePickerSeconds ? parseInt(this.container.find('.left .secondselect').val(), 10) : 0;
					date = date.clone().hour(hour).minute(minute).second(second);
				}
				this.endDate = null;
				this.setStartDate(date.clone());
			} else {
				if (this.timePicker) {
					var hour = parseInt(this.container.find('.right .hourselect').val(), 10);
					if (!this.timePicker24Hour) {
						var ampm = this.container.find('.right .ampmselect').val();
						if (ampm === 'PM' && hour < 12)
							hour += 12;
						if (ampm === 'AM' && hour === 12)
							hour = 0;
					}
					var minute = parseInt(this.container.find('.right .minuteselect').val(), 10);
					var second = this.timePickerSeconds ? parseInt(this.container.find('.right .secondselect').val(), 10) : 0;
					date = date.clone().hour(hour).minute(minute).second(second);
				}
				this.setEndDate(date.clone());
				if (this.autoApply)
					this.clickApply();
			}

			if (this.singleDatePicker) {
				this.setEndDate(this.startDate);
				if (!this.timePicker)
					this.clickApply();
			}

			this.updateView();

		},

		clickApply: function(e) {
			this.hide();
			this.element.trigger('apply.daterangepicker', this);
		},

		clickCancel: function(e) {
			this.startDate = this.oldStartDate;
			this.endDate = this.oldEndDate;
			this.hide();
			this.element.trigger('cancel.daterangepicker', this);
		},

		monthOrYearChanged: function(e) {
			var isLeft = $(e.target).closest('.calendar').hasClass('left'),
					leftOrRight = isLeft ? 'left' : 'right',
					cal = this.container.find('.calendar.'+leftOrRight);

			// Month must be Number for new moment versions
			var month = parseInt(cal.find('.monthselect').val(), 10);
			var year = cal.find('.yearselect').val();

			if (!isLeft) {
				if (year < this.startDate.year() || (year == this.startDate.year() && month < this.startDate.month())) {
					month = this.startDate.month();
					year = this.startDate.year();
				}
			}

			if (this.minDate) {
				if (year < this.minDate.year() || (year == this.minDate.year() && month < this.minDate.month())) {
					month = this.minDate.month();
					year = this.minDate.year();
				}
			}

			if (this.maxDate) {
				if (year > this.maxDate.year() || (year == this.maxDate.year() && month > this.maxDate.month())) {
					month = this.maxDate.month();
					year = this.maxDate.year();
				}
			}

			if (isLeft) {
				this.leftCalendar.month.month(month).year(year);
				if (this.linkedCalendars)
					this.rightCalendar.month = this.leftCalendar.month.clone().add(1, 'month');
			} else {
				this.rightCalendar.month.month(month).year(year);
				if (this.linkedCalendars)
					this.leftCalendar.month = this.rightCalendar.month.clone().subtract(1, 'month');
			}
			this.updateCalendars();
		},

		timeChanged: function(e) {

			var cal = $(e.target).closest('.calendar'),
					isLeft = cal.hasClass('left');

			var hour = parseInt(cal.find('.hourselect').val(), 10);
			var minute = parseInt(cal.find('.minuteselect').val(), 10);
			var second = this.timePickerSeconds ? parseInt(cal.find('.secondselect').val(), 10) : 0;

			if (!this.timePicker24Hour) {
				var ampm = cal.find('.ampmselect').val();
				if (ampm === 'PM' && hour < 12)
					hour += 12;
				if (ampm === 'AM' && hour === 12)
					hour = 0;
			}

			if (isLeft) {
				var start = this.startDate.clone();
				start.hour(hour);
				start.minute(minute);
				start.second(second);
				this.setStartDate(start);
				if (this.singleDatePicker)
					this.endDate = this.startDate.clone();
			} else if (this.endDate) {
				var end = this.endDate.clone();
				end.hour(hour);
				end.minute(minute);
				end.second(second);
				this.setEndDate(end);
			}

			//update the calendars so all clickable dates reflect the new time component
			this.updateCalendars();

			//update the form inputs above the calendars with the new time
			this.updateFormInputs();

			//re-render the time pickers because changing one selection can affect what's enabled in another
			this.renderTimePicker('left');
			this.renderTimePicker('right');

		},

		formInputsChanged: function(e) {
			var isRight = $(e.target).closest('.calendar').hasClass('right');
			var start = moment(this.container.find('input[name="daterangepicker_start"]').val(), this.locale.format).utcOffset(this.timeZone);
			var end = moment(this.container.find('input[name="daterangepicker_end"]').val(), this.locale.format).utcOffset(this.timeZone);

			if (start.isValid() && end.isValid()) {

				if (isRight && end.isBefore(start))
					start = end.clone();

				this.setStartDate(start);
				this.setEndDate(end);

				if (isRight) {
					this.container.find('input[name="daterangepicker_start"]').val(this.startDate.format(this.locale.format));
				} else {
					this.container.find('input[name="daterangepicker_end"]').val(this.endDate.format(this.locale.format));
				}

			}

			this.updateCalendars();
			if (this.timePicker) {
				this.renderTimePicker('left');
				this.renderTimePicker('right');
			}
		},

		controlChanged: function() {
			if (!this.element.is('input')) return;
			if (!this.element.val().length) return;

			var dateString = this.element.val().split(this.locale.separator),
					start = null,
					end = null;

			if (dateString.length === 2) {
				start = moment(dateString[0], this.locale.format).utcOffset(this.timeZone);
				end = moment(dateString[1], this.locale.format).utcOffset(this.timeZone);
			}

			if (this.singleDatePicker || start === null || end === null) {
				start = moment(this.element.val(), this.locale.format).utcOffset(this.timeZone);
				end = start;
			}

			this.setStartDate(start);
			this.setEndDate(end);
			this.updateView();
		},

		keydown: function(e) {
			//hide on tab or enter
			if ((e.keyCode === 9) || (e.keyCode === 13)) {
				this.hide();
			}
		},

		remove: function() {
			this.container.remove();
			this.element.off('.daterangepicker');
			this.element.removeData();
		}

	};

	$.fn.daterangepicker = function(options, callback) {
		this.each(function() {
			var el = $(this);
			if (el.data('daterangepicker'))
				el.data('daterangepicker').remove();
			el.data('daterangepicker', new DateRangePicker(el, options, callback));
		});
		return this;
	};

}));