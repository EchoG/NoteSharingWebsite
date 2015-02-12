/**
 * 
 */
package com.esp.model;

/**
 * @author Echo
 *
 */
public class Follows {
	String user_id; 
	String follower_id;
	
	
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
	public String getFollower_id() {
		return follower_id;
	}
	public void setFollower_id(String follower_id) {
		this.follower_id = follower_id;
	}
	
	
	
}
