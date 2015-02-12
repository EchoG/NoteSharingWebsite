<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>笔记列表</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/note_list.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_list.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <!-- 隐藏表单 -->
	<form id="action_form" name="action_form" target="submit_frame" action="" method="post">
		 <input type="hidden" id="review_id" name="review_id" value=""/>
		 <input type="hidden" id="rate" name="rate" value=""/>
		 <input type="hidden" id="content" name="content" value=""/>
	</form>
    
    <div class="mainwrapper">
	    <div class="mainbody">
	    	<div class="newnotelist">
	       		<h2 class="title">所有笔记列表 </h2>
	            <div class="newnoteinfo">
	            <ol>
	            <p>小说类</p>
				<c:forEach var="review" items="${reviews}">
				<c:if test='${review.tag eq "小说"}'>
					<li>review_id:<span id="review_id_${review.review_id}">${review.review_id}</span>
						<c:if test="${not empty me && review.user_id ne me.user_id}">
							<a href="javascript:void(0)" onclick="onForward(${review.review_id})">分享</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id }">
							<a href="javascript:void(0)" onclick="onUp(${review.review_id})">顶</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id }">
							<select id="rate_${review.review_id}" >
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>&nbsp;&nbsp;
							<a href="javascript:void(0)" onclick="onRate(${review.review_id})">打分</a>&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="onShowComment(${review.review_id})">回复</a>&nbsp;&nbsp;<br/>
						
						isbn:<span id="isbn_${review.review_id}">${review.isbn}</span><br/>
						user_id:<span id="user_id_${review.review_id}">${review.user_id}</span><br/>
						tag:<span id="tag_${review.review_id}">${review.tag}</span><br/>
						content：<span id="content_${review.review_id}">${review.content}</span>&nbsp;&nbsp;<br/>
						comment：<br/>
						<c:forEach var="comment" items="${review.comments}">
							<span id="comment.user_id}">${comment.user_id}</span>评论：	
							<span id="comment.content}">${comment.content}</span>&nbsp;&nbsp;<br/>	
						</c:forEach>					
						up_count：<span id="up_count_${review.review_id}">${review.count_up}</span>&nbsp;&nbsp;<br/>							
						avg_rate：<span id="avg_rate_${review.review_id}">${review.avg_rate}</span>&nbsp;&nbsp;<br/>
						forward_id：<span id="forward_id_${review.review_id}">${review.forward_id}</span>&nbsp;&nbsp;<br/>
						forward_user：<span id="forward_user_${review.review_id}">${review.forward_user}</span>&nbsp;&nbsp;<br/>
						<div class="comment" id="comment_${review.review_id}">
							<div id="content_div_${review.review_id}" class="editor_editarea" contenteditable="true"></div><br/>
							<a href="javascript:void(0)" onclick="onComment(${review.review_id})">提交</a>&nbsp;&nbsp;<br/>
						</div>					
					</li>
					
				</c:if>
				</c:forEach>
				
				<p>随笔类</p>
				<c:forEach var="review" items="${reviews}">
				<c:if test='${review.tag eq "随笔"}'>
					<li>review_id:<span id="review_id_${review.review_id}">${review.review_id}</span>
						<c:if test="${not empty me && review.user_id ne me.user_id}">
							<a href="javascript:void(0)" onclick="onForward(${review.review_id})">分享</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_count_up gt 0}">
							<a href="javascript:void(0)" onclick="onUp(${review.review_id})">顶</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_rate gt 0}">
							<select id="rate_${review.review_id}" >
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>&nbsp;&nbsp;
							<a href="javascript:void(0)" onclick="onRate(${review.review_id})">打分</a>&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="onShowComment(${review.review_id})">回复</a>&nbsp;&nbsp;<br/>
						
						isbn:<span id="isbn_${review.review_id}">${review.isbn}</span><br/>
						user_id:<span id="user_id_${review.review_id}">${review.user_id}</span><br/>
						tag:<span id="tag_${review.review_id}">${review.tag}</span><br/>
						content：<span id="content_${review.review_id}">${review.content}</span>&nbsp;&nbsp;<br/>						
						up_count：<span id="up_count_${review.review_id}">${review.count_up}</span>&nbsp;&nbsp;<br/>							
						avg_rate：<span id="avg_rate_${review.review_id}">${review.avg_rate}</span>&nbsp;&nbsp;<br/>
						forward_id：<span id="forward_id_${review.review_id}">${review.forward_id}</span>&nbsp;&nbsp;<br/>
						forward_user：<span id="forward_user_${review.review_id}">${review.forward_user}</span>&nbsp;&nbsp;<br/>
						
						<div class="comment" id="comment_${review.review_id}">
							<div id="content_div_${review.review_id}" class="editor_editarea" contenteditable="true"></div><br/>
							<a href="javascript:void(0)" onclick="onComment(${review.review_id})">提交</a>&nbsp;&nbsp;<br/>
						</div>					
					</li>
					
				</c:if>
				</c:forEach>
				
				<p>散文类</p>
				<c:forEach var="review" items="${reviews}">
				<c:if test='${review.tag eq "散文"}'>
					<li>review_id:<span id="review_id_${review.review_id}">${review.review_id}</span>
						<c:if test="${not empty me && review.user_id ne me.user_id}">
							<a href="javascript:void(0)" onclick="onForward(${review.review_id})">分享</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_count_up gt 0}">
							<a href="javascript:void(0)" onclick="onUp(${review.review_id})">顶</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_rate gt 0}">
							<select id="rate_${review.review_id}" >
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>&nbsp;&nbsp;
							<a href="javascript:void(0)" onclick="onRate(${review.review_id})">打分</a>&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="onShowComment(${review.review_id})">回复</a>&nbsp;&nbsp;<br/>
						
						isbn:<span id="isbn_${review.review_id}">${review.isbn}</span><br/>
						user_id:<span id="user_id_${review.review_id}">${review.user_id}</span><br/>
						tag:<span id="tag_${review.review_id}">${review.tag}</span><br/>
						content：<span id="content_${review.review_id}">${review.content}</span>&nbsp;&nbsp;<br/>						
						up_count：<span id="up_count_${review.review_id}">${review.count_up}</span>&nbsp;&nbsp;<br/>							
						avg_rate：<span id="avg_rate_${review.review_id}">${review.avg_rate}</span>&nbsp;&nbsp;<br/>
						forward_id：<span id="forward_id_${review.review_id}">${review.forward_id}</span>&nbsp;&nbsp;<br/>
						forward_user：<span id="forward_user_${review.review_id}">${review.forward_user}</span>&nbsp;&nbsp;<br/>
						
						<div class="comment" id="comment_${review.review_id}">
							<div id="content_div_${review.review_id}" class="editor_editarea" contenteditable="true"></div><br/>
							<a href="javascript:void(0)" onclick="onComment(${review.review_id})">提交</a>&nbsp;&nbsp;<br/>
					</div>					
					</li>
					
				</c:if>
				</c:forEach>
				
				<p>管理类</p>
				<c:forEach var="review" items="${reviews}">
				<c:if test='${review.tag eq "管理"}'>
					<li>review_id:<span id="review_id_${review.review_id}">${review.review_id}</span>
						<c:if test="${not empty me && review.user_id ne me.user_id}">
							<a href="javascript:void(0)" onclick="onForward(${review.review_id})">分享</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_count_up gt 0}">
							<a href="javascript:void(0)" onclick="onUp(${review.review_id})">顶</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${not empty me && review.user_id ne me.user_id && review.my_rate gt 0}">
							<select id="rate_${review.review_id}" >
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>&nbsp;&nbsp;
							<a href="javascript:void(0)" onclick="onRate(${review.review_id})">打分</a>&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="onShowComment(${review.review_id})">回复</a>&nbsp;&nbsp;<br/>
						
						isbn:<span id="isbn_${review.review_id}">${review.isbn}</span><br/>
						user_id:<span id="user_id_${review.review_id}">${review.user_id}</span><br/>
						tag:<span id="tag_${review.review_id}">${review.tag}</span><br/>
						content：<span id="content_${review.review_id}">${review.content}</span>&nbsp;&nbsp;<br/>						
						up_count：<span id="up_count_${review.review_id}">${review.count_up}</span>&nbsp;&nbsp;<br/>							
						avg_rate：<span id="avg_rate_${review.review_id}">${review.avg_rate}</span>&nbsp;&nbsp;<br/>
						forward_id：<span id="forward_id_${review.review_id}">${review.forward_id}</span>&nbsp;&nbsp;<br/>
						forward_user：<span id="forward_user_${review.review_id}">${review.forward_user}</span>&nbsp;&nbsp;<br/>
						
						<div class="comment" id="comment_${review.review_id}">
							<div id="content_div_${review.review_id}" class="editor_editarea" contenteditable="true"></div><br/>
							<a href="javascript:void(0)" onclick="onComment(${review.review_id})">提交</a>&nbsp;&nbsp;<br/>
						</div>					
					</li>
					
				</c:if>
				</c:forEach>
				</ol>
	            </div>
	       </div>
	    </div>
	</div>
	<iframe name="submit_frame" id="submit_frame" hidden=true></iframe>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
<!-- login -->
<%@ include file="/WEB-INF/jsp/inc/login.jsp"%>
</body>
</html>
