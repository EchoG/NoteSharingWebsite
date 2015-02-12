<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/jsp/inc/login.jsp"%><!-- login -->
<header>
	<div class="logo">
		<a href="index"><span class="blue">N<span class="green">ot</span>e</span></a>
        <!-- span class="gray"> Share</span -->
	</div>
	
    <div class="headernav">
        <ul>
        	<!-- 
            <li <c:if test="${menu eq 'main' }">class="current"</c:if>>
            	<img src="" />
            	<a href="main?tag=all">笔记&middot;荐</a>
            </li>
            -->
            <li <c:if test="${menu eq 'note_recmd' }">class="current"</c:if>>
            	<!-- img src="" / -->
            	<a href="note_recmd?tag=all">笔记&middot;荐</a>
            </li>
             
            <li <c:if test="${menu eq 'author_recmd' }">class="current"</c:if>>
            	<!-- img src="" / -->
            	<a href="author_recmd">笔者&middot;荐</a>
            </li>
        </ul>
    </div>
    
    <div class="search">
        <form id="searchform" name="searchform" action="note_recmd" method="post">
        	<input class="searchbox" id="search_keywords" name="keywords" value="${keywords }" 
        	   placeholder="请输入搜索关键词 以空格分隔" type="text" />
        	<input type="hidden" id="search_tag" name="tag" value="${tag }" type="text" />
        	<input type="hidden" id="search_menu" name="menu" value="${menu }" type="text" />
            <input class="searchbtn" type="submit" value="搜索" />
        </form>
    </div> 
    
    <div class="hostinfonav">
	    <ul>
	    <c:choose>
			<c:when test="${not empty me }">
				<li><a href="note_user?id=${me.user_id }&notetype=self&notebook=all">${me.name }</a></li>
				<li><a href="javascript:void(0);" onclick="onCreate()">新建笔记</a></li>
				<li><a id="header_draft_box" href="note_draft">草稿箱</a></li>
				<li><a href="logout">退出</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0);" onclick="showLogin()">登陆</a></li>
				<li><a href="register">注册</a></li>
			</c:otherwise>
		</c:choose>
		</ul>
	</div>
</header>
