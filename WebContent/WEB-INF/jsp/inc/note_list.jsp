<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="notelist">
	<ul><c:forEach var="review" items="${reviews}">
	<c:if test="${review.authority eq 2 || review.user_id eq me.user_id}">
	<li>
		<div class="userpic">
			<a href="note_user?id=${review.user_id }&notetype=self&notebook=all">
				<img src="images/head/head1.jpg" />
				<span>${review.user_name}</span>
			</a>
		</div>
		<div class="arrow_left"></div>
		<div class="usernote">
			<c:if test="${empty review.forward_user}">
				<div class="note_title">
					<c:if test="${review.authority eq 3 }">
						<a href="javascript:void(0);" onClick="onEdit(${review.review_id })"><c:if test="${review.isbn eq '' }">(未命名)</c:if>${review.isbn }</a>
					</c:if>
					<c:if test="${review.authority ne 3 }">
						<a href="note_view?id=${review.review_id }">${review.isbn}</a>
					</c:if>
					<c:if test="${review.authority eq 1 }">
						<span class="tag">&nbsp;（仅自己可见）</span>
					</c:if>
				</div>
				<p class="tag">标签：${review.tag }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文集：${review.filetype }</p>
				<div class="note_content">${review.content}</div>
			</c:if>
			
			<c:if test="${not empty review.forward_user}">
				<div class="note_share">分享笔记：
					<a href="note_view?id=${review.forward_id }">${review.isbn }</a>
					<div class="quto">
				        <!-- p class="arrow_up"><img src="images/arrow.png" /></p -->
					    <div class="qutocont_wrap">
					        ${review.content }
					        <!-- this need forward_user user id -->
					        <div>来自：<a href="note_user?id=&notetype=self&notebook=all">${review.forward_user}</a></div>
					    </div>
					</div>
				</div>
			</c:if>
			
			<div class="note_nav">	
			<%@ include file="/WEB-INF/jsp/inc/note_form.jsp"%><!-- form -->
			<div class="func">
				<c:if test="${empty review.forward_user}">
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
								<a href="note_view?id=${review.review_id }">
									打分(<c:if test="${review.avg_rate eq null}">0</c:if>${review.avg_rate})
								</a>
							</c:when>
							<c:otherwise>
								<span class="done">已打分(${review.avg_rate})</span>
							</c:otherwise>
						</c:choose>
						<span>|</span>
						<a href="note_view?id=${review.review_id }">评论(${fn:length(review.comments) })</a>
					</c:if>
					<c:if test="${me.user_id eq review.user_id }">
						<c:if test="${review.authority ne 3 }">
							<div class="menote">
								<c:if test='${review.uploadfile ne null && review.uploadfile ne "" }'>
									<a href="javascript:void(0)" onclick="onDownload(${review.review_id})">附件：${review.uploadfile}</a>
									<span>|</span>
								</c:if>
								<a href="javascript:void(0);" onclick="onDelete(${review.review_id})">删除</a>
								<span>|</span>
								<a href="javascript:void(0);" onclick="onEdit(${review.review_id })">编辑</a>
								<span>|</span>
								<a href="javascript:void(0);" onclick="onExport(${review.review_id})">导出</a>
								<span>|</span>
							</div>
							<a href="note_view?id=${review.review_id }">评论(${fn:length(review.comments) })</a>
						</c:if>
						<c:if test="${review.authority eq 3 }">
							<c:if test='${review.uploadfile ne null && review.uploadfile ne "" }'>
								<a href="javascript:void(0)" onclick="onDownload(${review.review_id})">附件：${review.uploadfile}</a>
								<span>|</span>
							</c:if>
							<a href="javascript:void(0);" onclick="onDelete(${review.review_id})">删除</a>
							<span>|</span>
							<a href="javascript:void(0);" onclick="onEdit(${review.review_id })">编辑</a>
							<!-- 
							<span>|</span>
							<a href="javascript:void(0);" onclick="">发表</a>
							 -->
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${not empty review.forward_user && me.user_id eq review.user_id}">
					<div class="menote">
						<a href="javascript:void(0);" onclick="onDelete(${review.review_id})">删除</a>
					</div>
				</c:if>
			</div>
			<div class="noteinfo">
				<c:if test="${review.authority eq 3 }">
					<span class="time">草稿存储于${review.pubtime }</span>
				</c:if>
				<c:if test="${review.authority ne 3 }">
					<span class="time">发表于${review.pubtime }</span>
				</c:if>
			</div>
			</div>
		</div>
	</li>
	</c:if>
	</c:forEach></ul>
</div>
