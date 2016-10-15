//信息提示框的脚本
function tips_pop()
{
    var MsgPop = document.getElementById("winpop");
    var popH = parseInt(MsgPop.style.height);
    //将对象的高度转化为数字
    if (popH == 0) {
        MsgPop.style.display = "block";
        //显示隐藏的窗口
        show = setInterval("changeH('up')", 2);
    }
    else {
        hide = setInterval("changeH('down')", 2);
    }
}
function changeH(str) 
{
    var MsgPop = document.getElementById("winpop");
    var popH = parseInt(MsgPop.style.height);
    if (str == "up")
    {
        if (popH <= 140) {
            MsgPop.style.height = (popH + 4).toString() + "px";
        }
        else {
            clearInterval(show);
        }
    }
    if (str == "down")
    {
        if (popH >= 4) {
            MsgPop.style.height = (popH - 4).toString() + "px";
        }
        else {
            clearInterval(hide);
            MsgPop.style.display = "none";//隐藏DIV
        }
    }
}	
//页面跳转
function jumpPage(pagename){
	if (!pagename || pagename == "#") {
		return;
	}
	$("#main-frame").attr('src', 'mainServlet.html?pagename=' + pagename + '&tsdtemp=' + Math.random());
}

//执行页面跳转
function exeServlet(nid)
{
    var params = 'right-temp.jsp?thisflag=true&nid=' + nid;
    jumpPage(params);
}
//跳转提示
function disJumpInfo()
{
    var disnoticesarr = $('#disnoticearr').val();
    var disno = $('#disno').text();
    jumpPage('rights.jsp?disno=' + disno + '&disnoticesarr=' + disnoticesarr);
}	
//此功能暂未开放，稍后开放
function tsdBossHelp(){
	alert('资料整理中，稍后开放!');
}
