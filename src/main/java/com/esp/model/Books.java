/**
 * 
 */
package com.esp.model;

import java.util.Date;

/**
 * @author Echo
 *
 */
public class Books {
	
	String isbn;
	String name;
	String author;
	String translator;
	String publisher;
	String cover_pic;
	String publish_dt;
	
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTranslator() {
		return translator;
	}
	public void setTranslator(String translator) {
		this.translator = translator;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getCover_pic() {
		return cover_pic;
	}
	public void setCover_pic(String cover_pic) {
		this.cover_pic = cover_pic;
	}
	public String getPublish_dt() {
		return publish_dt;
	}
	public void setPublish_dt(String publish_dt) {
		this.publish_dt = publish_dt;
	}
		
}
