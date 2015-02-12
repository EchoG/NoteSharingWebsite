/**
 * 
 */
package com.esp.model;

import java.util.Date;

/**
 * @author Echo
 *
 */
public class Comment {
	
	Integer comment_id;
	Integer review_id;
	String user_id;
	String content;
	Date create_time;
	String create_time_str;
	
	String user_name;
	String user_image_small;

	/**************************************************************************
	 * g/setter
	 * ************************************************************************
	 */
	
	public Integer getComment_id() {
		return comment_id;
	}
	public void setComment_id(Integer comment_id) {
		this.comment_id = comment_id;
	}
	public Integer getReview_id() {
		return review_id;
	}
	public void setReview_id(Integer review_id) {
		this.review_id = review_id;
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
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_image_small() {
		return user_image_small;
	}
	public void setUser_image_small(String user_image_small) {
		this.user_image_small = user_image_small;
	}
	
	
	
}
