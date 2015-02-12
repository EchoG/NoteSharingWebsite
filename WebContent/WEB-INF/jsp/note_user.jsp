<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${pageuser.name}</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/user.css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
    <div class="mainwrapper">
    	<div class="mainbody">
    		<div class="userinfo">
    			<div class="userpic">
					<img src="images/head/head1.jpg" />
				</div>
    			<div class="userbase">
    				<p class="username">${pageuser.name}</p>
    				<div class="userother">
	    				<span>
	    					<c:if test="${pageuser.gender eq 'f'}">女</c:if>
	    					<c:if test="${pageuser.gender eq 'm'}">男</c:if>
	    				</span>requestParam decode
	    				<span>来自${pageuser.come_from }</p>
    				</div>
    			</div>
			</div>
			
			<form id="userPageForm" name="userPageForm" action="note_user" method="post">
	            <input type="hidden" id="userPage_id" name="id" value="" type="text" />
	            <input type="hidden" id="userPage_notetype" name="notetype" value="" type="text" />
	            <input type="hidden" id="userPage_notebook" name="notebook" value="" type="text" />
	        </form>
			
    		<div class="usernoteshow">
    			<%@ include file="/WEB-INF/jsp/inc/note_list.jsp"%>
		    	<div class="notenav">
		    		<ul>
		    			<li <c:if test="${notetype eq 'self' }">class="current"</c:if>>
			    			<c:choose>
				    			<c:when test="${me.user_id eq pageuser.user_id }">
				    				<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=self&notebook=all">我的笔记</a>
				    			</c:when>
				    			<c:otherwise>
				    				<c:if test="${pageuser.gender eq 'f'}">
				    					<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=self&notebook=all">她的笔记</a>
				    				</c:if>
		    						<c:if test="${pageuser.gender eq 'm'}">
		    							<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=self&notebook=all">他的笔记</a>
		    						</c:if>
				    			</c:otherwise>
			    			</c:choose>
			    			<c:if test="${notetype eq 'self' }">
			    				<ul class="notebook">
				    				<li <c:if test="${empty notebook || notebook eq 'all' }">class="current"</c:if>>
				    					<a class="nbitem" href="note_user?id=${pageuser.user_id}&notetype=self&notebook=all">全部(${countAll })</a>
				    				</li>
				    				<c:forEach var="fileType" items="${fileTypes}">                                    
									<li <c:if test="${notebook eq fileType.fileType }">class="current"</c:if>>
										<a class="nbitem" href="javascript:void(0);" 
										onclick="enterMyFileType('${pageuser.user_id}', 'self', '${fileType.fileType}');">
										${fileType.fileType }(${fileType.count })</a>
									</li>
									</c:forEach>
			    				</ul>
		    				</c:if>
		    			</li>
		    			<li <c:if test="${notetype eq 'share' }">class="current"</c:if>>
			    			<c:choose>
				    			<c:when test="${me.user_id eq pageuser.user_id }">
				    				<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=share&notebook=">我的分享</a>
				    			</c:when>
				    			<c:otherwise>
				    				<c:if test="${pageuser.gender eq 'f'}">
				    					<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=share&notebook=">她的分享</a>
				    				</c:if>
		    						<c:if test="${pageuser.gender eq 'm'}">
		    							<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=share&notebook=">他的分享</a>
		    						</c:if>
				    			</c:otherwise>
			    			</c:choose>
		    			</li>
		    			<c:if test="${me.user_id eq pageuser.user_id }">
		    				<li <c:if test="${notetype eq 'store' }">class="current"</c:if>>
		    					<a class="nnitem" href="note_user?id=${pageuser.user_id}&notetype=store&notebook=">我的收藏</a>
		    				</li>
		    			</c:if>
		    		</ul>
				</div>
				
				<div style="clear: both;"></div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
<iframe name="submit_frame" id="submit_frame" hidden="true"></iframe>
</body>

</html>
