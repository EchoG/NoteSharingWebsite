/**
 * 
 */
package com.esp.model;

/**
 * @author Administrator
 *
 */
public class User {
	
	String user_id; 
	String name;
	String password;
	String portrait_small = "img/people/person1.png";
	String portrait_large = "img/user2.jpg";
	String gender;
	String come_from;
	String email;
	
	Integer follow_count;
	Integer fans_count;
	Integer post_count; 
	Integer sort_ind;
	
	// recent post info
	String recent_post_content;
	String recent_post_time;
	
	// relation with current user
	Boolean isFollow;
	Boolean isFan;

	/**************************************************************************
	 * g/setter
	 * ************************************************************************
	 */
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPortrait_small() {
		return portrait_small;
	}
	public void setPortrait_small(String portrait_small) {
		this.portrait_small = portrait_small;
	}
	public String getPortrait_large() {
		return portrait_large;
	}
	public void setPortrait_large(String portrait_large) {
		this.portrait_large = portrait_large;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getFollow_count() {
		return follow_count;
	}
	public void setFollow_count(Integer follow_count) {
		this.follow_count = follow_count;
	}
	public Integer getFans_count() {
		return fans_count;
	}
	public void setFans_count(Integer fans_count) {
		this.fans_count = fans_count;
	}
	public Integer getPost_count() {
		return post_count;
	}
	public void setPost_count(Integer post_count) {
		this.post_count = post_count;
	}
	public Integer getSort_ind() {
		return sort_ind;
	}
	public void setSort_ind(Integer sort_ind) {
		this.sort_ind = sort_ind;
	}
	public String getGender()
	{
		return gender;
	}
	public void setGender(String gender)
	{
		this.gender = gender;
	}
	public String getCome_from()
	{
		return come_from;
	}
	public void setCome_from(String come_from)
	{
		this.come_from = come_from;
	}

	public String getRecent_post_content()
	{
		return recent_post_content;
	}
	public void setRecent_post_content(String recent_post_content)
	{
		this.recent_post_content = recent_post_content;
	}
	public String getRecent_post_time()
	{
		return recent_post_time;
	}
	public void setRecent_post_time(String recent_post_time)
	{
		this.recent_post_time = recent_post_time;
	}
	public Boolean getIsFollow()
	{
		return isFollow;
	}
	public void setIsFollow(Boolean isFollow)
	{
		this.isFollow = isFollow;
	}
	public Boolean getIsFan()
	{
		return isFan;
	}
	public void setIsFan(Boolean isFan)
	{
		this.isFan = isFan;
	}
	
	
}
