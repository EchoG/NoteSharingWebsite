/**
 * 
 */
package com.esp.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.esp.model.FileType;
import com.esp.model.Review;
import com.esp.model.Tag;
import com.esp.model.User;
import com.esp.service.NotesService;
import com.esp.service.PJ2Service;

/**
 * @author Administrator
 *
 */
@Controller
public class PageController {

	private final PJ2Service pj2;
	private final NotesService notes;

	private static final String SESSION_USER = "user";

	
	/**************************************************************************
	 * COMMON PAGE JUMP
	 * ************************************************************************
	 */
	@RequestMapping("/")
	public ModelAndView main(HttpSession session)
	{
		//return main("all", session);
		return note_recmd("all", null, session);
	}
		
	@RequestMapping("/index")
	public ModelAndView index(HttpSession session)
	{
		//return main("all", session);
		return note_recmd("all", null, session);
		
	}
	
	@RequestMapping("/error")
	public ModelAndView error(HttpSession session)
	{
		ModelAndView ret = new ModelAndView("exp/error");
		return ret;
	}
	
	/*@RequestMapping("/login")
	public ModelAndView login(HttpSession session) {
		ModelAndView ret = new ModelAndView("inc/login");
		return ret;
	}*/
	
	@RequestMapping("/logout")
	public ModelAndView check(HttpSession session)
	{
		session.removeAttribute(SESSION_USER);
		ModelAndView ret = new ModelAndView("redirect:/");
		return ret;
	}
	
	@RequestMapping("/register")
	public ModelMap register(HttpSession session)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		ModelMap ret = new ModelMap(SESSION_USER, me);
		ret.addObject("me", me);
		
		return ret;
	}
	
	/**************************************************************************
	 * NOTES PAGE JUMP
	 * ************************************************************************
	 */
	/*@RequestMapping("/main")
	public ModelAndView main(@RequestParam String tag, HttpSession session)
	{
			ModelAndView ret = new ModelAndView("note_show");
			
			if(tag == null){
				System.out.println("no parameter");
			}
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);
			String my_id = null;
			if(me != null)
				my_id = me.getUser_id();
			
			// set menu
			ret.addObject("menu", "main");
			
			// set reviews by tag
			List<Review> reviews = new ArrayList<Review>();
			if(tag.equals("novel")){
				reviews = notes.getUserReviewsByTag( my_id, my_id, "小说");
			}else if(tag.equals("prose")){
				reviews = notes.getUserReviewsByTag( my_id, my_id, "散文");
			}else if(tag.equals("causerie")){
				reviews = notes.getUserReviewsByTag( my_id,my_id, "随笔");
			}else if(tag.equals("manage")){
				reviews = notes.getUserReviewsByTag( my_id, my_id, "管理");
			}else if(tag.equals("all")){
				reviews = notes.getUserReviews(my_id, my_id);
			}
			
			for(Review review: reviews){
				review.setComments(notes.getCommentsByReview_id(review));
			}
			ret.addObject("reviews", reviews);
			ret.addObject("tag", tag);
			
			return ret;
		
	}*/

	@RequestMapping("/note_recmd")
	public ModelAndView note_recmd(@RequestParam(required = false) String tag, 
								   @RequestParam(required = false) String keywords, 
								   HttpSession session) {
			ModelAndView ret = new ModelAndView("note_show");			
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);
			String my_id = null;
			if (me != null) my_id = me.getUser_id();			
			// set menu
			ret.addObject("menu", "note_recmd");			
			// set reviews by tag
			List<Review> reviews = new ArrayList<Review>();
			if(tag == null || "all".equals(tag)){
				reviews = notes.getReviews(my_id, null, my_id, null, null, keywords);
			} else {
				reviews = notes.getReviews(my_id, null, my_id, tag, null, keywords);
			}
			
			// count all
			Integer countAll = notes.countAllReviews(null, my_id);
			// tags
			List<Tag> tags = notes.getAllTags(my_id);
			
			for(Review review: reviews){
				review.setComments(notes.getCommentsByReview_id(review));
			}			
			ret.addObject("reviews", reviews);
			ret.addObject("tag", tag);
			ret.addObject("countAll", countAll);			
			ret.addObject("tags", tags);			
			ret.addObject("keywords", keywords);
			return ret;		
	}	
	
	@RequestMapping("/author_recmd")
	public ModelAndView author_recmd(HttpSession session)
	{		
			ModelAndView ret = new ModelAndView("author_show");
			
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);			
			// set menu
			ret.addObject("menu", "author_recmd");			
			// set all authors
			List<User> users = notes.getAllUsers();
			ret.addObject("users", users);
			
			return ret;		
	}	
	
	@RequestMapping("/note_user")
	public ModelAndView note_user(@RequestParam String id, @RequestParam String notebook, 
			@RequestParam String notetype, HttpSession session)
	{
		
			ModelAndView ret = new ModelAndView("note_user");
			
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);
			String my_id = null;
			if(me != null)
				my_id = me.getUser_id();

			// count all
			Integer countAll = notes.countAllReviews(my_id, null);
			// file types
			List<FileType> fileTypes = notes.getAllFiletype(my_id);
			
			// set page user
			User user = notes.getUser(id);
			ret.addObject("pageuser", user);
			
			// set all page user's reviews
			List<Review> reviews = new ArrayList<Review>();
			if(notetype.equals("self")){
				// not sure if it's correct
				//notebook = notebook;
				if (notebook == null || "all".equals(notebook) || notebook.length() ==0) 
					notebook = null;
				else
					try {
						notebook = URLDecoder.decode(notebook, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				
				reviews = notes.getReviewsByUserByFileType(my_id, id, notebook);				
			}else if(notetype.equals("share")){
				System.out.println("user: get shared reviews");
			}else if(notetype.equals("store")){
				System.out.println("user: get stored reviews");
			}
			
			for(Review review: reviews){
				review.setComments(notes.getCommentsByReview_id(review));
			}
			ret.addObject("reviews", reviews);
			ret.addObject("notetype",notetype);
			ret.addObject("notebook", notebook);
			ret.addObject("countAll", countAll);
			ret.addObject("fileTypes", fileTypes);
			
			return ret;
		
	}
	
	@RequestMapping("/note_view")
	public ModelAndView note_view(@RequestParam Integer id, HttpSession session)
	{
		
			ModelAndView ret = new ModelAndView("note_view");
			
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);
			String my_id = null;
			if(me != null)
				my_id = me.getUser_id();
			
			// set specific review and comments
			Review review = notes.getReviewsById(id, my_id);
			if(review != null && review.getAuthority() != 3){
				review.setComments(notes.getCommentsByReview_id(review));
				ret.addObject("review", review);
			}			
			return ret;
		
	}
	
	/*
	 *  No session user will not access this page 
	 */
	@RequestMapping("/note_create")
	public ModelAndView note_create(/*@RequestParam String last_page, */HttpSession session)
	{

		User me = (User) session.getAttribute(SESSION_USER);	
		if (me == null) return new ModelAndView("redirect:index");
		
		ModelAndView ret = new ModelAndView("note_edit");
		
		// tags
		List<Tag> tags = notes.getAllTags(null, true);
		// file types
		List<FileType> fileTypes = notes.getAllFiletype(me.getUser_id());
		
		//NotesController.setLastPage(session, java.net.URLDecoder.decode(last_page));
		ret.addObject("action", "create");
		ret.addObject("tags", tags);
		ret.addObject("fileTypes", fileTypes);
		ret.addObject("autoSave", "1");
		
		// set session user
		ret.addObject("me", me);
		return ret;
	}
	
	@RequestMapping("/note_edit")
	public ModelAndView note_edit(@RequestParam Integer id, HttpSession session)
	{
		User me = (User) session.getAttribute(SESSION_USER);	
		if (me == null) return new ModelAndView("redirect:index");
		
		ModelAndView ret = new ModelAndView("note_edit");
		// tags
		List<Tag> tags = notes.getAllTags(null, true);
		// file types
		List<FileType> fileTypes = notes.getAllFiletype(me.getUser_id());
		
		
		ret.addObject("action", "edit");
		ret.addObject("tags", tags);
		ret.addObject("fileTypes", fileTypes);
		System.out.println("editing note (id = " + id + ")");
		
		// set session user
		ret.addObject("me", me);
		
		// Update Review
		if(id != null){
			Review review = notes.getReviewsById(id);
			if(review != null && me != null 
					&& review.getUser_id().equals(me.getUser_id()))
				ret.addObject("review", review);
		}
		
		return ret;		
	}
	
	@RequestMapping("/note_draft")
	public ModelAndView note_draft(HttpSession session)
	{
		
			ModelAndView ret = new ModelAndView("note_draft");
			
			// set session user
			User me = (User) session.getAttribute(SESSION_USER);
			ret.addObject("me", me);
			
			// set all page user's reviews
			if(me != null){
				List<Review> reviews = notes.getReviewDraftByUser(me.getUser_id());			
				for(Review review: reviews){
					review.setComments(notes.getCommentsByReview_id(review));
				}
				ret.addObject("reviews", reviews);
			}
			
			return ret;
		
	}
	
	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */
	@Autowired
	public PageController(PJ2Service pj2, NotesService notes)
	{
		this.pj2 = pj2;
		this.notes = notes;
	}
	
}
