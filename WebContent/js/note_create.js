// JavaScript Document


/*****************************
 *          个人页面            *
 *****************************/
function enterMyFileType(user_id, notetype, fileType) {
	$("#userPage_id").val(user_id);
	$("#userPage_notetype").val(notetype);
	$("#userPage_notebook").val(fileType);
	$("#userPageForm").attr("action", "note_user");
	$("#userPageForm").submit();
}

// will cause encoding issue
function enterMyFileTypeByGet(user_id, notetype, fileType) {
	jumpPage("note_user?id=" + user_id + "&notetype=" + notetype+ "&notebook=" + fileType);
}

function jumpPage(url) {
	location.href=encodeURI(url);
}


/*****************************
 *          文集标签            *
 *****************************/


// 未应用
function strlen(str){ //汉字两个字符长度，英文字母一个字符长度 
	var len = 0;  
	for (var i=0; i<str.length; i++) {   
		var c = str.charCodeAt(i);
		//单字节加1
		if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
			len++;
		}
		else {
			len+=2;
		}
	}
	return len;  
} 

//删除左右两端的空格  
function trim(str){ 
    return str.replace(/(^\s*)|(\s*$)/g, "");  
}

//删除左边的空格  
function ltrim(str){ 
    return str.replace(/(^\s*)/g,"");  
}  

//删除右边的空格  
function rtrim(str){ 
    return str.replace(/(\s*$)/g,"");  
}

//div居中
(function ($) { 
	  $.fn.center = function (settings) {
	    var style = $.extend({
	      position: 'absolute', //absolute or fixed
	      top     : '50%', //50%即居中，将应用负边距计算，溢出不予考虑了。
	      left    : '50%',
	      zIndex  : 2009,
	      relative: true //相对于包含它的容器居中还是整个页面
	    }, settings || {});

	    return this.each(function () {
	      var $this = $(this);

	      if (style.top == '50%') style.marginTop = -$this.outerHeight() / 2;
	      if (style.left == '50%') style.marginLeft = -$this.outerWidth() / 2;
	      if (style.relative && !$this.parent().is('body') && $this.parent().css('position') == 'static') $this.parent().css('position', 'relative');
	      delete style.relative;
	      //ie6
	      if (style.position == 'fixed' && $.browser.version == '6.0') {
	        style.marginTop += $(window).scrollTop();
	        style.position = 'absolute';
	        $(window).scroll(function () {
	          $this.stop().animate({
	            marginTop: $(window).scrollTop() - $this.outerHeight() / 2
	          });
	        });
	      }

	      $this.css(style);
	    });
	  };
	})(jQuery);


/*****************************
 *         笔记新建操作          *
 *****************************/
//新建笔记
function onCreate() {
	//var last_page = encodeURIComponent(document.location);
	document.location = "note_create";//?last_page=" + last_page;
}

// 编辑笔记
function onEdit(id) {
	//var last_page = encodeURIComponent(document.location);
	//alert(last_page);
	document.location = "note_edit?id=" + id; //+ "&last_page=" + last_page;
}

// 提交新建、编辑笔记
function review_submit() {
	var isbn = document.getElementById("isbn").value;
	var content = HTMLEnCode(document.getElementById("content_div").contentDocument.body.innerHTML);
	if(isbn == ""){
		alert("请输入标题");
	} else if(content == ""){
		alert("请输入笔记内容");
	} else{
		document.getElementById("draftSet").value = "0";	// cancel draft status
		document.getElementById("content").value = content;
		document.getElementById("createReview_form").submit();
	}
}

// 自动保存草稿
function review_auto_draft() {
	var content = HTMLEnCode(document.getElementById("content_div").contentDocument.body.innerHTML);
	if (content != "") {
		review_draft(2);
		var d = new Date();
		var YMDHMS = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
				+ d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":"
				+ d.getSeconds();
		$("#draft_prompt").html("该文草稿已于 " + YMDHMS + "自动保存");
	}
}

// 保存草稿
function review_draft(draftSet){
	if (draftSet == null) draftSet = 1;
	var content = HTMLEnCode(document.getElementById("content_div").contentDocument.body.innerHTML);
	 if(content == ""){
		alert("请输入笔记内容");
	}else{
		document.getElementById("content").value = content;
		document.getElementById("draftSet").value = draftSet;
		document.getElementById("createReview_form").submit();
	}
}

// 取消新建、编辑笔记
function review_cancel(){
	location.href = document.referrer;
	//parent.location.reload();
}

//ajax实现自动保存
var xmlHttpRequest;
function createXMLHttpRequest(){
	if(window.ActiveXObject){
		xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xmlHttpRequest = new XMLHttpRequest() ;
	}
}

function review_auto_draft_ajax(){
	//alert("ajax function!");
	var review_id = document.getElementById("review_id").value;
	var user_id = document.getElementById("user_id").value;
	var isbn = document.getElementById("isbn").value;
	var content = HTMLEnCode(document.getElementById("content_div").contentDocument.body.innerHTML);

	if(content != null && content != ""){
		var url = "review_auto_draft?review_id=" + review_id + "&user_id=" + user_id 
			+ "&isbn=" + isbn + "&content=" + content;
		
	    createXMLHttpRequest();
	    xmlHttpRequest.open("GET", url, true);
	    xmlHttpRequest.onreadystatechange = function(){
	    	if(xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200){
	            var b = xmlHttpRequest.responseText;
	            if(b != "-1"){
		            document.getElementById("review_id").value = b;
		            alert("自动保存成功！review_id = "+b);
		            document.getElementById("header_draft_box").innerHTML = "<font style='font-weight:bold;'>草稿箱(新)</font>";
	    		}
	        }
	    };
	    xmlHttpRequest.send(null);
	}
}

/*function onEdit_OLD(review_id) {
	var content = document.getElementById("content").value;
	if (content)
		document.getElementById("content_div").contentDocument.body.innerHTML = content;
	//var tag = document.getElementById("tagValue").value;	
	//var filetype = document.getElementById("filetypeValue").value;	
	//var authority = document.getElementById("authorityValue").value;
}*/

/*****************************
 *          格式编辑器           *
 *****************************/
//初始化编辑器
function init(div_name, content) {
	var ifr = document.getElementById(div_name);
	var doc = ifr.contentDocument || ifr.contentWindow.document; // W3C || IE
	doc.designMode="on";
	doc.contentEditable= true;
	doc.write('<html><head><style>body{ margin:3px; word-wrap:break-word; word-break: break-all; font-size: 14px; line-height: 22px; }</style></head><body></body></html>');
	if (content) doc.body.innerHTML = content;
}
  
//设置选定的文本为粗体/正常
function setBold(div_name) {
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("Bold",false, null);
	win.focus();
}
  
//设置选定的文本为斜体/正常
function setItalic(div_name) {
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("Italic",false, null);
	win.focus();
}
  
//设置选定的文本有下划线
function setUnderline(div_name) {
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("Underline", false, null);
	win.focus();
}

//设置选定的文本字号
function setFontSize(div_name, size) {
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("fontsize", false, size);
	win.focus();
}

//设置选定的文本的颜色
function setFontColor(div_name, colorSelect) {
	var color = colorSelect.val();
	colorSelect.css('color',color);
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("ForeColor",false,color); 
	win.focus();
}

//设置选定的文本的背景色
function setBackColor(div_name, colorSelect) {
	var color = colorSelect.val();
	colorSelect.css('background-color',color);
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("BackColor",false,color); 
	win.focus();
}

//设置选定的文本的字体
function setFontStyle(div_name, fontname) {
	var win=document.getElementById(div_name).contentWindow;
	win.document.execCommand("FontName",false,fontname);
	win.focus();
}

function    HTMLEnCode(str)   
{   
      var    s    =    "";   
      if    (str.length    ==    0)    return    "";   
      s    =    str.replace(/&/g,    "&gt;");   
      s    =    s.replace(/</g,        "&lt;");   
      s    =    s.replace(/>/g,        "&gt;");   
      s    =    s.replace(/    /g,     "&nbsp;");   
      s    =    s.replace(/\'/g,      "'");   
      s    =    s.replace(/\"/g,      "&quot;");   
      s    =    s.replace(/\n/g,      "<br>");   
      return    s;   
}

function    HTMLDeCode(str)   
{   
      var    s    =    "";   
      if    (str.length    ==    0)    return    "";   
      s    =    str.replace(/&gt;/g,    "&");   
      s    =    s.replace(/&lt;/g,        "<");   
      s    =    s.replace(/&gt;/g,        ">");   
      s    =    s.replace(/&nbsp;/g,        "    ");   
      s    =    s.replace(/'/g,      "\'");   
      s    =    s.replace(/&quot;/g,      "\"");   
      s    =    s.replace(/<br>/g,      "\n");   
      return    s;   
}
