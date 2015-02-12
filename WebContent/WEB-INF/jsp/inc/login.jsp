<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">
	function login_submit() {
		var uid = document.getElementById("log_user_id");
		if (uid.value == "") {
			alert("用户名不能为空");
			return false;
		}
		var pw = document.getElementById("log_password");
		if (pw.value == "") {
			alert("密码不能为空");
			return false;
		}
		// deal last page
		var last_page = document.getElementById("last_page");
		last_page.value = document.location;
		//alert(last_page.value);
		// submit
		var form = document.getElementById("login_form");
			form.submit();
	}
	
	function showLogin(){
		document.getElementById("back").style.display = "block";
		document.getElementById("login").style.display = "block";
	}
	
	function hideLogin(){
		document.getElementById("back").style.display = "none";
		document.getElementById("login").style.display = "none";
	}
</script>

<div id="back"></div>
<div id="login">
	<a href="javascript:void(0);" class="close" onclick="hideLogin()">关闭</a>
	<ul class="login_tab">
		<li id="login_tab_1" class="curr">普通登录</li>
	</ul>
	<div id="errHolder_1" class="err_holder">${msg }</div>
	
	<div id="login_holder">
		<div id="login_holder_1">
			<form class="pass_login_form" id="login_form" target="login_frame" action="login_submit" method="post">
				<p class="pass_login_p pass_login_p_username" id="pass_login_p_username_0">
					<label class="pass_login_label pass_login_label_username" id="pass_login_label_username_0" for="log_user_id">
						帐号：
					</label> 
					<input class="pass_login_input pass_login_input_username" type="text" id="log_user_id" name="log_user_id" value="lily"/>
					<!-- span class="pass_login_err" id="pass_login_username_0_err">
						请您输入帐号
					</span -->
				</p>
				<p class="pass_login_p pass_login_p_password" id="pass_login_p_password_0">
					<label class="pass_login_label pass_login_label_password" id="pass_login_label_password_0" for="log_password">
						密码：
					</label> 
					<input class="pass_login_input pass_login_input_password" type="password" id="log_password" name="log_password" value="123"/>
					<!-- span class="pass_login_err" id="pass_login_password_0_err">
						请您输入密码
					</span -->
					<span class="pass_login_tip" id="pass_login_password_0_tip"></span>
				</p>
				<p class="pass_login_p pass_login_p_btn" id="pass_login_p_btn_0">
					<input class="pass_login_input pass_login_input_submit" id="submit_0" type="button" value="登录" onclick="login_submit();" />
					<a href="https://passport.baidu.com/?getpass_index" class="pass_login_a_fgtpwd" id="fgtpwd_0" target="_blank">
						忘记密码？
					</a>
				</p>
				<input type="hidden" id="last_page" name="last_page" value=""/>
			</form>
		</div>
		<div id="login_holder_2" style="display: none"></div>
		<div class="reg_line"></div>
		<p class="reg_holder">
			还没有笔记分享帐号？
			<a href="register" target="_blank" id="reg_btn">
				立即注册
			</a>
		</p>
	</div>
    <iframe name="login_frame" id="submit_frame" hidden="true"></iframe>
</div>		