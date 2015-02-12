// JavaScript Document

//ajax+jsp实现用户名实时验证
var xmlHttpRequest;
function createXMLHttpRequest(){
	if(window.ActiveXObject){
		xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xmlHttpRequest = new XMLHttpRequest() ;
	}
}

/**
* 检查账号的输入有效性
**/
function checkUserName(){
	var userValue = document.getElementById("username").value;
	var userMes = document.getElementById("nameMes");
	var userLength = userValue.length;
	var userFormat = /^\w+$/;
	if(userLength == 0){
		userMes.innerHTML = "<font color='red'>账号不能为空</font>";
	}else if(userLength < 15 && userLength > 1 && userValue.match(userFormat) != null){
	    var url = "CheckUserName?username=" + userValue;
	    createXMLHttpRequest();
	    xmlHttpRequest.open("GET", url, true);
	    xmlHttpRequest.onreadystatechange = function(){
        	if(xmlHttpRequest.readyState == 2){
        		userMes.innerHTML="<font color='red'>正在检测，请稍等</font>";
        	}else if(xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200){
                var b = xmlHttpRequest.responseText;
                if(b == "false"){
                	userMes.innerHTML="<font color='red'>该账号已存在</font>";
                }else{
                	userMes.innerHTML="<font color='green'>正确</font>";
                } 
            }
        };
	    xmlHttpRequest.send(null);
	    if(userMes.innerText == "正确")
	        return true;
	}else{
		userMes.innerHTML = "<font color='red'>账号只能由英文、数字或下划线组成，长度为2-14 位</font>";
	}
	return false;
}

//ajax+jsp实现昵称实时验证
var xmlHttpRequest1;
function createXMLHttpRequest1(){
	if(window.ActiveXObject){
		xmlHttpRequest1 = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xmlHttpRequest1 = new XMLHttpRequest() ;
	}
}

/**
* 检查昵称的输入有效性
**/
function checkNickName(){
	var nameValue = document.getElementById("nickname").value;
	var nameMes = document.getElementById("nickMes");
	var nameLength = nameValue.length;
	if(nameLength == 0){
		nameMes.innerHTML = "<font color='red'>昵称不能为空</font>";
	}else if(nameLength < 13 && nameLength > 1){
        var url = "CheckNickName?nickname=" + encodeURI(encodeURI(nameValue));
        createXMLHttpRequest1();
        xmlHttpRequest1.open("GET", url, true);
        xmlHttpRequest1.onreadystatechange = function(){
        	if(xmlHttpRequest1.readyState == 2){
        		nameMes.innerHTML="<font color='red'>正在检测，请稍等</font>";
        	}else if(xmlHttpRequest1.readyState == 4 && xmlHttpRequest1.status == 200){
                var b = xmlHttpRequest1.responseText;
                if(b == "false"){
                	nameMes.innerHTML="<font color='red'>该昵称已存在</font>";
                }else{
                	nameMes.innerHTML="<font color='green'>正确</font>";
                } 
            }
        };
        xmlHttpRequest1.send(null);
        if(nameMes.innerText == "正确")
        	return true;
	}else{
		nameMes.innerHTML = "<font color='red'>昵称长度为2~12位</font>";
	}
	return false;
}

/**
* 检查密码的输入有效性
**/
function checkPass(){
	var passValue = document.getElementById("password").value;
	var passMes = document.getElementById("pswMes");
	var passLength = passValue.length;
	if(passLength == 0){
		passMes.innerHTML = "<font color='red'>密码不能为空</font>";
		return false;
	}else if(passLength < 6){
		passMes.innerHTML = "<font color='red'>密码长度不能小于6位</font>";
		return false;
	}
	return true;
}

/**
* 实时检查检查密码强度
**/
function checkPass1(){
	var passValue = document.getElementById("password").value;
	var passMes = document.getElementById("pswMes");
	var passLength = passValue.length;	
	var mespart = "<font color='green'>密码强度：</font>";
	if(passLength > 5 && passLength < 9){
		passMes.innerHTML = mespart + "<b><font color='#BE983D'>弱</font></b>";
	}else if(passLength > 8 && passLength < 13){
		passMes.innerHTML = mespart + "<b><font color='#6B741B'>中</font></b>";
	}else if(passLength > 12 && passLength < 17){
		passMes.innerHTML = mespart + "<b><font color='green'>强</font></b>";
	}
}

/**
* 检查确认密码
**/
function checkConfirm(){
	var password1 = document.getElementById("password").value;
	var password2 = document.getElementById("repsswd").value;
	var confMes = document.getElementById("repswMes");
	if(password2.length == 0){
		confMes.innerHTML = "<font color='red'>密码不能为空</font>";
	}else if(password1 != password2){
		confMes.innerHTML = "<font color='red'>两次密码不一致</font>";
	}else{
		confMes.innerHTML = "<font color='green'>正确</font>";
		return true;
	}
	return false;
}

//ajax+jsp实现邮箱实时验证
var xmlHttpRequest2;
function createXMLHttpRequest2(){
	if(window.ActiveXObject){
		xmlHttpRequest2 = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xmlHttpRequest2 = new XMLHttpRequest() ;
	}
}

/**
* 检查邮箱
**/
function checkEmail(){
	var emailValue = document.getElementById("email").value;
	var emailMes = document.getElementById("emailMes");
	var emailLength = emailValue.length;
	var emailFormat = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	
	if(emailLength == 0){
		emailMes.innerHTML = "<font color='red'>邮箱不能为空</font>";
	}else if(emailValue.match(emailFormat) != null){
		var url = "CheckEmail?email=" + emailValue;
		createXMLHttpRequest2();
		xmlHttpRequest2.open("GET", url, true);
		
		xmlHttpRequest2.onreadystatechange = function(){
        	if(xmlHttpRequest2.readyState == 2){
        		emailMes.innerHTML="<font color='red'>正在检测，请稍等</font>";
        	}else if(xmlHttpRequest2.readyState == 4 && xmlHttpRequest2.status == 200){
                var b = xmlHttpRequest2.responseText;
                if(b == "false"){
                	emailMes.innerHTML="<font color='red'>该邮箱已存在</font>";
                }else{
                	emailMes.innerHTML="<font color='green'>正确</font>";
                } 
            }
        };
	    xmlHttpRequest2.send(null);
	    if(emailMes.innerText == "正确")
	        return true;
	}else{
		emailMes.innerHTML = "<font color='red'>请输入正确的邮箱格式</font>";
	}
	return false;
}

/**
* 检查来处
**/
function checkFrom(){
	var fromValue = document.getElementById("from").value;
	var fromMes = document.getElementById("fromMes");
	var fromLength = fromValue.length;
	if(fromLength == 0){
		fromMes.innerHTML = "<font color='red'>来自不能为空</font>";
	}else if(fromLength < 13 && fromLength > 1){
		fromMes.innerHTML = "<font color='green'>正确</font>";
		return true;
	}else{
		fromMes.innerHTML = "<font color='red'>来自长度为2~12位</font>";
	}
	return false;
}

/**
* 检查所有文本输入框的有效性
**/
function checkAll(){
	if (checkUserName() & checkNickName() & checkPass() & checkConfirm() & checkEmail() & checkFrom()){
		document.registerform.submit();
	}
}