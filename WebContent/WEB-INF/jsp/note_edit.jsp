<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>		
		<c:if test="${action eq create }">新建笔记</c:if>
		<c:if test="${action eq edit }">编辑笔记</c:if>
	</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/note_edit.css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_create.js"></script>
	<script language="javascript" type="text/javascript" src="js/note_edit.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>	
    <div class="mainwrapper">
    	<!-- hidden new file type div -->
	    <div id="newtype" class="new_wrapper">
			<div class="new_title">
				<span class="title">添加文集</span>
				<a href="javascript:void(0);" class="close" onclick="hideNewtype()">关闭</a>
			</div>
			<div class="new_body">
				<form id="newtype_form" name="newtype_form" target="submit_frame" action="newtype_submit" method="post">
					<div class="new_input">
						<label for="newtype_input">添加文集：</label>
						<input type="text" id="newtype_input" name="newtype_input" onblur="checkNewtype()" />
						<p id="newtype_tip" class="new_tip">文集名称限长14个字符</p>
					</div>
				</form>
			</div>
			<div class="new_nav">
				<input type="button" id="newtype_add_btn" name="newtype_add_btn" onclick="submitNewtype()" value="添加" />
				<input type="button" id="newtype_cancel_btn" name="newtype_cancel_btn" onclick="hideNewtype()" value="取消" />
			</div>
		</div>
		<!-- hidden new tag div -->
		<div id="newtag" class="new_wrapper">
			<div class="new_title">
				<span class="title">添加标签</span>
				<a href="javascript:void(0);" class="close" onclick="closeNewTag()">关闭</a>
			</div>
			<div class="new_body">
				<form id="newtag_form" name="newtag_form" target="submit_frame" action="newtag_submit" method="post">
					<div class="new_input">
						<span>热门标签：</span>
						<c:forEach var="tag" items="${tags}">  
                          <a class="hottag" href="javascript:void(0);" onclick="addTag('${tag.tag }');">${tag.tag }</a>
                        </c:forEach>						
					</div>
					<div class="new_input">
						<label for="newtag_input">添加标签：</label>
						<input type="text" id="newtag_input" name="newtag_input" value="${review.tag }" onblur="checkNewtag()" />
						<p id="newtag_tip" class="new_tip">最多5个标签，每个限长14个字符，以空格分隔</p>
					</div>
				</form>
			</div>
			<div class="new_nav">
				<input type="button" id="newtag_add_btn" name="newtag_add_btn" onclick="confirmTag()" value="确认" />
				<input type="button" id="newtag_cancel_btn" name="newtag_cancel_btn" onclick="closeNewTag()" value="取消" />
			</div>
		</div>
		<!-- mainbody -->
    	<div class="mainbody">  	
    		<h2 class="title"><c:choose>
				<c:when test="${empty review }">新建笔记</c:when>
				<c:otherwise>编辑笔记</c:otherwise>
			</c:choose></h2>
    		<div class="newnote">
		     	<div class="editarea">
		        	<form id="createReview_form" name="judge_form" target="submit_frame" 
		        		action="review_submit" method="post" enctype="multipart/form-data">
		                <div class="notechoice">
			                <p class="choice">
				           	 	<label for="filetype">文集：</label>
				           	 	<select id="filetype" name="filetype" title="笔记文集">				           	 	    
                                    <c:forEach var="fileType" items="${fileTypes}">  
				 					  <option <c:if test="${fileType.fileType eq review.filetype}">selected</c:if> >${fileType.fileType }</option>
				 					</c:forEach>
								</select>
								<a href="javascript:void(0);" onclick="showNewtype()">添加文集</a>								
							</p>
							<p class="choice">
								浏览权限：
								<label for="authoritypub" title="所有人可见的笔记">
									<input type="radio" name="authority" id="authoritypub" value="2" checked="checked" />
								所有人</label>
								<label for="authoritypri" title="仅自己可见的笔记">
									<input type="radio" name="authority" id="authoritypri" value="1" />
								仅自己</label>
							</p>
							<p class="choice">
								<input type="hidden" id="tag_input" name="tag" value="${review.tag }" />
								<c:if test="${not empty review.tag }">
								    <span id="tag_show">标签：${review.tag }</span>
			                		<a href="javascript:void(0);" onclick="showNewtag()">编辑标签</a>
			                	</c:if>
			                	<c:if test="${empty review.tag }">
			                	    <span id="tag_show">标签：暂无</span>
									<a href="javascript:void(0);" onclick="showNewtag()">编辑标签</a>
								</c:if>
							</p>
							<p class="choice">
								<label for="review_upfile">附件：</label>
			                	<input type="file" id="review_upfile" name="review_upfile" />
								<c:if test="${not empty review.uploadfile }">
			                		<span>目前附件为${review.uploadfile }</span>
			                	</c:if>			                	
			                </p>
		                </div>
		                
		                <div class="notebodywp">
		                   	<div class="editorwp">
								<div class="editor" id="blodwp">
		                   			<input type="button" id="boldBtn" value="B" title="加粗" onclick="setBold('content_div');" />
		                   		</div>
		                   		<div  class="editor" id="italicwp">
									<input type="button" id="italicBtn" value="I" title="斜体" onclick="setItalic('content_div');" />
								</div>
							
								<div  class="editor" id="uderlinewp">
									<input type="button" id="underlineBtn" value="U" title="下划线" onclick="setUnderline('content_div');" />
								</div>
								<div class="editor" id="fontsizewp"> 
									<select id="fontsizeSelect" title="字号" onchange="setFontSize('content_div', $('#fontsizeSelect').val());">
										<option>1</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
										<option selected="selected">5</option>
										<option >6</option>
										<option>7</option>
									</select>
								</div>
								<div class="editor" id="fontcolorwp">
									<select id="fontColorSelect" title="字体颜色" style="width: 80px; font-weight: bold;" onchange="setFontColor('content_div',$('#fontColorSelect'));" >
										<option style="color: #000000;" value=#000000 selected="selected">black</option>
										<option style="color: #DC143C;" value=#DC143C>red</option>
										<option style="color: #0000FF;" value=#0000FF>blue</option>
										<option style="color: #008000;" value=#008000>green</option>
										<option style="color: #FFFF00;" value=#FFFF00>yellow</option>
										<option style="color: ##FFFFFF;" value=#FFFFFF>white</option>
									  </select>
								</div>
								<div class="editor" id="backcolorwp">
									<select id="backColorSelect" title="字体背景色" style="width: 80px;" onchange="setBackColor('content_div',$('#backColorSelect'));" >
                                        <option style="background: ##FFFFFF" value=#FFFFFF selected="selected"><!--white--></option>
									  <option style="background: #DC143C" value=#DC143C><!--red--></option>
										<option style="background: #0000FF" value=#0000FF><!--blue--></option>
										<option style="background: #008000" value=#008000><!--green--></option>
										<option style="background: #FFFF00" value=#FFFF00><!--yellow--></option>
										<option style="background: #FFFFFF" value=#FFFFFF selected="selected"><!--white--></option>
									  </select>
								</div>
								<div class="editor" id="fontstylewp">
									<select id="fontStyleSelect" title="字体" onchange="setFontStyle('content_div',$('#fontStyleSelect').val());" >
									  	<option value="Times New Roman" selected="selected">Times New Roman</option>
									  	<option value="Courier New">Courier New</option>
									  	<option value="Tahoma">Tahoma</option>
									  	<option value="Arial">Arial</option>
									  	<option value="Elephant">Elephant</option>
									  	<option value="宋体">宋体</option>
									  	<option value="楷体">楷体</option>
									  	<option value="黑体">黑体</option>
									  	<option value="华文彩云">华文彩云</option>
									</select>
								</div>								
							</div>
							<div class="notewp">
								<div class="titlewp">
									<input autocomplete="off" type="text" id="isbn" name="isbn" value="${review.isbn }" placeholder="请在这里输入笔记标题" />
								</div>
								<div class="contentwp">
									<iframe id="content_div"></iframe>
								</div>
							</div>
						</div>
						
		                <div class="submitwp">
			               	<input type="button" id="sub_btn" title="发表笔记" class="pass_login_input pass_login_input_submit" name="sub_btn" onclick="review_submit()"  value="发表" />
			            </div>
			            <div class="submitwp">
							<input type="button" id="draft_btn" title="保存草稿" name="draft_btn" onclick="review_draft()" value="保存草稿" />
							&nbsp;&nbsp;&nbsp;<span id="draft_prompt"></span>
						</div>			            
			            <div class="submitwp">
							<input type="button" id="cancel_btn" title="取消" name="cancel_btn" onclick="review_cancel()" value="取消" />
						</div>
		                
		            	<!-- hidden inputs -->
		            	<input type="hidden" id="review_id" name="review_id" value="${review.review_id }"/>
		            	<!--
		            	<input type="hidden" id="user_id" name="user_id" value="${review.user_id }"/> 
		            	 -->
		           	 	<input type="hidden" id="user_id" name="user_id" value="${me.user_id }"/>
						<input type="hidden" id="rating" name="rating" value="${review.rating }"/>						
						<input type="hidden" id="tagValue" name="tagValue" value="${review.tag }"/>
						<input type="hidden" id="filetypeValue" name="filetypeValue" value="${review.filetype }"/>
						<input type="hidden" id="uploadfile" name="uploadfile" value="${review.uploadfile }"/>
						<input type="hidden" id="authorityValue" name="authorityValue" value="${review.authority }"/>						
						<input type="hidden" id="content" name="content" value=""/>
						<input type="hidden" id="draftSet" name="draftSet" value="0"/>
		        	</form>
		        </div>
		    </div>
    	</div>
    </div>
    <iframe name="submit_frame" id="submit_frame" hidden="true"></iframe>
    <%@ include file="/WEB-INF/jsp/inc/footer.jsp"%>
</div>
</body>

<script>
	var content = null;
	if ('${action}' == 'edit'){
		content = '${review.content}';
	}

	/*
	var autoSave = '${autoSave}';
	alert(autoSave);
	if (autoSave == '1') {*/
		// tow minutes
		setInterval(review_auto_draft, 30000);		
	//}
</script>
</html>
