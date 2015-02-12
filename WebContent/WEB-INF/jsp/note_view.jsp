<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${review.isbn }</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/note_view.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <div class="mainwrapper">
	    <div class="mainbody">
		    <div class="notebody">
		    	<div class="note">
			    	<h2 class="title">${review.isbn }</h2>
					<div class="noteinfo">
						<div class="userpic">
							<img src="images/head/head1.jpg" />
						</div>
						<a href="note_user?id=${review.user_id }&notetype=self&notebook=all"><!-- this need review user name -->${review.user_id }</a>
						<span class="time">发表于${review.pubtime }</span>
						<p>标签：${review.tag }&nbsp;&nbsp;&nbsp;&nbsp;文集：${review.filetype }</p>
						<c:if test="${review.authority eq 1 }">
							<p>仅自己可见</p>
						</c:if>
					</div>
					<div class="note_content">${review.content}</div>
		    	</div>
		    	
		    	<div class="note_nav">
		    	<%@ include file="/WEB-INF/jsp/inc/note_form.jsp"%><!-- form -->
					<div class="func">
						<c:if test="${me.user_id eq review.user_id }">
							<c:if test='${review.uploadfile ne null && review.uploadfile ne "" }'>
								<a href="javascript:void(0)" onclick="onDownload(${review.review_id})">附件：${review.uploadfile}</a>
								<span>|</span>
							</c:if>
							<!-- 
							<a href="javascript:void(0);" onclick="onDelete(${review.review_id})">删除</a>
							<span>|</span>
							 -->
							<a href="note_edit?id=${review.review_id }">编辑</a>
							<span>|</span>
							<a href="javascript:void(0);" onclick="onExport(${review.review_id})">导出</a>
							<span>|</span>
						</c:if>
						<c:if test="${me.user_id ne review.user_id }">
							<c:choose>
								<c:when test="${review.my_count_up eq 0}">
									<a href="javascript:void(0);" onclick="onUp(${review.review_id})">顶(${review.count_up})</a>
								</c:when>
								<c:otherwise>
									<span class="done">已顶(${review.count_up})</span>
								</c:otherwise>
							</c:choose>
							<span>|</span>
							<a href="javascript:void(0);" onclick="onForward(${review.review_id})">分享</a>
							<span>|</span>
							<a href="javascript:void(0);" onclick="onStore(${review.review_id})">收藏</a>
							<span>|</span>
							<c:choose>
								<c:when test="${review.my_rate eq null }">
									<select id="rate_${review.review_id}" >
										<option>1</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
										<option>5</option>
									</select>
									<a href="javascript:void(0);" onclick="onRate(${review.review_id})">
										打分(<c:if test="${review.avg_rate eq null}">0</c:if>${review.avg_rate})
									</a>
								</c:when>
								<c:otherwise>
									<span class="done">已打分(${review.avg_rate})</span>
								</c:otherwise>
							</c:choose>
							<span>|</span>
						</c:if>
						<a href="javascript:void(0);" onclick="onShowComment(${review.review_id})">评论(${fn:length(review.comments) })</a>
					</div>
					<div style="clear: both;"></div>
				</div>
				
				<div class="comment">				
					<ul>
					<c:forEach var="comment" items="${review.comments}">
						<li class="commentitem">
							<div class="commentpic">
								<a href="note_user?id=${comment.user_id }&notetype=self&notebook=all"><img src="images/head/head2.jpg" /></a>
							</div>
							<div class="commentcnt">
								<a href="note_user?id=${comment.user_id }&notetype=self&notebook=all"><!-- this need comment user name -->${comment.user_id }</a>
								<span>：${comment.content}</span>
								<p>${comment.create_time}</p>
							</div>
						</li>
					</c:forEach>
						<li>
							<div class="commentpic">
								<a href=""><img src="images/head/head2.jpg" /></a>
							</div>
							<div class="commentcnt">
								<div class="commentbox">
									<textarea class="commentinput" name="commentText" id="content_div_${review.review_id}" placeholder="请输入评论"></textarea>
								</div>
								<div class="commentsend"><a href="javascript:void(0);" onclick="onComment(${review.review_id})">评论</a></div>
							</div>
						</li>
					</ul>
				</div>
			</div>
	    </div>
	</div>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
</body>
</html>
