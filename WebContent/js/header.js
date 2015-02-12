function show_notes(tag) {
	if (tag != null) $("#search_tag").val(tag);
	$("#searchform").submit();
}