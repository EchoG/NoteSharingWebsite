<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>
		草稿箱
	</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/note_draft.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_edit.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <div class="mainwrapper">
	    <div class="mainbody">
	    	<h2 class="title">${me.name }的草稿箱</h2>
	    	<div class="noteshow">
	    		<%@ include file="/WEB-INF/jsp/inc/note_list.jsp"%>
	    		<div style="clear: both;"></div>
			</div>
	    </div>
	</div>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
</body>
</html>
