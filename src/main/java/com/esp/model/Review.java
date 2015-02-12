package com.esp.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


/**
 * @author Echo
 *
 */
public class Review {	

	public final static String UPLOAD_FILE_DIR = "uploads/reviews/";
	
	// TABLE FILEDS
	Integer review_id;
	String isbn;
	String user_id;
	Integer rating;
	String content;
	String tag;
	Integer forward_id;
	String forward_user;	
	String filetype;	
	String uploadfile;	
	Integer authority;
	Timestamp pubtime;
	
	// JOINED FILEDS
	String book_name;
	String user_name;
	Double avg_rate;
	Integer count_up;	
	Integer my_rate;
	Integer my_count_up;	
	
	List<Comment> comments = new ArrayList<Comment>();
	
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public Integer getAuthority() {
		return authority;
	}
	public void setAuthority(Integer authority) {
		this.authority = authority;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public Integer getForward_id() {
		return forward_id;
	}
	public void setForward_id(Integer forward_view_id) {
		this.forward_id = forward_view_id;
	}
	
	public String getForward_user() {
		return forward_user;
	}
	public void setForward_user(String forward_user) {
		this.forward_user = forward_user;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public Integer getReview_id() {
		return review_id;
	}
	public void setReview_id(Integer review_id) {
		this.review_id = review_id;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getRating() {
		return rating;
	}
	public void setRating(Integer rating) {
		this.rating = rating;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Double getAvg_rate() {
		return avg_rate;
	}
	public void setAvg_rate(Double avg_rate) {
		this.avg_rate = avg_rate;
	}
	public Integer getCount_up() {
		return count_up;
	}
	public void setCount_up(Integer count_up) {
		this.count_up = count_up;
	}
	public Integer getMy_rate() {
		return my_rate;
	}
	public void setMy_rate(Integer my_rate) {
		this.my_rate = my_rate;
	}
	public Integer getMy_count_up() {
		return my_count_up;
	}
	public void setMy_count_up(Integer my_count_up) {
		this.my_count_up = my_count_up;
	}
	
	public String getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(String uploadfile) {
		this.uploadfile = uploadfile;
	}
	
	public Timestamp getPubtime() {
		return pubtime;
	}
	public void setPubTime(Timestamp pubtime) {
		this.pubtime = pubtime;
	}

}
