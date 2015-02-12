<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/inc/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>注册账号</title>
	<link href="css/general.css" rel="stylesheet" type="text/css" />
	<link href="css/register.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/register.js"></script>
    <script language="javascript" type="text/javascript" src="js/note_create.js"></script>
</head>

<body>
<div class="wrapper">
	<%@ include file="/WEB-INF/jsp/inc/header.jsp"%>
	<div class="mainwrapper">
        <div class="mainbody">
        	<h2 class="title">注册账号</h2>
        	<div class="regbody">
	    		<div class="regfrm">
	            	<form name="registerform" method="post" action="register_submit">
	                    <div class="frmitem">
	                    	<label for="username" class="frmtit"><span>*&nbsp;</span>账号：</label>
	                        <input id="username" class="frmcont" name="user_id" type="text" onblur="checkUserName()" />
	                        <span class="frmtip" id="nameMes">请输入您的账号，登录使用</span>
	                    </div>
	                    <div class="frmitem">
	                        <label for="nickname" class="frmtit"><span>*&nbsp;</span>昵称：</label>
	                        <input id="nickname" class="frmcont" name="name" type="text" onblur="checkNickName()" />
	                        <span class="frmtip" id="nickMes">请输入您的昵称</span>
	                    </div>
	                    <div class="frmitem">
	                        <label for="password" class="frmtit"><span>*&nbsp;</span>创建密码：</label>
	                        <input id="password" class="frmcont" name="password" type="password" onblur="checkPass()" onkeyup="checkPass1()" />
	                        <span class="frmtip" id="pswMes">密码由6-16位半角字符（字符、数字、符号）组成，区分大小写</span>
	                    </div>
	                    <div class="frmitem">
	                        <label for="repsswd" class="frmtit"><span>*&nbsp;</span>确认密码：</label>
	                        <input id="repsswd" class="frmcont" name="repsswd" type="password" onblur="checkConfirm()" />
	                        <span class="frmtip" id="repswMes">请确认您的密码</span>
	                    </div>
	                    <div class="frmitem">
	                        <label for="email" class="frmtit"><span>*&nbsp;</span>邮箱：</label>
	                        <input id="email" class="frmcont" name="email" type="text" onblur="checkEmail()" />
	                        <span class="frmtip" id="emailMes">请输入您的邮箱</span>
	                    </div>
	                    <div class="frmitem">
	                        <label class="frmtit"><span>*&nbsp;</span>性别：</label>
	                        <div class="gender">
	                            <label><input name="gender" type="radio" value="m" checked="checked" />&nbsp;&nbsp;男</label>
	                            <label><input name="gender" type="radio" value="f" />&nbsp;&nbsp;女</label>
	                        </div>
	                        <span class="frmtip" id="genderMes"/>
	                    </div>
	                    <div class="frmitem">
	                        <label for="from" class="frmtit"><span>*&nbsp;</span>来自：</label>
	                        <input id="from" class="frmcont" name="come_from" type="text" onblur="checkFrom()" />
	                        <span class="frmtip" id="fromMes">请输入您所在地</span>
	                    </div>
	                    <div class="frmitem">
	                        <a href="javascript:void(0);" class="regbtn" title="立即注册" onclick="checkAll()">立即注册</a>
	                    </div>
	                </form>
	        	</div>
	            <div class="regr">
	                <div class="r_title">
	                	<span>已有账号？<a href="javascript:void(0);" onclick="showLogin()">直接登陆</a></span>
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