<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>笔者列表</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/author_show.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <div class="mainwrapper">
	    <div class="mainbody">
	    	<h2 class="title">笔者&middot;荐</h2>
	    	<div class="authorshow">
		    	<div class="authorlist">
		    		<ul><c:forEach var="user" items="${users}">
			    		<li class="authoritem">
							<div class="userpic">
								<a href="note_user?id=${user.user_id }&notetype=self&notebook=all"><img src="images/head/head1.jpg" /></a>
							</div>
							<div class="userinfo">
								<p class="username">
									<a href="note_user?id=${user.user_id }&notetype=self&notebook=all">${user.name}</a>
								</p>
								<p class="newnote">最新文章：</p>
								<div class="newnotelist">
									<ul>
										<li class="newnoteitme">
											<a href="">wenzhang1</a>
											<span>2013-3-3</span>
										</li>
										<li class="newnoteitme">
											<a href="">wenzhang2</a>
											<span>2013-3-2</span>
										</li>
										<li class="newnoteitme">
											<a href="">wenzhang3</a>
											<span>2013-3-1</span>
										</li>
									</ul>
								</div>
							</div>
						</li>
					</c:forEach></ul>
		       </div>
		       	<div style="clear: both;"></div>
			</div>
	    </div>
	</div>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
</body>
</html>
