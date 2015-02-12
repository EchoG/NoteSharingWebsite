/**
 * 
 */
package com.esp.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.jmx.export.annotation.ManagedResource;
import org.springframework.stereotype.Service;

import com.esp.model.Comment;
import com.esp.model.Post;
import com.esp.model.User;


/**
 * @author Echo
 * 
 */
@Service
@ManagedResource("pj2:type=PJ2")
public class PJ2Service
{
	private static Logger LOG = Logger.getLogger(PJ2Service.class);
	private JdbcTemplate jdbcTemplate;
	
	public static final SimpleDateFormat DATE_FORMATER = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat DATE_TIME_FORMATER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Autowired
	public void init(DataSource dataSource)
	{
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	/**************************************************************************
	 * update actions
	 * ************************************************************************
	 */
	
	/**
	 * @param user_id
	 *            ,password,email,nickname,gender
	 * @return
	 */
	public int register(User user)
	{
		int ret = this.jdbcTemplate
				.update("INSERT INTO `user` (user_id, name, password, gender, email, come_from, create_time, portrait_small, portrait_large) " +
						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
						new Object[] { user.getUser_id(), user.getName(), user.getPassword(),
								user.getGender(), user.getEmail(), user.getCome_from(), new Date(),
								user.getPortrait_small(), user.getPortrait_large()
								});
		return ret;
	}
	
	/**
	 * @param post
	 * @return
	 */
	public int post(Post post)
	{
		Date now = new Date();
		int ret = this.jdbcTemplate
				.update("INSERT INTO post (ref_post_id, user_id, content, create_time, create_time_str, send_source, favorite_count) " +
						"VALUES (?, ?, ?, ?, ?, ?, ?)",
						new Object[] { 	post.getRef_post_id(), post.getUser_id(), post.getContent(), now, this.getTimeStr(now), 
										post.getSend_source(), post.getFavorite_count()
				});
		return ret;
	}

	/**
	 * @param comment
	 * @return
	 */
	public int comment(Comment comment)
	{
		Date now = new Date();
		int ret = this.jdbcTemplate
				.update("INSERT INTO comment (post_id, user_id, content, create_time, create_time_str) "+
						"VALUES (?, ?, ?, ?, ?)",
						new Object[] { comment.getReview_id(), comment.getUser_id(), comment.getContent(), 
										now, this.getTimeStr(now)
				});
		
		return ret;
	}
	
	/**
	 * @param comment
	 * @return
	 */
	public int follow(String follower_id, String tar_id)
	{
		int ret = this.jdbcTemplate
				.update("INSERT INTO follows (`user_id`, `follower_id`) values " +
						"(?, ?)",
						new Object[] {tar_id, follower_id });
		return ret;
	}
	
	/**
	 * @param comment
	 * @return
	 */
	public int unfollow(String follower_id, String tar_id)
	{
		int ret = this.jdbcTemplate
				.update("DELETE FROM follows where `user_id` = ? and `follower_id` = ? ",
						new Object[] {tar_id, follower_id });
		return ret;
	}

	/**************************************************************************
	 * query actions
	 * ************************************************************************
	 */
	/**
	 * @param user_id
	 * @return
	 */
	public User getUser(String user_id)
	{
		@SuppressWarnings("deprecation")
		List<User> users = this.jdbcTemplate
				.query("SELECT * "
						+ " FROM vw_counted_user "
						+ " WHERE user_id = ? "
						+ " ORDER BY sort_ind ASC",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
						new Object[] { user_id });

		if (users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	public Boolean checkUserById(String user_id)
	{
		List users = this.jdbcTemplate
				.query("SELECT * "
						+ " FROM vw_counted_user "
						+ " WHERE user_id = ? ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
						new Object[] { user_id });

		if (users.size() > 0)
			return true;
		else
			return false;
	}
	

	public Boolean checkUser(User user)
	{
		List pers = query("SELECT * "
						+ " FROM vw_counted_user "
						+ " WHERE user_id = ? "
						+ " AND password = ? " + " ORDER BY user_id, password",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
						new Object[] { user.getUser_id(), user.getPassword() });

		if (pers.size() > 0)
			return true;
		else
			return false;
	}

	
	/**
	 * @return
	 */
	public List<User> getLatestUsers(int from, int count)
	{
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all vets.
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query( "select u.* " +
						"from vw_counted_user u "+
						"order by user_id desc "+
						"LIMIT "+ from + "," + count,
						ParameterizedBeanPropertyRowMapper
						.newInstance(User.class));
		ret.addAll(users);
		
		return ret;
	}
	
	/**
	 * @return
	 */
	public List<User> getHotUsers(int from, int count)
	{
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all vets.
		ret.clear();
		List<User> users = this.jdbcTemplate
			.query( "select u.* from vw_counted_user u "+
					"order by fans_count desc "+
					"LIMIT "+ from + "," + count,
					ParameterizedBeanPropertyRowMapper
							.newInstance(User.class));
		ret.addAll(users);

		return ret;
	}
	

	/**
	 * @return
	 */
	public List<User> getAllUsers(int from, int count)
	{
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all vets.
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query("SELECT * " +
						"FROM vw_counted_user " +
						"ORDER BY sort_ind ASC " + 
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class));
		ret.addAll(users);

		return ret;
	}
	
	
	/**
	 * @return
	 */
	public List<User> getSomeUsers(String keyWord, int from, int count)
	{
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all vets.
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query("select u.*, "+
					   "p.content as recent_post_content,  "+ 
					   "p.create_time_str as recent_post_time "+ 
					   "from vw_counted_user u, vw_full_post p, follows f "+
					   "where  "+
					   "u.user_id = f.follower_id "+
					   "and LCASE(u.name) like ? "+ 
					   "and p.post_id =  "+ 
					   "(select max(p.post_id) from post p "+ 
					   "where p.user_id = u.user_id) " +
					   "group by u.user_id "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
								new Object[]{"%" + keyWord.toLowerCase() + "%"});
		ret.addAll(users);

		return ret;
	}
	
	
	/**
	 * @return
	 */
	public List<Post> getSomePosts(String keyWord, int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select p.* "+
						"from vw_full_post p "+
						"where p.content like ? "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(Post.class),
								new Object[]{"%" + keyWord + "%"});
		ret.addAll(posts);

		return ret;
	}
	
	/**
	 * @return
	 */
	public List<Post> getAllNonRefPosts(int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select p.* "+
						"from vw_full_post p " +
						"where p.ref_post_id is NULL "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Post.class));
		ret.addAll(posts);
		
		return ret;
	}

	/**
	 * @return
	 */
	public List<Post> getAllPosts(int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select p.* "+
						"from vw_full_post p "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(Post.class));
		ret.addAll(posts);

		return ret;
	}
	
	/**
	 * @return
	 */
	public List<Post> getMyConcernedPosts(String follower_id, int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select * from vw_full_post p "+
						"left join follows f on p.user_id = f.user_id "+
						"where f.follower_id = ? or p.user_id = ? " +
						"group by p.post_id " +
						"order by p.post_id desc "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Post.class),
						new Object[]{follower_id, follower_id});
		ret.addAll(posts);
		
		return ret;
	}
	
	/**
	 * @return
	 */
	public List<Post> getFollowedPosts(String follower_id, int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select * from vw_full_post p "+
						"left join follows f on p.user_id = f.user_id "+
						"where f.follower_id = ? "+
						"order by p.post_id desc "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Post.class),
						new Object[]{follower_id});
		ret.addAll(posts);
		
		return ret;
	}
	
	/**
	 * @return
	 */
	public List<Post> getPostsByUser(String user_id, int from, int count)
	{
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select p.* "+
						"from vw_full_post p "+
						"where p.user_id = ? "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Post.class),
						new Object[] {user_id});
		ret.addAll(posts);
		return ret;
	}
	
	/**
	 * @param posts
	 * @param size
	 */
	public void loadCommentsForPosts(List<Post> posts, int size)
	{
		for (Post p : posts)
		{
			p.getComments().addAll(getCommentsByPostId(p.getPost_id(), 0, size));
		}
	}
	
	/**
	 * @return
	 */
	public List<Comment> getCommentsByPostId(Integer post_id, int from, int count)
	{
		// TODO
		// sql: select * from post order by post_id desc
		List<Comment> ret = new ArrayList<Comment>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Comment> Comments = this.jdbcTemplate
				.query(	"select *, u.name as user_name, u.portrait_small as user_image_small "+
						"from comment c "+
						"left join user u "+
						"on c.user_id = u.user_id "+
						"where c.post_id = ? "+
						"order by comment_id desc "+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Comment.class),
						new Object[] {post_id});
		ret.addAll(Comments);
		
		return ret;
	}
	
	
	/**
	 * @return
	 */
	public List<Post> getFollowedPosts(int from, int count)
	{
		// TODO
		// sql: select * from post order by post_id desc
		List<Post> ret = new ArrayList<Post>();
		// Retrieve the list of all vets.
		ret.clear();
		List<Post> posts = this.jdbcTemplate
				.query(	"select p.*," + 
						"u.portrait_small as user_image, " +
						"u.name as user_name "+ 
						"from vw_full_post p, user u "+
						"where p.user_id = u.user_id  "+
						"order by post_id desc " +
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
						.newInstance(Post.class));
		ret.addAll(posts);
		
		return ret;
	}

	/**
	 * @return
	 */
	public List<User> getFans(int from, int count , String  user_id)
	{
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all vets.
		//select f.*, u.name from follows f left join user u on u.user_id = f.follower_id where f.user_id = ? 
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query("select u.*, "+
					   "p.content as recent_post_content,  "+ 
					   "p.create_time_str as recent_post_time "+ 
					   "from vw_counted_user u, vw_full_post p, follows f "+
					   "where  "+
					   "u.user_id = f.follower_id "+
					   "and f.user_id = ? "+ 
					   "and p.post_id =  "+ 
					   "(select max(p.post_id) from post p "+ 
					   "where p.user_id = u.user_id)"+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
								new Object[] {user_id});
		ret.addAll(users);

		return ret;
	}

	/**
	 * @return
	 */
	public List<User> getMyFollows(String user_id, int from, int count)
	{
		List<User> ret = new ArrayList<User>();
		// select u.*, p.content as recent_post_content, p.create_time_str as recent_post_time FROM vw_counted_user u, post p, follows f
		//where u.user_id = f.follower_id and f.user_id = 'echo' and p.post_id = (select max(p.post_id) from post p where p.user_id = u.user_id)
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query("select u.*, "+
						   "p.content as recent_post_content,  "+ 
						   "p.create_time_str as recent_post_time "+ 
					   "from vw_counted_user u, vw_full_post p, follows f "+
					   "where  "+
						   "u.user_id = f.user_id "+
						   "and f.follower_id = ? "+ 
						   "and p.post_id =  "+ 
						   "(select max(p.post_id) from post p "+ 
					   "where p.user_id = u.user_id)"+
						"LIMIT " + from + ", " + count + " ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
								new Object[] {user_id});
		ret.addAll(users);

		return ret;
	}
	
	/**
	 * @return
	 */
	public Set<String> getMyFollowSet(String my_id)
	{
		Set<String> ret = new HashSet<String>();
		// select u.*, p.content as recent_post_content, p.create_time_str as recent_post_time FROM vw_counted_user u, post p, follows f
		//where u.user_id = f.follower_id and f.user_id = 'echo' and p.post_id = (select max(p.post_id) from post p where p.user_id = u.user_id)
		ret.clear();
		List<User> users = this.jdbcTemplate
				.query("select u.*  "+ 
					   "from user u, follows f "+
					   "where u.user_id = f.user_id "+
						   "and f.follower_id = ? ",
						ParameterizedBeanPropertyRowMapper
								.newInstance(User.class),
								new Object[] {my_id});
		for (User user: users){
			ret.add(user.getUser_id());
		}
		return ret;
	}
	
	/**************************************************************************
	 * tool methods
	 * ************************************************************************
	 */	
	
	public String getTimeStr() {
		Date dateNow=new Date();
		SimpleDateFormat  dateFormat=new SimpleDateFormat ("yyyy-MM-dd HH:mm");
		return dateFormat.format(dateNow);
	}
	
	public String getTimeStr(Date date) {
		SimpleDateFormat  dateFormat=new SimpleDateFormat ("yyyy-MM-dd HH:mm");
		return dateFormat.format(date);
	}
	
	
	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */
	public void setSimpleJdbcTemplate(JdbcTemplate simpleJdbcTemplate)
	{
		this.jdbcTemplate = simpleJdbcTemplate;
	}
	
	/**
	 * @param sql
	 * @param args
	 * @return
	 * @throws DataAccessException
	 */
	public int update(String sql, Object ... args) throws DataAccessException {
		try {
			String args_str = "";
			for (Object o: args) {
				args_str += o.toString();
			}
			LOG.info("update sql " + sql + " (with args: " + args_str + ")");
			return this.jdbcTemplate.update(sql, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}
	
	public <T> List<T> query(String sql, RowMapper<T> rowMapper, Object... args) throws DataAccessException {
		try {
			String args_str = "";
			for (Object o: args) {
				args_str += o.toString();
			}
			LOG.info("query sql " + sql + " (with args: " + args_str + ")");
			return this.jdbcTemplate.query(sql, rowMapper, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}
	public Integer queryForInt(String sql, Object... args) throws DataAccessException {
		try {
			String args_str = "";
			for (Object o: args) {
				args_str += o.toString();
			}
			LOG.info("query for int sql " + sql + " (with args: " + args_str + ")");
			return this.jdbcTemplate.queryForInt(sql, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}
	

}
