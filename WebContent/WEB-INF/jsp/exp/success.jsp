<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- saved from url=(0060)http://www.csszengarden.com/?cssfile=/209/209.css&amp;page=0 -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>操作结果</title>
	
	<script language="javascript">	
		function refreshMain() {
			var page = '${page}';
			if (page != '') {
				parent.location = page;	
			} else {
				parent.location.reload();		
			}		
		}
	</script>
</head>

<body>
<body marginwidth="0" marginheight="0">
	<div id="login">
		<div id="errHolder_1" class="err_holder">${msg }</div>		
	</div>
</body>
</html>

<script>
	var alert1 = '${alert}';
	console.log(alert1);
	if (alert1 == '1') {
		alert('${msg}');
	}
	var refresh = '${refresh}';
	console.log(refresh);
	if (refresh != '0') {
		setInterval(refreshMain, 300);		
	}
	var callback = "${callback}";
	console.log(callback);
	if (callback != "") {
		eval(callback);
	}
</script>