// JavaScript Document

// init Rich Test Box
$(function() {
	if (content)
		init("content_div", content);
	else
		init("content_div");

	// $d = $("#editor")[0].contentWindow.document; // IE、FF都兼容
	// $d.designMode="on";
	// $d.contentEditable= true;
	// $d.open();
	// $d.close();
	// $("body", $d).append("<div>A</div><div>B</div><div>C</div>");

	// $('#insert_img').click(function(){
	// // 在iframe中插入一张图片
	// var img = '<img src="' + $('#path').val() +'" />';
	// $("body", $d).append(img);
	// });

	// $('#preview').click(function(){
	// // 获取iframe的body内容，用于显示或者插入到数据库
	// alert($('#editor').contents().find('body').html());
	// $('#preview_area').html($('#editor').contents().find('body').html());

	// });
});

function HTMLEnCode(str) {
	var s = "";
	if (str.length == 0)
		return "";
	s = str.replace(/&/g, "&gt;");
	s = s.replace(/</g, "&lt;");
	s = s.replace(/>/g, "&gt;");
	s = s.replace(/    /g, "&nbsp;");
	s = s.replace(/\'/g, "'");
	s = s.replace(/\"/g, "&quot;");
	s = s.replace(/\n/g, "<br>");
	return s;
}

function HTMLDeCode(str) {
	var s = "";
	if (str.length == 0)
		return "";
	s = str.replace(/&gt;/g, "&");
	s = s.replace(/&lt;/g, "<");
	s = s.replace(/&gt;/g, ">");
	s = s.replace(/&nbsp;/g, "    ");
	s = s.replace(/'/g, "\'");
	s = s.replace(/&quot;/g, "\"");
	s = s.replace(/<br>/g, "\n");
	return s;
}

// --------------------------- 标签相关 ------------------------------
function addTag(tag) {
	var tag_input = $("#newtag_input");
	var existing = tag_input.val();
	if (existing) {
		tag_input.val(existing + " " + tag);
	} else {
		tag_input.val(tag);
	}	
}

function showNewtag(){
	document.getElementById("back").style.display = "block";
	document.getElementById("newtag").style.display = "block";
	$('#newtag').center({position:'fixed',top:'50%'});
	var tag_input = $("#newtag_input");
	tag_input.val($("#tag_input").val());
}

function confirmTag() {
	var tagstr = $("#newtag_input").val();
	$("#newtag_input").val("");
	var tagstrs = tagstr.split("\\s+");
	console.log(tagstrs);
	var tagArr = [];
	var tags = "";
	for (var i=0; i<tagstrs.length; i++) {
		console.log(tagstrs[i]);
		if (i > 4) {
			alert("有效标签超过5个，将忽略多出的标签！");
			break;
		}
		if (!tagArr.contains(tagstrs[i])) {
			tagArr.push(tagstrs[i]);
			tags += tagstrs[i] + " ";
		}
	}
	
	$("#tag_show").html("标签：" + tags.trim());
	$("#tag_input").val(tags.trim());
	closeNewTag();
}

function closeNewTag(){
	document.getElementById("back").style.display = "none";
	document.getElementById("newtag").style.display = "none";
}

//--------------------------- 文集相关 ------------------------------
function showNewtype(){
	document.getElementById("back").style.display = "block";
	document.getElementById("newtype").style.display = "block";
	$('#newtype').center({position:'fixed',top:'50%'});
}

function hideNewtype(){
	document.getElementById("back").style.display = "none";
	document.getElementById("newtype").style.display = "none";
}

function checkNewtype(){
	var maxlimit = 14;
	var element = document.getElementById("newtype_input");
	var value = trim(element.value);
	var length = value.length;
	if( length > maxlimit ){
		value = value.substr(0, 14);
	}
	element.value = value;
	return value;
}

function submitNewtype(){
	var new_type_input = $("#newtype_input");
	var value = trim(new_type_input.val());
	var length = value.length;
	if(length == 0)
		alert("请输入文集名称");
	else{
		var new_type = checkNewtype();
		var existing_types = $("#filetype > option");
		for (var i=0; i< existing_types.length; i++) {
			if (new_type == existing_types[i].value) {
				alert("已有相同名称相册，请重新填写！");
				return;
			}
		}
		// no duplicate
		$("#filetype").append("<option selected>" + new_type + "</option>");
		new_type_input.val("");
		hideNewtype();
	}
}

/* check new tag */
function checkNewtag(){
	var element = document.getElementById("newtag_input");
	var value = ltrim(element.value);
	var tags = value.split(/\s+/g);
	var length = tags.length;
	if(length > 5)
		length = 5;
	
	var maxlimit = 14;
	var result = "";
	for(var i = 0; i < length; i++){
		if(tags[i].length > maxlimit)
			tags[i] = tags[i].substr(0, 14);
		if(i != length - 1)
			result += tags[i] + " ";
		else
			result += tags[i];
	}
	element.value = result;
	return tags;	
}

Array.prototype.contains = function(item){
    for(var i=0;i<this.length;i++){
        if(this[i]==item){return true;}
    }
    return false;
};

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g, '');
};