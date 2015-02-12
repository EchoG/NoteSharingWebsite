/**
 * 
 */
package com.esp.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author Administrator
 *
 */
public class Post
{
	Integer post_id;
	Integer ref_post_id = null;
	String user_id;
	String content;
	Date create_time;
	String create_time_str = "";
	String send_source = "BON iPad Ware";
	
	Integer forward_count = 0;
	Integer favorite_count = 0;
	Integer comment_count = 0;
	
	// POSTER INFORMATION
	String user_name;
	String user_image;

	// REFERENCE POST INFORMATION
	String ref_user_id;
	String ref_user_name;
	String ref_user_image;
	String ref_content;
	Integer ref_forward_count;
	Integer ref_comment_count;
	
	// COMMENT LIST, FOR VIEW
	List<Comment> comments = new ArrayList<Comment>();

	/**************************************************************************
	 * g/setter
	 **************************************************************************
	 */
	
	public Integer getPost_id()
	{
		return post_id;
	}
	public void setPost_id(Integer post_id)
	{
		this.post_id = post_id;
	}
	public Integer getRef_post_id() {
		return ref_post_id;
	}
	public void setRef_post_id(Integer ref_post_id) {
		this.ref_post_id = ref_post_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getCreate_time_str() {
		return create_time_str;
	}
	public void setCreate_time_str(String create_time_str) {
		this.create_time_str = create_time_str;
	}
	public String getSend_source() {
		return send_source;
	}
	public void setSend_source(String send_source) {
		this.send_source = send_source;
	}
	public Integer getForward_count() {
		return forward_count;
	}
	public void setForward_count(Integer forward_count) {
		this.forward_count = forward_count;
	}
	public Integer getFavorite_count() {
		return favorite_count;
	}
	public void setFavorite_count(Integer favorite_count) {
		this.favorite_count = favorite_count;
	}
	public Integer getComment_count() {
		return comment_count;
	}
	public void setComment_count(Integer comment_count) {
		this.comment_count = comment_count;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_image() {
		return user_image;
	}
	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}
	public String getRef_user_id()
	{
		return ref_user_id;
	}
	public void setRef_user_id(String ref_user_id)
	{
		this.ref_user_id = ref_user_id;
	}
	public String getRef_user_name() {
		return ref_user_name;
	}
	public void setRef_user_name(String ref_user_name) {
		this.ref_user_name = ref_user_name;
	}
	public String getRef_user_image() {
		return ref_user_image;
	}
	public void setRef_user_image(String ref_user_image) {
		this.ref_user_image = ref_user_image;
	}
	public String getRef_content() {
		return ref_content;
	}
	public void setRef_content(String ref_content) {
		this.ref_content = ref_content;
	}
	public Integer getRef_forward_count() {
		return ref_forward_count;
	}
	public void setRef_forward_count(Integer ref_forward_count) {
		this.ref_forward_count = ref_forward_count;
	}
	public Integer getRef_comment_count() {
		return ref_comment_count;
	}
	public void setRef_comment_count(Integer ref_comment_count) {
		this.ref_comment_count = ref_comment_count;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	
}
