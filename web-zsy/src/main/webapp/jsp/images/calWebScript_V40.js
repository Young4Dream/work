isMac = (navigator.appVersion.indexOf("Mac")!=-1) ? true : false;
NS4 = (document.layers) ? true : false;
IEmac = ((document.all)&&(isMac)) ? true : false;
IE4plus = (document.all) ? true : false;
IE4 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 4.")!=-1)) ? true : false;
IE6 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 6.")!=-1)) ? true : false;
NS6plus = (!document.layers) && (navigator.userAgent.indexOf('Netscape')!=-1)?true:false;
var myArgs = null;
var appType;
var generalErrorCallType  ="alert";

// function to go to a specific view
function go2()
{
	// set the group ID, if it's group calendar
	if (arguments.length < 2)  
		arguments[1] = 0;
	if (arguments[1] != 0)
		var grpidStr="&grpid=" + arguments[1];
	else
		var grpidStr="";
	
	var view = new Array();
	view["d"] = "day";
	view["w"] = "week";
	view["m"] = "month";
	view["y"] = "year";

	viewID = arguments[0];
	location="/calendar/isapi.dll?calendarView=" + view[viewID] + grpidStr;
};

// function to go to a specifc day view
function go2DV()
{
	// set the group ID, if it's group calendar
	if (arguments.length < 4)  
		arguments[3] = 0;
	if (arguments[3] != 0)
		var grpidStr="&grpid=" + arguments[3];
	else
		var grpidStr="";
	
	var URL = "/calendar/isapi.dll?calendarView=day&day=" + arguments[0] + "&month=" + arguments[1] + "&year=" + arguments[2] + grpidStr;
	location = URL;
};

// start add/edit date/time scripts
var fromDay, fromMonth, fromYear, toDay, toMonth, toYear, fromNumDays, toNumDays, fromRecurrDay;
function initDateTimeDrops()
{
	if ((IE4plus) && (calFrm.itemAllDay.checked==false))
	{
		var testArray2 = new Array(2,document.all.starttime, document.all.endDateTime);
		Toggle(testArray2);
	}
	if (calFrm.itemSubjectLong.type != 'hidden')
	calFrm.itemSubjectLong.focus();
	
	// set the number of days in the start date drop-downs
	resetDropPointers("from",calFrm.itemStartDateDay,calFrm.itemStartDateMonth,calFrm.itemStartDateYear);
	resetDropPointers("to",calFrm.itemStartDateDay,calFrm.itemStartDateMonth,calFrm.itemStartDateYear);
	fromNumDays = calFrm.itemStartDateDay.length;
	toNumDays = getnDaysInMonth(toMonth,toYear);
	displayDays(calFrm.itemStartDateDay);
	
	// set the number of days in the end date drop-downs
	resetDropPointers("from", calFrm.itemEndDateDay,calFrm.itemEndDateMonth,calFrm.itemEndDateYear);
	resetDropPointers("to", calFrm.itemEndDateDay,calFrm.itemEndDateMonth,calFrm.itemEndDateYear);
	fromNumDays = calFrm.itemEndDateDay.length;
	toNumDays = getnDaysInMonth(toMonth, toYear);
	displayDays(calFrm.itemEndDateDay);
	
	/// set the number of days in the recurrence drop-downs
	if ((typeof(calFrm.recurrenceEndDateDay)!='undefined')&&(typeof(calFrm.recurrenceEndDateDay.selectedIndex)!='undefined'))
	{
		resetDropPointers("from", calFrm.recurrenceEndDateDay,calFrm.recurrenceEndDateMonth,calFrm.recurrenceEndDateYear);
		resetDropPointers("to", calFrm.recurrenceEndDateDay,calFrm.recurrenceEndDateMonth,calFrm.recurrenceEndDateYear);
		fromNumDays = calFrm.recurrenceEndDateDay.length;
		toNumDays = getnDaysInMonth(toMonth, toYear);
		displayDays(calFrm.recurrenceEndDateDay);
	}
}

var nDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var nDaysInLeapMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
function getnDaysInMonth(monthNo, p_year) {
	if ((p_year % 4) == 0) {
			if ((p_year % 100) == 0 && (p_year % 400) != 0)
					return nDaysInMonth[monthNo];

			return nDaysInLeapMonth[monthNo];
	} else
			return nDaysInMonth[monthNo];
}

var stopSyncDate = false;	// Fixed bug 56500
var stopSyncTime = false;
function resetDropPointers(type, dayDrop, monthDrop, yearDrop)
{
	if (type=='from')
	{
		fromDay = dayDrop.options[dayDrop.selectedIndex].value;
		fromMonth = monthDrop.options[monthDrop.selectedIndex].value;
		fromYear = yearDrop.options[yearDrop.selectedIndex].value;
	}
	else if (type=='to')
	{
		toDay = dayDrop.options[dayDrop.selectedIndex].value;
		toMonth = monthDrop.options[monthDrop.selectedIndex].value;
		toYear = yearDrop.options[yearDrop.selectedIndex].value;
	}
}
function doTheDays(objDay, objMonth, objYear, ignore)
{
	resetDropPointers("to",objDay,objMonth,objYear);
	fromNumDays = getnDaysInMonth(fromMonth,fromYear);
	toNumDays = getnDaysInMonth(toMonth,toYear);
	displayDays(objDay);
	if ( (objDay.name.indexOf('itemEnd') != -1) && (typeof(ignore)== 'undefined') ) 	// Fixed bug 56500
		stopSyncDate = true;
	if (!stopSyncDate)
	{
		resetDropPointers("from", calFrm.itemEndDateDay,calFrm.itemEndDateMonth,calFrm.itemEndDateYear);
		displayDays(calFrm.itemEndDateDay);
	}	
	resetDropPointers("from",objDay,objMonth,objYear);
	syncEndDT(hDuration,minDuration);
}
function displayDays(objDay)
{
	if(fromNumDays>toNumDays)
	{	//remove
		for (var i=0; i<(fromNumDays-toNumDays); i++)
			objDay.length--;
		if(fromDay>toNumDays)
			objDay.options[toNumDays-1].selected=true;
	}else
	{	//add
		for (var i=0; i<(toNumDays-fromNumDays); i++)
		{			
			if (fromNumDays+i+1 == 29)
				objDay.options[fromNumDays+i]=new Option(day29,fromNumDays+i+1);
			else
			if (fromNumDays+i+1 == 30)
				objDay.options[fromNumDays+i]=new Option(day30,fromNumDays+i+1);
			else
			if (fromNumDays+i+1 == 31)
				objDay.options[fromNumDays+i]=new Option(day31,fromNumDays+i+1);
		}
	}
}

function reminderAllDayStat()
{	(calFrm.itemAllDay.checked)?calFrm.uicode1.value='addreminderTrue':calFrm.uicode1.value='addreminderFalse'; }

function noDays(startObj,endObj,timeType) {
  document.theForm.itemAllDay.checked = false;
  var newEndIndex = startObj.selectedIndex;
  if (timeType=='start' && (!stopSyncTime)){
	syncEndDT(hDuration,minDuration);
  	}	
  if (timeType=='end')
	stopSyncTime = true;
 // Cal 5.1 - marekg - What did this even do? It doesn't look used anymore and it's breaking groups menu bar.
//   reminderAllDayStat();
}
// end add/edit date/time scripts

// Function below will return rOjb.left and rObj.top positions of the Obj) 
function getXY(Obj) 
{
	for (var sumTop=0,sumLeft=0;Obj!=document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
	return {left:sumLeft,top:sumTop}
}

function toolBtnrollOver(theObj)
{
	if (theObj.className=="rollOveroff")
	theObj.className='rollOver';
	else
	theObj.className='rollOveroff';
}

//  Blank input validation
function isBlank(obj)
{
	if (obj=="")
		return true;
	else
		return false;
}

function selectCheckBox(dropBox, theBox)
{

// Cal 5.1 - bug #105375 - we no longer have ------ so we don't need to uncheck checkboxes
//	if (dropBox[0].selected)
//		theBox.checked = 0;
//	else
		theBox.checked = 1;
}

function highlightTR(elem){ 
	if (NS4) return;

    if (IE4plus)
    {
        while (elem.tagName!="TR")
        {elem=elem.parentElement;}
    }
    else
    {
        while (elem.tagName!="TR")
        {elem=elem.parentNode;}
    }
    elem.className = "H";
} 

function unhighlightTR(elem){
	if (NS4) return;

    if (IE4plus)
    {
        while (elem.tagName!="TR")
        {elem=elem.parentElement;}
    }
    else
    {
        while (elem.tagName!="TR")
        {elem=elem.parentNode;}
    }
    elem.className = "";
}

function doCheckBox(srcForm, srcObj)
{
	if (srcObj.checked)
		highlightTR(srcObj);
	else
		unhighlightTR(srcObj);
	
	if (srcObj.name == 'allbox')
		var allBx = true;
	var TB=TO=0;
	for (var i=0;i<srcForm.elements.length;i++)
	{
		var e = srcForm.elements[i];
		if (e.type=='checkbox')
		{
			if (e.name != 'allbox')
			{
				TB++;
				if (e.checked)
					TO++;
			}
			if (allBx)
			{
				e.checked = srcForm.allbox.checked;
				if (e.checked)
					highlightTR(e);
				else
					unhighlightTR(e);
			}
		}
	}
	if (!allBx)
	{
		if (TO==TB)
			srcForm.allbox.checked=true;
		else
			srcForm.allbox.checked=false;
	}
}

function Toggle(sectionArray) 
{ 	
	// scare off underqualified browsers
	if (sectionArray[0])
		{
		for (var i = 1; i < sectionArray.length; i++) {
			if (sectionArray[i].style.visibility == "hidden") {
				(sectionArray[i].style.visibility = "visible");
			}
			else {
				(sectionArray[i].style.visibility = "hidden");
			}
		}
	}
}

function showHide(sectionArray)
{
	if (sectionArray[0])
		{
		for (var i = 1; i < sectionArray.length; i++) {
			if (sectionArray[i].style.visibility == "hidden") {
				(sectionArray[i].style.visibility = "visible");
			}
			else {
				(sectionArray[i].style.visibility = "hidden");
			}
		}
	}
}

var newwin;
function DateSelector(dateMonth, dateYear, elementSectionName)
{
	var filename = ('/calendar/isapi.dll?request=date&elementSectionName=' + 
					elementSectionName + 
					'&month=' + dateMonth + 
					'&year=' + dateYear);
	newwin=window.open(filename,
		'mincalwin', 'WIDTH=175,HEIGHT=240,RESIZABLE=yes,SCROLLBARS=no,STATUS=0');
	if (newwin != null)
	{
		if (newwin.opener == null)
			newwin.opener = self;
	}
	newwin.focus();
}

function FormSubmit(theOperation)
{
	document.theForm.operation.value = theOperation;
	document.theForm.submit();
}

function Confirmation(theOperation, confirmText, noneSelectedText)
{
	if (noneSelectedText)
	{
		if (!CheckIfSelected())
		{
			ShowAlertMsg(noneSelectedText);
			return;
		}
	}
	ShowConfirmMsg(confirmText, 'FormSubmit\(\"' + theOperation + '\")');
}

function CheckIfSelected()
{
	var chkTrack = false;
	for (var i=0;i<document.theForm.elements.length;i++)
	{
		var f = document.theForm.elements[i];
		if ((f.type=='checkbox') && (f.checked) && (f.name != 'allbox'))
			chkTrack = true;
	}
	return chkTrack;
		
}

function Validate(action)
{	
	var errorstring = L_CannotBeAdded_Text + lineBreak;
	var tempValue = document.theForm.itemSubjectLong.value;
	var allSpaces = true;
	for (var si=0; si<tempValue.length; si++)
	{
		if (tempValue.charAt(si) != ' ')
			allSpaces = false;
	}
	if (document.theForm.itemSubjectLong.value == "" || allSpaces)
	{
		errorstring = L_CannotBeAdded_Text + lineBreak + L_DescriptionMissing_Text + lineBreak;
		SetFocus();
		ShowAlertMsg(errorstring);
	}
	else
	{
		document.theForm.operation.value = action;
		document.theForm.submit();
	}					
}

// This method is supposed to be called on a form submit and not on a button click
function ValidateSubject()
{	
	var errorstring = L_CannotBeAdded_Text + lineBreak;
	var tempValue = document.theForm.itemSubjectLong.value;
	var allSpaces = true;
	for (var si=0; si<tempValue.length; si++)
	{
		if (tempValue.charAt(si) != ' ')
			allSpaces = false;
	}
	if (document.theForm.itemSubjectLong.value == "" || allSpaces)
	{
		errorstring = L_CannotBeAdded_Text + lineBreak + L_DescriptionMissing_Text + lineBreak;
		SetFocus();
		ShowAlertMsg(errorstring);
		return false;
	}
	else
	{
		return true;
	}					
}

// Should have a better method of validating different fields. Putting it here for now.
function ValidateSharingUserName()
{	
	var tempValue = document.theForm.sharingUserName.value;
	var allSpaces = true;
	for (var si=0; si<tempValue.length; si++)
	{
		if (tempValue.charAt(si) != ' ')
			allSpaces = false;
	}
	if (document.theForm.sharingUserName.value == "" || allSpaces)
	{
		errorstring = L_NameFieldEmpty_Text + lineBreak;
		SetFocusSharingUserName();
		ShowAlertMsg(errorstring);
		return false;
	}
	else
	{
		return true;
	}					
}

function SetFocus() 
{
	if (document.theForm.itemSubjectLong.type != 'hidden')
		document.theForm.itemSubjectLong.focus();

	document.theForm.itemSubjectLong.select();
}

function SetFocusSharingUserName() 
{
	document.theForm.sharingUserName.focus();
	document.theForm.sharingUserName.select();
}

function Concat(Obj,len)
{
	if (Obj.innerText.length>len)
	{
		// since this is a client side blocked simulate it like server side to expose the inline error link
		isPostBack = true;
		Obj.innerText=Obj.innerText.substring(0,len);
		ShowAlertMsg(L_TextAreaExceeded);
		isPostBack = false;
	}
}

// User message script spans the following 5 functions.  Complete documentation in tech spec VOB.
var grpID="0";
var strError = "";
var lineBreak = '<br><br>';
var alertObj;
var confObj;
var objHandle;
var globalRetVal = false;

function UserMsgObject(theMsgString, confAction, modalURL, mWinF, newWinF, bttnTxtArr, PickerEmails, cGifURL)
{
	if (theMsgString)
		this.msgString = theMsgString;
	if (!modalURL) // should i add a case for modal confirm
		this.modalURL = "/user/isapi.dll?gtr=g_standard_modal_alert&grpid=" + grpID;
	else
		this.modalURL = modalURL;
	if (!mWinF)
		this.modalWinFormat = "dialogWidth:375px;dialogHeight:330px;help:0;scroll:0;status:0";
	else
		this.modalWinFormat = mWinF;
	if (!newWinF)
		this.newWinFormat = "resizable=no,width=375,height=330";
	else
		this.newWinFormat = newWinF;
	if (!confAction)
		this.confTypeAction = false;
	else
		this.confTypeAction = confAction;
	if (bttnTxtArr)
		this.bttnTxt = bttnTxtArr;
	// for addess picker call.
	if (PickerEmails)
		this.to = PickerEmails;
	else
		this.to = "";
	if (cGifURL)
		this.cGif = cGifURL;
			
	this.OpenModalWin = OpenModalWin;
}
function setVars(_msgString, _returnAction, _winURL, _modalFormat, _newWinFormat, _bArr, _PickerVals, _cGif)
{
	myArgs = arguments; 
}
function getVars(){
	return myArgs;
}
function TurnOffStyle(tagName)
{
	var tag = document.getElementsByName(tagName);
	if(tag)
		{
			for(var i = 0; i < tag.length ; i++)
			{
				tag[i].removeAttribute("className", true);
			}
		}
	return;
}
function TurnOnStyle(tagName)
{
	if(appType)
	{
		if(appType == "groups")
			TurnOnGroupStyle();
		if(appType == "messenger")
			TurnOnMessengerStyle();
	}
	var tag = document.getElementById(tagName);
	if(tag)
		tag.style.display = "block";	
	return;
}
function TurnOnMessengerStyle()
{
	var tagTable = document.getElementById("eTableWrap");
	if(tagTable)
		tagTable.bgcolor="#336699";
	return;
}
function TurnOnGroupStyle()
{
	// different formatting for groups
	var tagTable = document.getElementById("eTableWrap");
	if(tagTable)
		tagTable.bgcolor="#CCCCE5";
	tagTable = document.getElementById("eTable")
	if(tagTable)
		tagTable.width ="100%"; 
	return;
}
// the following functions provide the "public" interfaces for UI developers.  These can be expanded for 
// different class of modal windows--windows that use the same set of properties.
function ShowAlertMsg(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif)
{
	generalErrorCallType  = "alert";
	if (isPostBack && isPostBack== true){
		setVars(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif);
		TurnOnStyle("eTag");
		isPostBack = false;
	}else{
		var currentVars = getVars();
		if (currentVars){
			if(typeof(msgString) == "undefined")

			{
				msgString = currentVars[0];
				returnAction = currentVars[1];
				winURL = currentVars[2];
				modalFormat = currentVars[3],
				newWinFormat = currentVars[4],
				bArr = currentVars[5];
				PickerVals = currentVars[6];
				cGif = currentVars[7];
			}		
		}
		currentVars = null;
		confObj = new UserMsgObject(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif);
		confObj.OpenModalWin(false);
	}		
	}

function ShowConfirmMsg(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif)
{
	generalErrorCallType  = "confirmation";
	if (isPostBack && isPostBack== true){
		setVars(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif);
		TurnOnStyle("eTag");
		isPostBack = false;
	}else{
		var currentVars = getVars();
		if (currentVars){
			if(typeof(msgString) == "undefined")

			{
				msgString = currentVars[0];
				returnAction = currentVars[1];
				winURL = currentVars[2];
				modalFormat = currentVars[3],
				newWinFormat = currentVars[4],
				bArr = currentVars[5];
				PickerVals = currentVars[6];
				cGif = currentVars[7];
			}		
		}
		currentVars = null;
		
	confObj = new UserMsgObject(msgString, returnAction, winURL, modalFormat, newWinFormat, bArr, PickerVals, cGif);
	confObj.OpenModalWin(true); // true means a return action is required (like a confirmation box).
		}
}

function GeneralErrorCallType()
{
	if(generalErrorCallType == "confirmation")
		ShowConfirmMsg();
	else
		ShowAlertMsg();

}

function OpenModalWin(isConf)
{
	if (this)
	{
		if ((IE4plus) && (!isMac))
		{
			var retVal = window.showModalDialog(this.modalURL + "&uicode3=" + isConf + "&rand=" + Math.round(Math.random()*1000000), this, this.modalWinFormat);
			if (retVal && isConf)
			{
				ModalReturnAction(retVal)
				globalRetVal=true;
			}
		}
		else
		{
				objHandle = this;
				confObj.win = window.open(this.modalURL + "&uicode3=" + isConf + "&rand=" + Math.round(Math.random()*1000000), "", this.newWinFormat);
		}
	}
}

function ModalReturnAction(theAction)
{
	if (typeof theAction == "object")
	{
		for(i=0;i<theAction.length;i++)
		{
			eval(theAction[i]);
		}
	}
	else
		eval(theAction);
}


function blockEvents() 
{
  if (agent_isNS) {
     window.captureEvents(Event.CLICK | Event.MOUSEDOWN | Event.MOUSEUP | Event.FOCUS)
     window.onclick = deadEnd
   }
   window.onfocus = checkModal
}


function unblockEvents() {
   if (agent_isNS) {
      window.releaseEvents(Event.CLICK | Event.MOUSEDOWN | Event.MOUSEUP | Event.FOCUS)
      window.onclick = null
      window.onfocus = null
   }
}


function deadEnd() {
   if (confObj.win && !confObj.win.closed) {
     confObj.win.focus()
     return false
   }
}


function checkModal() {
    if (confObj.win && !confObj.win.closed) {
       confObj.win.focus()	
    }
}


function CheckAll(theForm)
{
	for (var i=0;i<theForm.elements.length;i++)
	{
		var e = theForm.elements[i];
		if (e.name != 'allbox')
		e.checked = theForm.allbox.checked;
	}
}

var alphaChars = "abcdefghijklmnopqrstuvwxyz";
var digitChars = "0123456789";
var asciiChars = alphaChars + digitChars + "!\"#$%&'()*+,-./:;<=>?@[\]^_`{}~";
function ValidateEmail(str)
{
var ret = 'false';
	if (typeof(str) != "undefined")
	{
		if (/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/.test(str))
			ret = str;
	}
	return ret;
}
function ValidateLooseEmail(str){
var resultStr = str.replace(/ /gi, "");
var atIndex   = resultStr.indexOf("@");
var dotIndex  = resultStr.lastIndexOf(".");
	if( resultStr == "" || !isASCII(resultStr) || dotIndex == -1)
		return "";
	if ( resultStr.lastIndexOf("@") != atIndex || resultStr.charAt(atIndex+1) == ".")
		return "";
	if ( atIndex <= 0 || dotIndex < atIndex ||  dotIndex >= resultStr.length-1)
		return "";
	return resultStr;
}
function isEmail(str) {
  var pass = 0;
  if (window.RegExp) {
    var tempStr = "a";
    var tempReg = new RegExp(tempStr);
	if (tempReg.test(tempStr)) pass = 1;
	}
	if (!pass)
		return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
	var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
	var r2 = new RegExp("^[a-zA-Z0-9\\.\\!\\#\\$\\%\\&\\'\\*\\+\\-\\/\\=\\?\\^\\_\\`\\{\\}\\~]*[a-zA-Z0-9\\!\\#\\$\\%\\&\\'\\*\\+\\-\\/\\=\\?\\^\\_\\`\\{\\}\\~]\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
	return (!r1.test(str) && r2.test(str));
}
function isASCII(str){
var v_len = str.length;
var i;
	for (i = 0; i < v_len; i++)
	{
	if (asciiChars.indexOf(str.charAt(i)) == -1)
		return false;
	}
	return true;
}
function doAnchor(obj)
{
	if (obj.value=='0')
		obj.value = 1;
	else
		obj.value = 0;
	document.theForm.submit();
}
function printPreview(s)
{
	newWin = window.open(s,'printable');
	newWin.focus();
}

function doNewAppt(param1, param2, param3)
{
	if (param1=='allday')
	{
		document.theForm.uicode2.value="allday";
	}
	else if (param3=='null')
	{
		document.theForm.hour.value = param1;
		document.theForm.minute.value= param2;
	}
	else
	{
		document.theForm.day.value = param1;
		document.theForm.month.value = param2;
		document.theForm.year.value = param3;
	}
	document.theForm.request.value="view";
	document.theForm.operation.value="new";
	document.theForm.uicode1.value="addappointment";
	document.theForm.submit();
}

 function editAppt(id)
{
	location.href="/calendar/isapi.dll?request=view&operation=modify&uicode1=modifyappointment&objectID="+id;
}	
//  New funcs. for date/time sync on Edit page
function isMilitaryTime(hObj)
{
	if (hObj.length >12)	return true;
	else	return false;
}
function indexOfValue(obj,cmpTxt,cmpType)// returns index of the text (cmpTxt) of a select objest (obj)
{
	var i = 0
	for (var li=0; li<obj.length; li++)
	{
		if (cmpType=='value')
		{
			if (obj.options[li].value == cmpTxt)
				i = li;
		}else
		{
			if (obj.options[li].text == cmpTxt)
				i = li;
		}
	}
	return i;
}
function resetStartIndex()
{
    startYear = document.theForm.itemStartDateYear[document.theForm.itemStartDateYear.selectedIndex].value;
    startMonth = document.theForm.itemStartDateMonth[document.theForm.itemStartDateMonth.selectedIndex].value;
    startDay = document.theForm.itemStartDateDay[document.theForm.itemStartDateDay.selectedIndex].value;
    startHour = parseInt(document.theForm.formHourNumber[document.theForm.formHourNumber.selectedIndex].text, 10);
    startMinute = parseInt(document.theForm.formMinuteNumber[document.theForm.formMinuteNumber.selectedIndex].text, 10);

 	if (!isMilitaryTime(document.theForm.formHourNumber))
	{
		var startAmPm = document.theForm.formAmpm.value;	//	AM=0, PM=1
		var tmp = startHour;
  
		if (startAmPm==0){ 
			if(startHour ==12 )
				startHour = 0;
		}	
		else{
			if (startHour < 12)  
				startHour += 12;   		
		}
		
        }
        return;
}
function syncEndDT(noOfHours,noOfMinutes) {
  if (!stopSyncDate && !stopSyncTime)
  {
    resetStartIndex();
    var newStartDate = new Date(startYear,startMonth,startDay,parseInt(startHour, 10) , parseInt(startMinute, 10));
    var newEnddate = new Date(newStartDate);
    newEnddate.setMinutes(newEnddate.getMinutes() + apptDurationMin);

    var endYear = newEnddate.getFullYear();
    var endMonth = newEnddate.getMonth();
    var endDay = newEnddate.getDate();
    var endHour = newEnddate.getHours();
    var endMinute = newEnddate.getMinutes();

	
	if (!isMilitaryTime(document.theForm.formHourNumber))
	{
		var endAmPm = (endHour<12)?0:1;
		endHour = (endAmPm==0)?endHour:(endHour-12);
		document.theForm.formEndAmpm.selectedIndex = endAmPm;
	}
    document.theForm.itemEndDateYear.selectedIndex = indexOfValue(document.theForm.itemEndDateYear,endYear,'value');
    document.theForm.itemEndDateMonth.selectedIndex = indexOfValue(document.theForm.itemEndDateMonth,endMonth,'value');
    document.theForm.itemEndDateDay.selectedIndex = indexOfValue(document.theForm.itemEndDateDay,endDay,'value');
    document.theForm.formEndHourNumber.selectedIndex = indexOfValue(document.theForm.formEndHourNumber,endHour,'text');
    document.theForm.formEndMinuteNumber.selectedIndex = indexOfValue(document.theForm.formEndMinuteNumber,endMinute,'text');
    if (!isMilitaryTime(document.theForm.formHourNumber))
		document.theForm.formEndAmpm.selectedIndex = endAmPm;
  }
}
//  END new funcs. for date/time sync on Edit page

var MenuObjList = new Array(); // used to track current instances.
function MenuObj(sInstanceName, sDiv, sRefTD, sDropTD, sBttnOn, sBttnOff, sBttnActive, sFrameID)
{
	this.name = sInstanceName;
	this.bttnOn = sBttnOn;
	this.bttnOff = sBttnOff;
	this.bttnActive = sBttnActive;
	this.SetBttnStyle = SetBttnStyle;
	this.showing = false;
	this.ToggleMenu = ToggleMenu;
	document.onclick = MenuClickHandler;
	MenuObjList[MenuObjList.length]=this;


	if (NS4)
	{
		this.divObj = eval('document.' + sDiv);
		this.divStyleObj = eval('document.' + sDiv);
		this.refTDObj = eval('document.' +  sRefTD);
		if (sDropTD)
			this.DdTDObj = eval('document.' +  sDropTD);
		this.strShow = 'show';
		this.strHide = 'hide';
	}
	else
	{
		if (IE4plus)
		{
			this.divObj = eval('document.all.' + sDiv);
			this.divStyleObj = eval('document.all.' + sDiv + '.style');
			this.refTDObj = eval('document.all.' + sRefTD);
			if (sDropTD)
				this.DdTDObj = eval('document.all.' +  sDropTD);
			this.frmObj = eval('document.all.' +  sFrameID);
		}
		else
		{
			this.divObj = eval('document.getElementById("' + sDiv + '")');
			this.divStyleObj = eval('document.getElementById("' + sDiv + '").style');
			this.refTDObj = eval('document.getElementById("' + sRefTD + '")');
			if (sDropTD)
				this.DdTDObj = eval('document.getElementById("' + sDropTD + '")');
			this.frmObj = eval('document.getElementById("' + sFrameID + '")');
		}
		this.strShow = 'visible';
		this.strHide = 'hidden';
	}
}

// this guy makes it possible to have multiple menus on in one page instance, but could
// also be used globally to reset a pointer to an object by passing in a new object, or a string
// representation.
function ResetObjPointer(ObjRef)
{
	var theObj = null;
	if (ObjRef)
	{
		if (typeof ObjRef != 'object')
			theObj = eval(ObjRef);
		else
			theObj = ObjRef;
		return theObj;
	}
	else
	return false;
}

function ToggleMenu()
{
	if (!this.showing)
	{
		if (NS4) 
		{
			this.divStyleObj.top = this.refTDObj.y + 25;
			this.divStyleObj.left = this.refTDObj.x;
		}
		else
		{
			var RelObjCords = getXY(this.refTDObj);
			
			//added by t-ischen Aug 23,2005
			//because the menubar height in kahuna calendar is 9 pixels larger than wave 10 type, so when kahuna,
			//we should accordingly adjust the location where the menu is toggled 
			var MenuRelDown =18;
			if(KahunaToggleMenu && KahunaToggleMenu == 1)
			    MenuRelDown =27;
			
			//originally RelObjCords.top + 18, now RelObjCords.top + MenuRelDown;   --- t-ischen
			if (!isMac)
			{
				this.divStyleObj.top = this.frmObj.style.top = RelObjCords.top + MenuRelDown;
			}
			//originally RelObjCords.top + 18-35, now RelObjCords.top + MenuRelDown-35; --- t-ischen
			else
			{
				// For some strange reason placement of the menubar in IE 5.2 for MAC is not correct
				// So putting this hack here
				
				// when kahuna, we don't need the hack mentioned above --- t-ischen
				if(KahunaToggleMenu && KahunaToggleMenu == 1)
				    this.divStyleObj.top = this.frmObj.style.top = RelObjCords.top + MenuRelDown;
				else
    				this.divStyleObj.top = this.frmObj.style.top = RelObjCords.top + MenuRelDown - 35;
			}
			this.divStyleObj.left = this.frmObj.style.left = RelObjCords.left;

			this.divStyleObj.position = "absolute";

			this.frmObj.style.height=this.divObj.offsetHeight;
			this.frmObj.style.width=this.divObj.offsetWidth;
		}
		var pCurrMenuObj = ResetObjPointer(this);
		this.SetBttnStyle('clicked');
		// this.divStyleObj.visibility = this.frmObj.style.visibility = this.strShow;
		this.divStyleObj.visibility =  this.strShow;
		this.showing = true;
	}
	else
	{
		this.divStyleObj.visibility = this.frmObj.style.visibility = this.strHide;
		this.showing = false;
		this.SetBttnStyle();
	}
}


function CloseMenus(callerObj)
{
	for (aIndex = 0;aIndex < MenuObjList.length; aIndex++)
	{
		if (MenuObjList[aIndex].showing)
		{
			MenuObjList[aIndex].ToggleMenu();
			MenuObjList[aIndex].SetBttnStyle();
		}

	}
}




function MenuClickHandler(e, srcObj, srcIsMenuDiv)
{
	var srcElem;
	if (!e)
		var e = window.event;
	e.cancelBubble = true;
	if (NS4)
		document.releaseEvents(Event.MOUSEDOWN);
	if (srcObj) 
	{
		var pCurrMenuObj = ResetObjPointer(srcObj);	                
		pCurrMenuObj.ToggleMenu();		
	}
	else
		CloseMenus();
}


function MenuMouseEvents(e, srcObj)
{
	if (!e) 
		var e = window.event;
	var pCurrMenuObj = ResetObjPointer(srcObj);
	if (!pCurrMenuObj.showing)
	{
		if (e.type == 'mouseover')
			pCurrMenuObj.SetBttnStyle('on');
		else if ((e.type == 'mouseout') || (e.type == 'blur'))
			pCurrMenuObj.SetBttnStyle();
	}
}

function SetBttnStyle(whichStyle)
{
	if (!NS4)
	{
		if (typeof this.refTDObj != "undefined")
		{
			if (whichStyle == 'on')
			{
				if (this.bttnOn)
				{
					if (typeof this.DdTDObj != "undefined")
						this.DdTDObj.className = this.bttnOn;
					this.refTDObj.className = this.bttnOn;
				}
			}
			else if (whichStyle == 'clicked')
			{
				if (this.bttnActive)
				{
					if (typeof this.DdTDObj != "undefined")
						this.DdTDObj.className = this.bttnActive;
					this.refTDObj.className = this.bttnActive;
				}
			}
			else
			{
				if (this.bttnOff)
				{
					if (typeof this.DdTDObj != "undefined")
						this.DdTDObj.className = this.bttnOff;
					this.refTDObj.className = this.bttnOff;
				}
			}
		}
	}
}
function G(strURL)
{
   if(strURL)
       location.href=strURL;
}

function G_hotmail(strURL)
{
   if(strURL)
       parent.location.href=strURL;
}

function doRecurrModal(theA,recurrStr, bypassModal)
{
	if (!bypassModal)
	{
		if ((IE4plus) && (!isMac))
		{
			ShowConfirmMsg(recurrStr, true);
			if (globalRetVal)
			{
				theA.href += "&uicode3=" + document.theForm.openSeries.value;
				if (document.theForm.openSeries.value == 'series')
					theA.href += "&modifyRecurrence=all";
			}
			else
				return false;
		}
		else
		{
			var strHrefAction = "location.href = '" + theA.href + "&uicode3=' + document.theForm.openSeries.value";
			ShowConfirmMsg(recurrStr, strHrefAction);
			return false;
		}
	}
	else
	{
		// for recurring exceptions and invitee viewing recurrence
		if (bypassModal == 'none')
			theA.href += "&uicode3=none";
		else
			theA.href += "&uicode3=series";
	}
}

// next 3 funcs for address picker.
function DoHL()
{
var e = window.event.srcElement;
while (e.tagName!="TR")
{e=e.parentElement;}
if (e.className!='SL')
e.className='HL';
}
function DoLL()
{
var e = window.event.srcElement;
while (e.tagName!="TR")
{e=e.parentElement;}
if (e.className!='SL')
e.className='';
}
function DoSL()
{
var TheTable = e = window.event.srcElement;
while (TheTable.tagName!="TABLE")
{TheTable=TheTable.parentElement;}
for (var i=0;i<TheTable.rows.length;i++)
{
TheTable.rows[i].className='';
}
while (e.tagName!="TR")
{e=e.parentElement;}
e.className='SL';
}

String.prototype.trim = function() {

// skip leading and trailing whitespace
// and return everything in between
  var x=this;
  x=x.replace(/^\s+/, "");
  x=x.replace(/\s+$/, "");
  return x;
}

String.prototype.compact = function() {
// replacing multiple whitespace in the middle of the string 
// with a single whitespace
  var x=this;
  var tmp = x;
  x=x.replace(/[ ]\s+/, " ");
  if (x == tmp)
  {
  	return x;
  }
  else 
  {
  	// I have to call it again since for some reason replace method is replacing only the first occurance 
  	return x.compact();
  }
}

function xMessUrl(aCollection, sProp) 
{

      for(var i = 0; i < aCollection.length; i++)
	  // added /86 for Bug 139896 since all weather g-links are /86 for messenger only do not append querystring members
         if (aCollection[i][sProp].indexOf("mailto:") == -1 && aCollection[i][sProp].indexOf("javascript:") == -1)
	  {
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "messenger", 1);
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "mdsh", window.parent['frmControl'].mdsh);		
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "mdeh", window.parent['frmControl'].mdeh);	
 		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "mwsd", window.parent['frmControl'].mwsd);	
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "mtz", window.parent['frmControl'].mtz);	
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "sharingAddress", window.parent.GetRemoteEmailAddress());	
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "locale", window.parent['frmControl'].locale);		
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "day", todayDayView );		
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "month", todayMonthView );		
		 aCollection[i][sProp] = AddParam(aCollection[i][sProp], "year", todayYearView );		
	 }
 }

 function FixMessengerUrl()
 {
	 if (document.links)  xMessUrl(document.links, "href");
 	 if (document.forms)  xMessUrl(document.forms, "action");
 }

function hrefRewrite(url, o)
{
	o.href= url;
	return;
}

function ReplaceParam(p_strSrc, p_name, p_value)
{
	var tmp = RemoveParam(p_strSrc, p_name);
	return AddParam(tmp, p_name, p_value);
}
function RemoveParam(p_strSrc, p_name)
{
	var tmp = p_name+"="; 
	var pos = -1;
	if ((pos = p_strSrc.indexOf(tmp)) < 0 )  return(p_strSrc);

	var b = p_strSrc.substr(0, pos-1);
	var a = p_strSrc.substr(pos);
	if (a.indexOf("&") < 0)
		return b;
	b += a.substring(a.indexOf("&") );
	return b; 
	
}

function AddParam(p_strSrc, p_name, p_value)
{
	if (p_strSrc)
	{
		var tmp = p_name+"="; 
		if (p_strSrc.indexOf(tmp) >= 0) return(p_strSrc);
	
		var strParam = p_name + "=" + p_value;

		if (p_strSrc.indexOf("?") == -1)
		{
			return(p_strSrc + "?" + strParam);
		}
		else
		{
			return(p_strSrc += "&" + strParam);
		}
	}
	return(p_strSrc);
}

function HtmlDecode(text)
{
    return text.replace(/&amp;/g, '&').replace(/&gt;/g, '>').replace(/&lt;/g, '<').replace(/&quot;/g, '\"').replace(/&#039;/g, '\'');
}


function DoTooltip(o,name, subject, location)
{
	if (o.target == "complete")
		return;
	var tmp = ""; 	

	for(var i =1; i<arguments.length ; i++)
	{
		if(arguments[i]  && arguments[i] != "")
			tmp += HtmlDecode(arguments[i])  + "\n"
	}
	o.title = tmp + o.title; 
	o.target = "complete"
	return;
}
