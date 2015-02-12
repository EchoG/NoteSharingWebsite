<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>
		笔记列表
	</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/note_show.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/header.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_edit.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <div class="mainwrapper">
	    <div class="mainbody">
	    	<h2 class="title">
	    	<!-- 
	    		<c:if test="${menu eq 'main' }">笔记&middot;新</c:if>
	    		<c:if test="${menu eq 'note_recmd' }">笔记&middot;荐</c:if>
	    	 -->
	    	 	笔记&middot;荐
	    	</h2>
	    	<div class="noteshow">
	    		<%@ include file="/WEB-INF/jsp/inc/note_list.jsp"%>
		       	<div class="tagsider">
					<div class="taglist">
						<ul>
							<li <c:if test="${empty tag || tag eq 'all' }">class="current"</c:if>>
								<a href="javascript:void(0);" onclick="show_notes('all')">全部(${countAll })</a>
							</li>
						    <c:forEach var="tag_vo" items="${tags}">  
								<li <c:if test="${tag eq tag_vo.tag }">class="current"</c:if>>
									<a href="javascript:void(0);" onclick="show_notes('${tag_vo.tag}')">${tag_vo.tag } (${tag_vo.count })</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div style="clear: both;"></div>
			</div>
	    </div>
	</div>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
</body>
</html>
