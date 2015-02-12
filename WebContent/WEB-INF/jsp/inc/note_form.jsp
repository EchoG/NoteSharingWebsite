<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script language="javascript">
	function onUp(review_id) {
		alert("up note");
		$("#review_id").val(review_id);
		$("#review_operation_form").attr("action", "up_submit");
		$("#review_operation_form").submit();
	}
	
	function onForward(review_id) {
		alert("forward note");
		$("#review_id").val(review_id);
		$("#review_operation_form").attr("action", "forward_submit");
		$("#review_operation_form").submit();
	}
	
	function onStore(review_id){
		alert("store note");
		$("#review_id").val(review_id);
		$("#review_operation_form").attr("action", "store_submit");
		//$("#review_operation_form").submit();
	}

	function onRate(review_id) {
		alert("rate"+$("#rate_" + review_id).val());
		$("#review_id").val(review_id);
		$("#rate").val($("#rate_" + review_id).val());
		$("#review_operation_form").attr("action", "rate_submit");
		$("#review_operation_form").submit();
	}
	
	function onShowComment(review_id) {
		alert("onShowComment");
		var comment_div = $("#content_div_" + review_id);	
		comment_div.focus();
	}
	
	function onComment(review_id) {
		alert("comment note");
		$("#review_id").val(review_id);
		var comment_content = $("#content_div_"+review_id).val();
		//alert(comment_content);
		if(comment_content == ""){
			alert("请输入评论内容！");
		}else{
			$("#content").val(comment_content);
			$("#review_operation_form").attr("action", "comment_submit");
			$("#review_operation_form").submit();
		}
	}
	
	function onDelete(review_id) {
		alert("delete note");
		if (confirm("Do you really want to delete this review: id=" + review_id + "?")) {
			document.getElementById("delete_review_id").value = review_id;
			document.getElementById("deleteReview_form").submit();
		}
	}
	
	function onExport(review_id) {
		alert("export note");
		document.getElementById("export_review_id").value = review_id;
		document.getElementById("exportReview_form").submit();
	}
	
	function onDownload(review_id) {
		alert("download attachment");
		document.getElementById("download_review_id").value = review_id;
		document.getElementById("downloadReview_form").submit();
	}
	
</script>

<!-- 隐藏表单 -->
<form id="review_operation_form" name="note_operation_form" target="submit_frame" action="" method="post">
	<input type="hidden" id="review_id" name="review_id" value=""/>
	<input type="hidden" id="rate" name="rate" value=""/>
	<input type="hidden" id="content" name="content" value=""/>
</form>
	
<form id="deleteReview_form" name="judge_form" target="submit_frame" action="review_delete" method="post">
    <input type="hidden" id="delete_review_id" name="review_id" value=""/>
</form>
<form id="exportReview_form" name="judge_form" target="submit_frame" action="review_export" method="post">
    <input type="hidden" id="export_review_id" name="review_id" value=""/>
</form>
<form id="downloadReview_form" name="judge_form" target="submit_frame" action="review_download" method="post">
    <input type="hidden" id="download_review_id" name="review_id" value=""/>
</form>

<!-- iframe -->
<iframe name="submit_frame" id="submit_frame" hidden="true"></iframe>