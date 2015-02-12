/**
 * 
 */
package com.esp.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hsqldb.lib.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.esp.model.User;
import com.esp.service.NotesService;
import com.esp.service.PJ2Service;

/**
 * @author Administrator
 *
 */
@Controller
public class LoginController {

	private final PJ2Service pj2;
	private final NotesService notes;

	private static final String SESSION_USER = "user";

	/**************************************************************************
	 * Login/logout Actions
	 * ************************************************************************
	 */

	@RequestMapping("/login_submit")
	public ModelAndView login_submit(@RequestParam String log_user_id,
			@RequestParam String log_password, HttpSession session, @RequestParam String last_page)
	{
		
		/*if(StringUtil.isEmpty(log_user_id) || StringUtil.isEmpty(log_password))
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			ret.addObject("msg", "用户名或密码未填写，请重新输入");
			ret.addObject("user_id", log_user_id);
			return ret;
		}*/
		
		User user = new User();
		user.setUser_id(log_user_id);
		user.setPassword(log_password);
		if (notes.checkUser(user))
		{
			user = notes.getUser(log_user_id);
			session.setAttribute(SESSION_USER, user);

			ModelAndView ret = new ModelAndView("exp/success");
			ret.addObject("msg", "登录成功！");
			ret.addObject("alert", "1");
			ret.addObject("page", last_page);
			return ret;
		} else {
			ModelAndView ret = new ModelAndView("exp/success");
			ret.addObject("msg", "用户名或密码错误，请重新输入");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
			return ret;
		}
	}

	@RequestMapping("/CheckUserName")
	public void check_username(@RequestParam String username, HttpServletResponse response){
    	User user = notes.getUser(username);
    	String ret = "true";
    	if(user != null)
    		ret = "false";
    	
    	response.setContentType("text/html; charset=UTF-8");
    	response.setHeader("Cache-Control", "no-cache");
    	PrintWriter out;
    	try {
			out = response.getWriter();
	    	out.print(ret);
	    	out.flush();
	    	out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/CheckNickName")
	public void check_nickname(@RequestParam String nickname, HttpServletResponse response){
    	User user = notes.getUser_nick(nickname);
    	String ret = "true";
    	if(user != null)
    		ret = "false";
    	
    	response.setContentType("text/html; charset=UTF-8");
    	response.setHeader("Cache-Control", "no-cache");
    	PrintWriter out;
    	try {
			out = response.getWriter();
	    	out.print(ret);
	    	out.flush();
	    	out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/CheckEmail")
	public void check_email(@RequestParam String email, HttpServletResponse response){
    	User user = notes.getUser_email(email);
    	String ret = "true";
    	if(user != null)
    		ret = "false";
    	
    	response.setContentType("text/html; charset=UTF-8");
    	response.setHeader("Cache-Control", "no-cache");
    	PrintWriter out;
    	try {
			out = response.getWriter();
	    	out.print(ret);
	    	out.flush();
	    	out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/register_submit")
	public ModelAndView register_submit(/*@RequestParam String username,
			@RequestParam String nickname, @RequestParam String password,
			@RequestParam String email, @RequestParam String gender,
			@RequestParam String from, HttpSession session*/
			@RequestParam String user_id,
			@RequestParam String password, @RequestParam String email,
			@RequestParam String name, @RequestParam String gender,
			@RequestParam String come_from, HttpSession session)
	{
		// setup data & register
		/*User user = new User();
		user.setUser_id(username);
		user.setName(nickname);
		user.setPassword(password);
		user.setEmail(email);
		user.setGender(gender);
		user.setCome_from(from);*/
		User user = new User();
		user.setUser_id(user_id);
		user.setPassword(password);
		user.setEmail(email);
		user.setName(name);
		user.setGender(gender);
		user.setCome_from(come_from);
		
		if (pj2.register(user) == 1)
		{
			User me = notes.getUser(user_id);
			session.setAttribute(SESSION_USER, me);
			ModelAndView ret = new ModelAndView("redirect:/");
			//ret.addObject("msg", "Welcome to ESP!");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/register");
			//ret.addObject("msg", "Register error , please try again.");
			return ret;
		}
	}
	
	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */
	@Autowired
	public LoginController(PJ2Service pj2, NotesService notes)
	{
		this.pj2 = pj2;
		this.notes = notes;
	}
	
}
