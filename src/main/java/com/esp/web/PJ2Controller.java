/**
 * 
 */
package com.esp.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hsqldb.lib.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.esp.model.Comment;
import com.esp.model.Post;
import com.esp.model.User;
import com.esp.service.PJ2Service;

/**
 * @author Administrator
 * 
 */
//@Controller
public class PJ2Controller
{

	private final PJ2Service pj2;

	private static final String SESSION_USER = "user";
	private static final Integer POST_SIZE = 10;
	private static final Integer COMMENT_SIZE = 10000;
	private static final String HIGHLIGHT_PREFIX = "<font class='highlight'>";
	private static final String HIGHLIGHT_SUFFIX = "</font>"; 

	/**************************************************************************
	 * business actions
	 * ************************************************************************
	 */

	@RequestMapping("/login_submit")
	public ModelAndView login_submit(@RequestParam String user_id,
			@RequestParam String password, HttpSession session)
	{
		User user = new User();
		user.setUser_id(user_id);
		user.setPassword(password);
		if(StringUtil.isEmpty(user_id)||StringUtil.isEmpty(password))
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			ret.addObject("msg", "用户名或密码未填写，请重新输入。");
			return ret;
		}
		if (pj2.checkUser(user))
		{
			user = pj2.getUser(user_id);
			session.setAttribute(SESSION_USER, user);
			ModelAndView ret = new ModelAndView("redirect:/");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			ret.addObject("msg", "用户名或密码错误，请重新输入。");
			ret.addObject("user_name", user_id);
			return ret;
		}
	}


	@RequestMapping("/logout_submit")
	public ModelAndView logout_submit(HttpSession session)
	{
		session.removeAttribute(SESSION_USER);
		ModelAndView ret = new ModelAndView("redirect:/");
		return ret;
	}
	
	
	
	@RequestMapping("/follow_submit")
	public @ResponseBody String follow_submit(HttpSession session, @RequestParam String user_id)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		pj2.follow(me.getUser_id(), user_id);
		return "Y";
	}
	
	@RequestMapping("/unfollow_submit")
	public @ResponseBody String unfollow_submit(HttpSession session, @RequestParam String user_id)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		pj2.unfollow(me.getUser_id(), user_id);
		return "Y";
	}

	
	
	@RequestMapping("/register_submit")
	public ModelAndView register_submit(@RequestParam String user_id,
			@RequestParam String password, @RequestParam String email,
			@RequestParam String name, @RequestParam String gender,
			@RequestParam String come_from, HttpSession session)
	{
		// duplicate user existing
		if (pj2.checkUserById(user_id))
		{
			ModelAndView ret = new ModelAndView("register");
			ret.addObject("user_id", user_id);
			ret.addObject("password", password);
			ret.addObject("email", email);
			ret.addObject("name", name);
			ret.addObject("gender", gender);
			ret.addObject("come_from", come_from);
			ret.addObject("msg", "微博账号ID\"" + user_id + "\"已被使用，请使用其他账号ID，谢谢！");

			return ret;
		}
		
		// setup data & register
		User user = new User();
		user.setUser_id(user_id);
		user.setPassword(password);
		user.setEmail(email);
		user.setName(name);
		user.setGender(gender);
		user.setCome_from(come_from);
		if (pj2.register(user) == 1)
		{
			User me = pj2.getUser(user_id);
			session.setAttribute(SESSION_USER, me);
			ModelAndView ret = new ModelAndView("redirect:/");
			ret.addObject("msg", "Welcome to ESP!");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/register");
			ret.addObject("msg", "Register error , please try again.");
			return ret;
		}
	}
	
	@RequestMapping("/post_submit")
	public ModelAndView post_submit(HttpSession session, @RequestParam String content)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			// auto cut to 140
			if (content.length() > 140) {
				content = content.substring(0, 139);
			}
			
			Post post = new Post();
			post.setContent(content);
			post.setUser_id(me.getUser_id());
			
			pj2.post(post);
			
			ModelAndView ret = new ModelAndView("redirect:/");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			return ret;
		}
	}
	
	@RequestMapping("/forward_submit")
	public ModelAndView forward_submit(HttpSession session, @RequestParam Integer ref_post_id, 
			@RequestParam String content, @RequestParam(required=false) String if_comment)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			// blank content
			if (StringUtil.isEmpty(content))
			{
				content = "转发微博";
			}
			
			// auto cut to 140			
			if (content.length() > 140) {
				content = content.substring(0, 139);
			}
			
			Post post = new Post();
			post.setRef_post_id(ref_post_id);
			post.setContent(content);
			post.setUser_id(me.getUser_id());
			
			pj2.post(post);
			
			// add comment as well
			if (if_comment != null)
			{
				Comment comment = new Comment();
				comment.setContent(content);
				comment.setReview_id(ref_post_id);
				comment.setUser_id(me.getUser_id());
				pj2.comment(comment);
			}
			
			ModelAndView ret = new ModelAndView("redirect:/");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			return ret;
		}
	}
	
	@RequestMapping("/comment_submit")
	public ModelAndView comment_submit(HttpSession session, @RequestParam Integer post_id, 
			@RequestParam String content, @RequestParam(required=false) String if_forward)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			// auto cut to 140
			if (content.length() > 140) {
				content = content.substring(0, 139);
			}
			
			Comment comment = new Comment();
			comment.setContent(content);
			comment.setReview_id(post_id);
			comment.setUser_id(me.getUser_id());
			pj2.comment(comment);

			// add ref post as well
			if (if_forward != null)
			{
				Post post = new Post();
				post.setRef_post_id(post_id);
				post.setContent(content);
				post.setUser_id(me.getUser_id());
				pj2.post(post);
			}
			
			ModelAndView ret = new ModelAndView("redirect:/");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("forward:/login");
			return ret;
		}
	}
	
	@RequestMapping("/uploadMyPortrait")
	public ModelAndView upload(HttpSession session, @RequestParam("img_file") MultipartFile img_file, 
						 HttpServletRequest request) throws IOException
    {
		ModelAndView ret = new ModelAndView("redirect:/");
		User me = (User) session.getAttribute(SESSION_USER);
		String path = request.getRealPath(me.getPortrait_large());
        FileCopyUtils.copy(img_file.getBytes(), new File(path));
        return ret;
    }


	/**************************************************************************
	 * PAGE JUMP
	 * ************************************************************************
	 */

	@RequestMapping("/")
	public ModelAndView index(HttpSession session)
	{
		return main(session, 0);
	}

	@RequestMapping("/welcome")
	public ModelAndView welcome(HttpSession session)
	{
		return new ModelAndView("redirect:/");
	}

	@RequestMapping("/main")
	public ModelAndView main(HttpSession session, @RequestParam Integer s)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("main");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getFollowedPosts(me.getUser_id(), s, POST_SIZE);
			pj2.loadCommentsForPosts(posts, COMMENT_SIZE);
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("s", s);
			ret.addObject("page", "main");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}

	@RequestMapping("/myPosts")
	public ModelAndView myPosts(HttpSession session, @RequestParam Integer s)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("main");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getPostsByUser(me.getUser_id(), s, POST_SIZE);
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("s", s);
			ret.addObject("page", "myPosts");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}

	@RequestMapping("/onesPosts")
	public ModelAndView onesPosts(HttpSession session, String user_id,
			@RequestParam Integer s)
	{
		ModelAndView ret = new ModelAndView("main");
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			Set<String> mf_set = pj2.getMyFollowSet(me.getUser_id());
			ret.addObject("mf_set", mf_set);
		}
		List<User> hot_users = pj2.getHotUsers(0, 9);
		List<Post> posts = pj2.getPostsByUser(user_id, s, 10);
		User tar_user = pj2.getUser(user_id);

		ret.addObject("current_user", me);
		ret.addObject("tar_user", tar_user);
		ret.addObject("hot_users", hot_users);
		ret.addObject("posts", posts);
		ret.addObject("s", s);
		ret.addObject("page", "onesPosts");
		return ret;
	}

	@RequestMapping("/plaza")
	public ModelAndView plaza(HttpSession session, @RequestParam Integer s)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("main");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getAllPosts(s, POST_SIZE);
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("s", s);
			ret.addObject("page", "plaza");
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}


	@RequestMapping("/myFans")
	public ModelAndView search_myFans(HttpSession session, @RequestParam Integer s)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("search");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getAllPosts(s, 10);
			List<User> fans = pj2.getFans(0, 5, me.getUser_id());
			Set<String> mf_set = pj2.getMyFollowSet(me.getUser_id());
			pj2.loadCommentsForPosts(posts, COMMENT_SIZE);
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("page", "search_myFans");
			ret.addObject("fans",fans);
			ret.addObject("mf_set", mf_set);
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}
	
	@RequestMapping("/myFollows")
	public ModelAndView search_follow(HttpSession session, @RequestParam Integer s)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("search");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getAllPosts(s, 10);
			List<User> toFollows = pj2.getMyFollows(me.getUser_id(), 0, 5);
			pj2.loadCommentsForPosts(posts, COMMENT_SIZE);
			Set<String> mf_set = pj2.getMyFollowSet(me.getUser_id());
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("page", "search_to_follow");
			ret.addObject("toFollows", toFollows);
			ret.addObject("mf_set",mf_set);
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}

@RequestMapping("/search")
	public ModelAndView search(HttpSession session, @RequestParam Integer s, @RequestParam String kw)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		if (me != null)
		{
			ModelAndView ret = new ModelAndView("search");
			List<User> hot_users = pj2.getHotUsers(0, 9);
			List<Post> posts = pj2.getAllPosts(s, 10);
			List<User> users = pj2.getSomeUsers(kw, s, 5);
			for(User user : users){
				user.setName(StrHighlight.highlight(user.getName(), kw,
						HIGHLIGHT_PREFIX, HIGHLIGHT_SUFFIX));
			}
			List<Post> somePosts = pj2.getSomePosts(kw, s, 5);
			for(Post post : somePosts){
				post.setContent(StrHighlight.highlight(post.getContent(), kw,
						HIGHLIGHT_PREFIX, HIGHLIGHT_SUFFIX));
			}
			Set<String> mf_set = pj2.getMyFollowSet(me.getUser_id());
			pj2.loadCommentsForPosts(posts, COMMENT_SIZE);
			ret.addObject("current_user", me);
			ret.addObject("hot_users", hot_users);
			ret.addObject("posts", posts);
			ret.addObject("page", "search");
			ret.addObject("kw",kw);
			ret.addObject("users",users);	
			ret.addObject("somePosts",somePosts);
			ret.addObject("mf_set",mf_set);	
			
			return ret;
		} else
		{
			ModelAndView ret = new ModelAndView("redirect:/login");
			return ret;
		}
	}


	@RequestMapping("/login")
	public ModelAndView login(HttpSession session)
	{
		ModelAndView ret = new ModelAndView("login");
		User me = (User) session.getAttribute(SESSION_USER);
		List<User> hot_users = pj2.getHotUsers(0, 9);
		List<User> latest_users = pj2.getLatestUsers(0, 9);
		List<Post> posts = pj2.getAllNonRefPosts(0, 3);
		ret.addObject(SESSION_USER, me);
		ret.addObject("hot_users", hot_users);
		ret.addObject("latest_users", latest_users);
		ret.addObject("posts", posts);
		return ret;
	}

	@RequestMapping("/register")
	public ModelMap register(HttpSession session)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		ModelMap ret = new ModelMap(SESSION_USER, me);

		return ret;
	}

	@RequestMapping("/logout")
	public ModelAndView check(HttpSession session)
	{
		session.removeAttribute(SESSION_USER);
		ModelAndView ret = new ModelAndView("redirect:/");
		return ret;
	}
	
	@RequestMapping("/error")
	public ModelAndView error(HttpSession session)
	{
		ModelAndView ret = new ModelAndView("error");
		return ret;
	}

	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */

	@Autowired
	public PJ2Controller(PJ2Service pj2)
	{
		this.pj2 = pj2;
	}
}
