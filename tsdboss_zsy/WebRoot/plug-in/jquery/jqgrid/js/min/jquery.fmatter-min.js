/*
**
 * Formatter for values but most of the values if for jqGrid
 * Joshua Burnett josh@9ci.com	
 * http://www.greenbill.com
 */
;(function(c){c.fmatter={};c.fn.fmatter=function(d,e,b,f){b=c.extend({},c.jgrid.formatter,b);return this.each(function(){$this=c(this);var a=c.meta?c.extend({},b,$this.data()):b;z($this,d,e,b,f)})};c.fmatter.util={NumberFormat:function(a,d){if(!isNumber(a)){a*=1}if(isNumber(a)){var e=(a<0);var b=a+"";var f=(d.decimalSeparator)?d.decimalSeparator:".";var g;if(isNumber(d.decimalPlaces)){var h=d.decimalPlaces;var m=Math.pow(10,h);b=Math.round(a*m)/m+"";g=b.lastIndexOf(".");if(h>0){if(g<0){b+=f;g=b.length-1}else if(f!=="."){b=b.replace(".",f)}while((b.length-1-g)<h){b+="0"}}}if(d.thousandsSeparator){var l=d.thousandsSeparator;g=b.lastIndexOf(f);g=(g>-1)?g:b.length;var i=b.substring(g);var k=-1;for(var j=g;j>0;j--){k++;if((k%3===0)&&(j!==g)&&(!e||(j>1))){i=l+i}i=b.charAt(j-1)+i}b=i}b=(d.prefix)?d.prefix+b:b;b=(d.suffix)?b+d.suffix:b;return b}else{return a}},DateFormat:function(e,b,f,g){var h=/\\.|[dDjlNSwzWFmMntLoYyaABgGhHisueIOPTZcrU]/g,m=/\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,l=l=/[^-+\dA-Z]/g,i=function(a,d){a=String(a);d=parseInt(d)||2;while(a.length<d)a='0'+a;return a},k={m:1,d:1,y:1970,h:0,i:0,s:0},j=0,n=["i18n"];n["i18n"]={dayNames:g.dayNames,monthNames:g.monthNames};e=e.toLowerCase();b=b.split(/[\\\/:_;.\s-]/);e=e.split(/[\\\/:_;.\s-]/);for(var o=0;o<e.length;o++){k[e[o]]=parseInt(b[o],10)}k.m=parseInt(k.m)-1;var s=k.y;if(s>=70&&s<=99)k.y=1900+k.y;else if(s>=0&&s<=69)k.y=2000+k.y;j=new Date(k.y,k.m,k.d,k.h,k.i,k.s,0);if(g.masks.newformat){f=g.masks.newformat}else if(!f){f='Y-m-d'}var p=j.getHours(),o=j.getMinutes(),t=j.getDate(),q=j.getMonth()+1,w=j.getTimezoneOffset(),A=j.getSeconds(),B=j.getMilliseconds(),u=j.getDay(),r=j.getFullYear(),v=(u+6)%7+1,x=(new Date(r,q-1,t)-new Date(r,0,1))/86400000,y={d:i(t),D:n.i18n.dayNames[u],j:t,l:n.i18n.dayNames[u+7],N:v,S:g.S(t),w:u,z:x,W:v<5?Math.floor((x+v-1)/7)+1:Math.floor((x+v-1)/7)||((new Date(r-1,0,1).getDay()+6)%7<4?53:52),F:n.i18n.monthNames[q-1+12],m:i(q),M:n.i18n.monthNames[q-1],n:q,t:'?',L:'?',o:'?',Y:r,y:String(r).substring(2),a:p<12?g.AmPm[0]:g.AmPm[1],A:p<12?g.AmPm[2]:g.AmPm[3],B:'?',g:p%12||12,G:p,h:i(p%12||12),H:i(p),i:i(o),s:i(A),u:B,e:'?',I:'?',O:(w>0?"-":"+")+i(Math.floor(Math.abs(w)/60)*100+Math.abs(w)%60,4),P:'?',T:(String(j).match(m)||[""]).pop().replace(l,""),Z:'?',c:'?',r:'?',U:Math.floor(j/1000)};return f.replace(h,function(a){return a in y?y[a]:a.substring(1)})}};c.fn.fmatter.defaultFormat=function(a,d,e){c(a).html((isValue(d)&&d!=="")?d:"&#160;")};c.fn.fmatter.email=function(a,d,e){if(!isEmpty(d)){c(a).html("<a href=\"mailto:"+d+"\">"+d+"</a>")}else{c.fn.fmatter.defaultFormat(a,d)}};c.fn.fmatter.checkbox=function(a,d,e){d=d+"";d=d.toLowerCase();var b=d.search(/(false|0|no|off)/i)<0?" checked=\"checked\"":"";c(a).html("<input type=\"checkbox\""+b+" value=\""+d+"\" offval=\"no\" disabled/>")},c.fn.fmatter.link=function(a,d,e){if(!isEmpty(d)){c(a).html("<a href=\""+d+"\">"+d+"</a>")}else{c(a).html(isValue(d)?d:"")}};c.fn.fmatter.showlink=function(a,d,e){var b={baseLinkUrl:e.baseLinkUrl,showAction:e.showAction};if(e.colModel.formatoptions){b=c.extend({},b,e.colModel.formatoptions||{})}idUrl=b.baseLinkUrl+b.showAction+'?id='+e.rowId;if(isString(d)){c(a).html("<a href=\""+idUrl+"\">"+d+"</a>")}else{c.fn.fmatter.defaultFormat(a,d)}};c.fn.fmatter.integer=function(a,d,e){var b=e.integer;if(e.colModel.formatoptions){b=c.extend({},b,e.colModel.formatoptions||{})}if(isEmpty(d)){d=b.defaultValue||0}c(a).html(c.fmatter.util.NumberFormat(d,b))};c.fn.fmatter.number=function(a,d,e){var b=e.number;if(e.colModel.formatoptions){b=c.extend({},b,e.colModel.formatoptions||{})}if(isEmpty(d)){d=b.defaultValue||0}c(a).html(c.fmatter.util.NumberFormat(d,b))};c.fn.fmatter.currency=function(a,d,e){var b=e.currency;if(e.colModel.formatoptions){b=c.extend({},b,e.colModel.formatoptions||{})}if(isEmpty(d)){d=b.defaultValue||0}c(a).html(c.fmatter.util.NumberFormat(d,b))};c.fn.fmatter.date=function(a,d,e,b){var f=e.date;if(e.colModel.formatoptions){f=c.extend({},f,e.colModel.formatoptions||{})}if(!f.reformatAfterEdit&&b=='edit'){c.fn.fmatter.defaultFormat(a,d)}else if(!isEmpty(d)){var g=c.fmatter.util.DateFormat(f.srcformat,d,f.newformat,f);c(a).html(g)}else{c.fn.fmatter.defaultFormat(a,d)}};c.fn.fmatter.select=function(e,b,f,g){if(g=='edit'){c.fn.fmatter.defaultFormat(e,b)}else if(!isEmpty(b)){var h=f.colModel.editoptions.value;if(h){var m=[];var l=f.colModel.editoptions.multiple===true?true:false;var i=[];if(l){i=b.split(",");i=c.map(i,function(a){return c.trim(a)})}if(isString(h)){var k=h.split(";"),j=0;for(var n=0;n<k.length;n++){sv=k[n].split(":");if(l){if(jQuery.inArray(sv[0],i)>-1){m[j]=sv[1];j++}}else if(c.trim(sv[0])==c.trim(b)){m[0]=sv[1];break}}}else if(isObject(h)){if(l){m=jQuery.map(scel,function(a,d){return h[a]})}m[0]=h[b]||""}c(e).html(m.join(", "))}else{c.fn.fmatter.defaultFormat(e,b)}}};c.unformat=function(a,d,e,b){var f,g=d.colModel.formatter,h=d.colModel.formatoptions||{};if(g!=='undefined'&&isString(g)){var m=c.jgrid.formatter||{},l;switch(g){case'link':case'showlink':case'email':f=c(a).text();break;case'integer':h=c.extend({},m.integer,h);l=eval("/"+h.thousandsSeparator+"/g");f=c(a).text().replace(l,'');break;case'number':h=c.extend({},m.number,h);l=eval("/"+h.thousandsSeparator+"/g");f=c(a).text().replace(h.decimalSeparator,'.').replace(l,"");break;case'currency':h=c.extend({},m.currency,h);l=eval("/"+h.thousandsSeparator+"/g");f=c(a).text().replace(h.decimalSeparator,'.').replace(h.prefix,'').replace(h.suffix,'').replace(l,'');break;case'checkbox':var i=(d.colModel.editoptions)?d.colModel.editoptions.value.split(":"):["Yes","No"];f=c('input',a).attr("checked")?i[0]:i[1];break}}return f?f:b===true?c(a).text():c.htmlDecode(c(a).html())};function z(a,d,e,b,f){d=d.toLowerCase();switch(d){case'link':c.fn.fmatter.link(a,e,b);break;case'showlink':c.fn.fmatter.showlink(a,e,b);break;case'email':c.fn.fmatter.email(a,e,b);break;case'currency':c.fn.fmatter.currency(a,e,b);break;case'date':c.fn.fmatter.date(a,e,b,f);break;case'number':c.fn.fmatter.number(a,e,b);break;case'integer':c.fn.fmatter.integer(a,e,b);break;case'checkbox':c.fn.fmatter.checkbox(a,e,b);break;case'select':c.fn.fmatter.select(a,e,b,f);break}};function C(a){if(window.console&&window.console.log)window.console.log(a)};isValue=function(a){return(isObject(a)||isString(a)||isNumber(a)||isBoolean(a))};isBoolean=function(a){return typeof a==='boolean'};isNull=function(a){return a===null};isNumber=function(a){return typeof a==='number'&&isFinite(a)};isString=function(a){return typeof a==='string'};isEmpty=function(a){if(!isString(a)&&isValue(a)){return false}else if(!isValue(a)){return true}a=c.trim(a).replace(/\&nbsp\;/ig,'').replace(/\&#160\;/ig,'');return a===""};isUndefined=function(a){return typeof a==='undefined'};isObject=function(a){return(a&&(typeof a==='object'||isFunction(a)))||false};isFunction=function(a){return typeof a==='function'}})(jQuery);