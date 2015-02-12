/**
 * 
 */
package com.esp.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;
import org.hsqldb.lib.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.esp.model.Comment;
import com.esp.model.Post;
import com.esp.model.Review;
import com.esp.model.User;
import com.esp.service.NotesService;
import com.esp.service.PJ2Service;

/**
 * @author Administrator
 * 
 */
@Controller
public class NotesController
{

	private final PJ2Service PJ2Service;
	private final NotesService notesService;

	private static final String SESSION_USER = "user";
	private static final String SESSION_LAST_PAGE = "last_page";
	private static final Integer POST_SIZE = 10;
	private static final Integer COMMENT_SIZE = 10000;
	private static final String HIGHLIGHT_PREFIX = "<font class='highlight'>";
	private static final String HIGHLIGHT_SUFFIX = "</font>";
	
	/**************************************************************************
	 * NOTES business actions
	 * ************************************************************************
	 */

	/**
	 * Submit or change a new note
	 * 		the note may contain an attachment
	 * @param review_id
	 * @param user_id
	 * @param isbn
	 * @param rating
	 * @param tag
	 * @param filetype
	 * @param authority
	 * @param content
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/review_submit")
	public ModelAndView review_submit(@RequestParam Integer review_id, @RequestParam String user_id,
			@RequestParam String isbn, @RequestParam Integer rating, @RequestParam String tag,
			@RequestParam String filetype, @RequestParam Integer authority, @RequestParam String uploadfile,
			@RequestParam String content, @RequestParam Integer draftSet, HttpServletRequest request, HttpSession session)
	{
		System.out.println("review_id is " + review_id);
		System.out.println("user_id is " + user_id);
		System.out.println("isbn is " + isbn);
		System.out.println("rating is " + rating);
		System.out.println("tag is " + tag);
		System.out.println("filetype is " + filetype);
		System.out.println("uploadfile is " + uploadfile);
		System.out.println("authority is " + authority);
		System.out.println("content is " + content);
		
		ModelAndView ret = new ModelAndView("exp/success");
		
		// check whether user login
		User me = getLogedUser(session);
		if (me == null) {
			ret.addObject("msg", "请先登录！");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
			return ret;
		}
		
		// setup data & register
		Review review = new Review();		
		review.setUser_id(me.getUser_id());
		review.setIsbn(isbn);
		review.setContent(content);
		review.setRating(rating);
		review.setTag(tag);
		review.setFiletype(filetype);
		review.setUploadfile(uploadfile);

		// save as draft
		if (draftSet > 0) {
			review.setAuthority(3);
		} else
			review.setAuthority(authority);
		
		//upload file
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile multipartFile = multipartRequest.getFile("review_upfile");
        String orig_name = multipartFile.getOriginalFilename(); 
		
		if(orig_name.length() > 0){
			review.setUploadfile(orig_name);
		}
		
		// set content of the note
		String content_HTML = StringEscapeUtils.unescapeHtml(java.net.URLDecoder.decode(content));
		content_HTML = content_HTML.replaceAll(">nbsp;", " ");
		review.setContent(content_HTML);
		
		// create or update the file
		if (review_id == null || review_id == 0) {	
			// get latest id 	
			review_id = notesService.createReview(review);
		} else {
			System.err.println("update note");
			review.setReview_id(review_id);
			notesService.updateReview(review);
		}
		
		// save file
		if(orig_name.length() > 0){
			// 文件名例如： uploads/reviews/42
			String filePath = request.getRealPath(Review.UPLOAD_FILE_DIR + review_id);
			//E:\program\workspace\eclipse\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Notes/uploads\reviews\
			System.out.println(filePath);
			try {
				FileCopyUtils.copy(multipartFile.getBytes(), new File(filePath));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("review_submit: no upload file");
		}
        
		
		if(review.getAuthority() == 3){
			String lastPage = "note_draft";
			if (draftSet == 2) {
				ret.addObject("alert", "0");
				ret.addObject("refresh", "0");
				ret.addObject("callback", "parent.document.getElementById('review_id').value='" + review_id + "';");
			} else {
				ret.addObject("alert", "1");
				ret.addObject("refresh", "1");
				ret.addObject("msg", "保存草稿成功！");
				ret.addObject("page", lastPage);				
			}
		}else{
			ret.addObject("alert", "1");
			ret.addObject("refresh", "1");
			String lastPage = "note_view?id=" + review_id;
			ret.addObject("msg", "保存笔记成功！");
			ret.addObject("page", lastPage);
		}
		
		return ret;
	}
	
	@RequestMapping("/review_auto_draft")
	public void review_auto_draft(
			@RequestParam Integer review_id, 
			@RequestParam String user_id,
			@RequestParam String isbn,
			@RequestParam String content,
			HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session)
	{
		String ret = "";
		// check whether user login
		User me = getLogedUser(session);
		if (me == null) 
		{
			ret = "-1";
		}
		else
		{
			System.out.println();
			System.out.println("review_id is " + review_id);
			System.out.println("user_id is " + user_id);
			System.out.println("isbn is " + isbn);
			String content_HTML = StringEscapeUtils.unescapeHtml(java.net.URLDecoder.decode(content));
			System.out.println("content is " + content_HTML);
			System.out.println();
			
	    	// setup data & register
			Review review = new Review();		
			review.setUser_id(user_id);
			review.setIsbn(isbn);
			// set content of the note
			//String content_HTML = StringEscapeUtils.unescapeHtml(java.net.URLDecoder.decode(content));
			review.setContent(content_HTML);
			// denote draft
			review.setAuthority(3);
				
			// create or update the file
			if (review_id == null || review_id == 0) {	
			// get latest id 	
				review_id = notesService.createReview(review);
			} else {
				System.err.println("update note");
				review.setReview_id(review_id);
				notesService.updateReview(review);
			}
			ret = review_id + "";
			
		}
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
	
	/**
	 * Download note attachment if exits
	 * @param review_id
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/review_download")
	public ModelAndView review_download(@RequestParam Integer review_id,
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{	
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		
		//User me = (User) session.getAttribute(SESSION_USER);
		// setup data & register
		Review review = notesService.getReviewsById(review_id);
		//String content = review.getContent();
		System.out.println("download review id: " + review_id);
		//System.out.println("download review content is " + content);
		
		//String fileName = me.getUser_id() + "_" + "review" + review_id + ".txt";
		String fileName = review.getUploadfile();
		
		if (fileName == null) {
			System.out.println("review (id=" + review_id + ") has no upload files.");
		} else {
			response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
			
			String content = "";
			String fileLocal = request.getRealPath(Review.UPLOAD_FILE_DIR + review.getReview_id());			
			
			try {
				//InputStream is = new ByteArrayInputStream(content.getBytes("UTF-8"));
				InputStream is = new BufferedInputStream(new FileInputStream(new File(fileLocal)));
				OutputStream os = response.getOutputStream();
				byte[] b = new byte[1024];
				int length;
				while((length = is.read(b))>0){
					os.write(b,0,length);
				}
				os.flush();
				is.close();
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//ModelAndView ret = new ModelAndView("success");
			//ret.addObject("msg", "保存笔记成功！");
			//ret.addObject("alert", "1");
			
		}
		return null;
	}
	
	/**
	 * Export note operation
	 * @param review_id
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/review_export")
	public ModelAndView review_export(@RequestParam Integer review_id,
			HttpServletResponse response, HttpSession session)
	{	
		response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        
		//User me = (User) session.getAttribute(SESSION_USER);
		// setup data and download
		Review review = notesService.getReviewsById(review_id);
		String content = review.getContent();
		System.out.println("export review id: " + review_id);
		System.out.println("export review content is " + content);
		
		String fileName = "user" + review.getUser_id() + "_" + "review" + review_id + ".txt";		
		response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);

		if (content != null) {
		    try {
		    	InputStream is = new ByteArrayInputStream(content.getBytes("UTF-8"));
		        OutputStream os = response.getOutputStream();
		        byte[] b = new byte[1024];
		        int length;
		        while((length = is.read(b))>0){
		            os.write(b,0,length);
		        }
		        os.flush();
		        is.close();
		        os.close();
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
        
        return null;
	}
	
	/**
	 * Delete note operation
	 * @param review_id
	 * @param session
	 * @return
	 */
	@RequestMapping("/review_delete")
	public ModelAndView review_delete(@RequestParam Integer review_id, HttpSession session)
	{		
		
		notesService.deleteReview(review_id);
		
		ModelAndView ret = new ModelAndView("exp/success");
		ret.addObject("msg", "删除笔记成功！");
		ret.addObject("alert", "1");
		
		return ret;
		
	}
	
	/**
	 * Up note operation
	 * @param review_id
	 * @param session
	 * @return
	 */
	@RequestMapping("/up_submit")
	public ModelAndView up_submit(@RequestParam Integer review_id, HttpSession session)
	{		
		User me = (User) session.getAttribute(SESSION_USER);
		
		// check whether user login
		ModelAndView ret = new ModelAndView("exp/success");
		if (me == null) {
			ret.addObject("msg", "请先登录！");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
		} else {
			notesService.createUp(review_id, me.getUser_id());
			ret.addObject("msg", "顶笔记成功！");
			ret.addObject("alert", "1");
		}
		
		return ret;		
	}
	
	/**
	 * Forward note operation
	 * @param session
	 * @param review_id
	 * @return
	 */
	@RequestMapping("/forward_submit")
	public ModelAndView forward_submit(HttpSession session, @RequestParam Integer review_id)
	{		
		User me = (User) session.getAttribute(SESSION_USER);
		
		// check whether user login
		ModelAndView ret = new ModelAndView("exp/success");
		if (me == null) {
			ret.addObject("msg", "请先登录！");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
		} else {
			notesService.forwardReview(review_id, me.getUser_id());
			ret.addObject("msg", "分享笔记成功！");
			ret.addObject("alert", "1");
		}
		
		return ret;		
	}
	
	/**
	 * Rate note operation
	 * @param review_id
	 * @param rate
	 * @param session
	 * @return
	 */
	@RequestMapping("/rate_submit")
	public ModelAndView rate_submit(@RequestParam Integer review_id, 
			@RequestParam Integer rate, 
			HttpSession session)
	{		
		User me = (User) session.getAttribute(SESSION_USER);
		
		// check whether user login
		ModelAndView ret = new ModelAndView("exp/success");
		if (me == null) {
			ret.addObject("msg", "请先登录！");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
		} else {
			notesService.createRate(review_id, me.getUser_id(), rate);
			ret.addObject("msg", "评分成功！");
			ret.addObject("alert", "1");
		}
		
		return ret;		
	}
	
	/**
	 * Comment note operation
	 * @param review_id
	 * @param content
	 * @param session
	 * @return
	 */
	@RequestMapping("/comment_submit")
	public ModelAndView comment_submit(@RequestParam Integer review_id, 
			@RequestParam String content, HttpSession session)
	{		
		User me = (User) session.getAttribute(SESSION_USER);
		
		// check whether user login
		ModelAndView ret = new ModelAndView("exp/success");
		if (me == null) {
			ret.addObject("msg", "请先登录！");
			ret.addObject("alert", "1");
			ret.addObject("refresh", "0");
		} else {
			notesService.createComment(review_id, me.getUser_id(), content);
			ret.addObject("msg", "回复笔记成功！");
			ret.addObject("alert", "1");
		}
		
		return ret;		
	}

	/*@RequestMapping("/follow_submit")
	public @ResponseBody String follow_submit(HttpSession session, @RequestParam String user_id)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		PJ2Service.follow(me.getUser_id(), user_id);
		return "Y";
	}
	@RequestMapping("/unfollow_submit")
	public @ResponseBody String unfollow_submit(HttpSession session, @RequestParam String user_id)
	{
		User me = (User) session.getAttribute(SESSION_USER);
		PJ2Service.unfollow(me.getUser_id(), user_id);
		return "Y";
	}*/
	
	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */
	@Autowired
	public NotesController(PJ2Service pj2, NotesService notes)
	{
		this.PJ2Service = pj2;
		this.notesService = notes;
	}
		
	public static User getLogedUser(HttpSession session) {
		return (User) session.getAttribute(SESSION_USER);
	}
	
	/*public static void setLastPage(HttpSession session, String lastPage) {
		session.setAttribute(SESSION_LAST_PAGE, lastPage);		
	}
	public static String getLastPage(HttpSession session) {
		return (String) session.getAttribute(SESSION_LAST_PAGE);		
	}*/
	
}
