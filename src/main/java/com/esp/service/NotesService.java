/**
 * 
 */
package com.esp.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.jmx.export.annotation.ManagedResource;
import org.springframework.stereotype.Service;

import com.esp.model.Books;
import com.esp.model.Comment;
import com.esp.model.FileType;
import com.esp.model.Review;
import com.esp.model.Tag;
import com.esp.model.User;

/**
 * @author Echo
 * 
 */
@Service
@ManagedResource("notes:type=Notes")
public class NotesService {

	private static Logger LOG = Logger.getLogger(NotesService.class);
	private JdbcTemplate jdbcTemplate;

	public static final SimpleDateFormat DATE_FORMATER = new SimpleDateFormat(
			"yyyy-MM-dd");
	public static final SimpleDateFormat DATE_TIME_FORMATER = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	@Autowired
	public void init(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	/**************************************************************************
	 * update actions
	 * ************************************************************************
	 */
	public synchronized int createReview(Review review) {
		int review_id = update(
				"INSERT INTO notes.review (tag, isbn, user_id, rating, content, filetype, uploadfile, authority, pubtime ) "
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
				new Object[] { review.getTag(), review.getIsbn(),
						review.getUser_id(), review.getRating(),
						review.getContent(), review.getFiletype(),
						review.getUploadfile(), review.getAuthority(),
						new Date() });
		if (review_id > 0) {
			review_id = getLatestReviewId(review.getUser_id());
			// adding tags
			Integer tag_count = createReviewTags(review_id, review.getTag());
			LOG.info("1 Review (id="+ review_id +") created, with "+ tag_count +" tags ("+ review.getTag() +") added. " );
		}		
		return review_id;
	}

	public int createReviewTags(Integer review_id, String tags) {
		int ret = 0;
		String[] tagArr = tags.split("\\s+");
		for (String tag : tagArr) {
			ret += createReviewTag(review_id, tag);
		}
		return ret;
	}

	public int createReviewTag(Integer review_id, String tag) {
		int ret = update("INSERT INTO notes.review_tag (review_id, tag) "
				+ "VALUES (?, ?)", new Object[] { review_id, tag });
		return ret;
	}

	public int updateReview(Review review) {
		Date now = new Date();
		int ret = update(
				"update notes.review "
						+ "set tag=?, isbn=?, user_id=?, rating=?, content=?, filetype=?, authority=?, uploadfile=?, pubtime=? "
						+ "where review_id=?",
				new Object[] { review.getTag(), review.getIsbn(),
						review.getUser_id(), review.getRating(),
						review.getContent(), review.getFiletype(),
						review.getAuthority(), review.getUploadfile(), now,
						review.getReview_id() });

		return ret;
	}

	public int deleteReview(Integer review_id) {
		Date now = new Date();
		int ret = update("delete from notes.review " + "where review_id=?",
				new Object[] { review_id });

		return ret;
	}

	public int forwardReview(Integer review_id, String user_id) {
		Review review = getReviewsById(review_id);
		// review.getUser_name();

		Date now = new Date();
		int ret = update(
				"INSERT INTO notes.review (isbn, user_id, rating, content, forward_id, forward_user) "
						+ "VALUES (?, ?, ?, ?, ?, ?)",
				new Object[] { review.getIsbn(), user_id, review.getRating(),
						review.getContent(), review_id, review.getUser_name() });

		return ret;
	}

	public int createUp(Integer review_id, String user_id) {
		Date now = new Date();
		int ret = update("INSERT INTO notes.rate (review_id, user_id, up) "
				+ "VALUES (?, ?, ?)", new Object[] { review_id, user_id, 1 });

		return ret;
	}

	public int createRate(Integer review_id, String user_id, Integer rate) {
		Date now = new Date();
		int ret = update("INSERT INTO notes.rate (review_id, user_id, rate) "
				+ "VALUES (?, ?, ?)", new Object[] { review_id, user_id, rate });

		return ret;
	}

	public int createComment(Integer review_id, String user_id, String content) {
		Date now = new Date();
		int ret = update(
				"INSERT INTO notes.comment (review_id, user_id, content, create_time) "
						+ "VALUES (?, ?, ?, ?)", new Object[] { review_id,
						user_id, content, now });

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
	public User getUser(String user_id) {
		@SuppressWarnings("deprecation")
		List<User> users = query("SELECT * " + " FROM notes.user "
				+ " WHERE user_id = ? " + " ORDER BY sort_ind ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(User.class),
				new Object[] { user_id });

		if (users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	public User getUser_nick(String nickname) {
		List<User> users = query("SELECT * " + " FROM notes.user "
				+ " WHERE name = ? " + " ORDER BY sort_ind ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(User.class),
				new Object[] { nickname });

		if (users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	public User getUser_email(String email) {
		List<User> users = query("SELECT * " + " FROM notes.user "
				+ " WHERE email = ? " + " ORDER BY sort_ind ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(User.class),
				new Object[] { email });

		if (users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	public Boolean checkUser(User user) {
		List pers = query("SELECT * " + " FROM notes.user "
				+ " WHERE user_id = ? " + " AND password = ? "
				+ " ORDER BY user_id, password",
				ParameterizedBeanPropertyRowMapper.newInstance(User.class),
				new Object[] { user.getUser_id(), user.getPassword() });

		if (pers.size() > 0)
			return true;
		else
			return false;
	}

	public List<User> getAllUsers() {
		// sql: select * from book order by isbn desc
		List<User> ret = new ArrayList<User>();
		// Retrieve the list of all books.
		ret.clear();

		List<User> users = query("SELECT * " + " FROM notes.user "
				+ " ORDER BY user_id ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(User.class));
		ret.addAll(users);
		return ret;
	}

	public Books getBooks(String isbn) {
		@SuppressWarnings("deprecation")
		List<Books> books = query("SELECT * " + " FROM notes.book "
				+ " WHERE isbn = ? " + " ORDER BY isbn ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(Books.class),
				new Object[] { isbn });

		if (books.size() > 0)
			return books.get(0);
		else
			return null;
	}

	public List<Books> getAllBooks() {
		// sql: select * from book order by isbn desc
		List<Books> ret = new ArrayList<Books>();
		// Retrieve the list of all books.
		ret.clear();

		List<Books> books = query("SELECT * " + " FROM notes.book "
				+ " ORDER BY isbn ASC",
				ParameterizedBeanPropertyRowMapper.newInstance(Books.class));

		ret.addAll(books);

		return ret;
	}

	public List<Tag> getAllTags(String except_user_id) {
		return getAllTags(except_user_id, false);
	}
	
	public List<Tag> getAllTags(String execpt_user_id, boolean ifIncludesDraft) {
		String execpt_user_sql = "";
		if (execpt_user_id != null && execpt_user_id.length() > 0) {
			execpt_user_sql = "and r.user_id != '" + execpt_user_id + "' ";
		}
		
		String draft_sql = "";
		if (!ifIncludesDraft) {
			draft_sql = "and r.authority != 3 ";
		}
		
		List<Tag> ret = new ArrayList<Tag>();
		List<Tag> tags = query(
				"select rt.tag, count(r.review_id) as 'count' " +
				"from notes.review_tag rt " +
				"inner join notes.review r on r.review_id = rt.review_id " + 
				execpt_user_sql +
				draft_sql +
				"where rt.tag is not null " +				
				"group by rt.tag " +
				"order by count(r.review_id) desc",
				ParameterizedBeanPropertyRowMapper.newInstance(Tag.class));
		ret.addAll(tags);
		return ret;
	}
	
	public Integer countAllReviews(String user_id, String execpt_user_id) {
		return countAllReviews(user_id, execpt_user_id, false);
	}
	public Integer countAllReviews(String user_id, String execpt_user_id, boolean ifIncludesDraft) {
		String user_sql = "";
		if (user_id != null && user_id.length() > 0) {
			user_sql = "and r.user_id = '" + user_id + "' ";
		}		
		String execpt_user_sql = "";
		if (execpt_user_id != null && execpt_user_id.length() > 0) {
			execpt_user_sql = "and r.user_id != '" + execpt_user_id + "' ";
		}
		String draft_sql = "";
		if (!ifIncludesDraft) {
			draft_sql = "and r.authority != 3 ";
		}
		
		Integer count = queryForInt(
				"select count(r.review_id) as 'count' " +
				"from notes.review r " +
				"where (1=1) " +				
				user_sql +
				draft_sql +
				execpt_user_sql);
		return count;
	}
	
	public List<FileType> getAllFiletype(String my_id) {
		List<FileType> ret = new ArrayList<FileType>();
		List<FileType> tags = query("select filetype, count(review_id) as count " +
				"from notes.review " +
				"where filetype is not null " +
				"and user_id = ? " +
				"group by filetype",	
				ParameterizedBeanPropertyRowMapper.newInstance(FileType.class),
				new Object[]{my_id});
		ret.addAll(tags);
		return ret;
		
	}
	
	public List<Review> getAllReviews(String my_id) {
		return getUserReviews(null, my_id);
	}

	public List<Review> getUserReviews(String user_id, String my_id) {
		return getReviews(my_id, user_id, null, null, null, null);
	}

	public List<Review> getUserReviewsByTag(String user_id, String my_id, String tag) {
		return getReviews(my_id, user_id, null, tag, null, null);
	}
	
	public List<Review> getAllReviewsExceptUser(String except_id, String my_id) {
		return getReviews(my_id, null, except_id, null, null, null);		
	}

	public List<Review> getReviews(String my_id, String user_id, String except_id, String tag, String fileType, String keywords) {
		// sql: select * from book order by isbn desc
		List<Review> ret = new ArrayList<Review>();
		// Retrieve the list of all books.
		ret.clear();

		List<Object> params = new ArrayList<Object>();
		

		// tag
		String tag_join = "";
		if (tag != null && tag.length() > 0) {
			tag_join = "INNER JOIN notes.review_tag rt ON rt.review_id = r.review_id and rt.tag = ? ";
			params.add(tag);
		}
		
		// my id
		params.add(my_id);

		// keyword search
		String keyword_clause = "";
		if (keywords != null && keywords.length() > 0) {
			String[] kws = keywords.split("\\s+");
			keyword_clause += "AND ( (1=0) ";
			// multiple key words
			for (String kw : kws) {
				keyword_clause += "or r.isbn like ? or r.content like ?";
				params.add("%" + kw + "%");
				params.add("%" + kw + "%");
			}
			keyword_clause += ") ";
		}
		
		// fileType
		String fileType_clause = "";
		if (fileType != null && fileType.length() > 0) {
			fileType_clause = "and r.filetype = ? ";
			params.add(fileType);
		}
		
		// set except user condition
		String user_clause = "";
		if (user_id != null) {
			user_clause = "AND r.user_id = ? ";
			params.add(user_id);
		}

		// set except user condition
		String except_user_clause = "";
		if (except_id != null) {
			except_user_clause = "AND r.user_id != ? ";
			params.add(except_id);
		}

		// query
		List<Review> reviews = query(
				"SELECT  r.*, u.name as user_name, b.name as book_name, "
						+ "AVG(t.rate) as avg_rate, COUNT(t.up) as count_up, "
						+ "COUNT(mt.up) as my_count_up, MAX(mt.rate) as my_rate "
						+ "FROM notes.review r "
						+ tag_join
						+ "LEFT JOIN notes.user u ON u.user_id = r.user_id "
						+ "LEFT JOIN notes.book b ON b.isbn = r.isbn "
						+ "LEFT JOIN notes.rate t ON t.review_id = r.review_id "
						+ "LEFT JOIN notes.rate mt ON mt.review_id = r.review_id AND mt.user_id = ? "
						+ "WHERE r.authority != 3 " 
						+ keyword_clause
						+ fileType_clause
						+ user_clause 
						+ except_user_clause 
						+ "GROUP BY r.review_id "
						+ "ORDER BY r.review_id desc ",
				ParameterizedBeanPropertyRowMapper.newInstance(Review.class),
				params.toArray());
		ret.addAll(reviews);
		return ret;
	}

	public List<Review> getReviewDraftByUser(String user_id) {
		// sql: select * from book order by isbn desc
		List<Review> ret = new ArrayList<Review>();
		// Retrieve the list of all books.
		ret.clear();

		List<Review> reviews = query("SELECT " + " r.*, u.name as user_name "
				+ " FROM notes.review r "
				+ " LEFT JOIN notes.user u ON u.user_id = r.user_id "
				+ " WHERE r.user_id = ? " + " AND r.authority = ? "
				+ " GROUP BY r.review_id " + " ORDER BY review_id desc",
				ParameterizedBeanPropertyRowMapper.newInstance(Review.class),
				new Object[] { user_id, 3 });

		ret.addAll(reviews);

		return ret;
	}

	public List<Review> getReviewsByUser(String user_id) {
		return getReviewsByUser(user_id, null);
	}

	public List<Review> getReviewsByUser(String user_id, String my_id) {
		// sql: select * from book order by isbn desc
		List<Review> ret = new ArrayList<Review>();
		// Retrieve the list of all books.
		ret.clear();

		// set user condition
		String user_clause = "";
		Object[] params = new Object[] { my_id };
		if (user_id != null) {
			user_clause = "AND r.user_id = ? AND r.authority != 3 ";
			params = new Object[] { my_id, user_id };
		}

		List<Review> reviews = query(
				"SELECT "
						+ "r.*, u.name as user_name, b.name as book_name, "
						+ "AVG(t.rate) as avg_rate, COUNT(t.up) as count_up, "
						+ "COUNT(mt.up) as my_count_up, MAX(mt.rate) as my_rate "
						+ "FROM notes.review r "
						+ "LEFT JOIN notes.user u ON u.user_id = r.user_id "
						+ "LEFT JOIN notes.book b ON b.isbn = r.isbn "
						+ "LEFT JOIN notes.rate t ON t.review_id = r.review_id "
						+ "LEFT JOIN notes.rate mt ON mt.review_id = r.review_id AND mt.user_id = ? "
						+ "WHERE (1=1) " + user_clause
						+ "GROUP BY r.review_id " + "ORDER BY review_id desc ",
				ParameterizedBeanPropertyRowMapper.newInstance(Review.class),
				params);

		ret.addAll(reviews);

		return ret;
	}

	public List<Review> getReviewsByUserByFileType(String my_id, String user_id,
			 String fileType) {
		return getReviews(my_id, user_id, null, null, fileType, null);
	}

	public Review getReviewsById(Integer review_id) {
		return getReviewsById(review_id, null);
	}

	public Review getReviewsById(Integer review_id, String my_id) {
		// sql: select * from book order by isbn desc
		List<Review> ret = new ArrayList<Review>();
		// Retrieve the list of all books.
		ret.clear();

		List<Review> reviews = query(
				"SELECT "
						+ "r.*, u.name as user_name, b.name as book_name, "
						+ "AVG(t.rate) as avg_rate, COUNT(t.up) as count_up, "
						+ "COUNT(mt.up) as my_count_up, MAX(mt.rate) as my_rate "
						+ "FROM notes.review r "
						+ "LEFT JOIN notes.user u ON u.user_id = r.user_id "
						+ "LEFT JOIN notes.book b ON b.isbn = r.isbn "
						+ "LEFT JOIN notes.rate t ON t.review_id = r.review_id "
						+ "LEFT JOIN notes.rate mt ON mt.review_id = r.review_id AND mt.user_id = ? "
						+ "WHERE r.review_id=? " + "GROUP BY r.review_id "
						+ "ORDER BY review_id desc ",
				ParameterizedBeanPropertyRowMapper.newInstance(Review.class),
				new Object[] { my_id, review_id });

		ret.addAll(reviews);
		if (ret.size() >= 1) {
			return ret.get(0);
		} else {
			return null;
		}
	}

	public Integer getLatestReviewId(String my_id) {
		List<Integer> ret = new ArrayList<Integer>();
		ret.clear();

		Integer latest_id = queryForInt("SELECT "
				+ "max(r.review_id)  FROM notes.review r  WHERE r.user_id=?  ",
				new Object[] { my_id });

		return latest_id;
	}


	public List<Comment> getCommentsByReview_id(Review review) {
		// sql: select * from book order by isbn desc
		List<Comment> ret = new ArrayList<Comment>();
		// Retrieve the list of all books.
		ret.clear();

		List<Comment> comments = query(
				"SELECT " + "* from notes.comment where comment.review_id = "
						+ review.getReview_id(),
				ParameterizedBeanPropertyRowMapper.newInstance(Comment.class));

		ret.addAll(comments);

		return ret;
	}

	/**************************************************************************
	 * tool methods
	 * ************************************************************************
	 */

	public String getTimeStr() {
		Date dateNow = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return dateFormat.format(dateNow);
	}

	public String getTimeStr(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return dateFormat.format(date);
	}

	/**************************************************************************
	 * getter setter
	 * ************************************************************************
	 */
	public void setSimpleJdbcTemplate(JdbcTemplate simpleJdbcTemplate) {
		this.jdbcTemplate = simpleJdbcTemplate;
	}

	/**
	 * @param sql
	 * @param args
	 * @return
	 * @throws DataAccessException
	 */
	public int update(String sql, Object... args) throws DataAccessException {
		try {
			String args_str = "";
			for (Object o : args) {
				if (o == null) {
					args_str += "null ";
				} else {
					args_str += o.toString();
				}
			}
			LOG.info("update sql " + sql + " (with args: " + args_str + ")");
			return this.jdbcTemplate.update(sql, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}

	public <T> List<T> query(String sql, RowMapper<T> rowMapper, Object... args)
			throws DataAccessException {
		try {
			String args_str = "";
			for (Object o : args) {
				if (o == null) {
					args_str += "null ";
				} else {
					args_str += o.toString();
				}
			}
			LOG.info("query sql " + sql + " (with args: " + args_str + ")");
			return this.jdbcTemplate.query(sql, rowMapper, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}

	public Integer queryForInt(String sql, Object... args)
			throws DataAccessException {
		try {
			String args_str = "";
			for (Object o : args) {
				args_str += o.toString();
			}
			LOG.info("query for int sql " + sql + " (with args: " + args_str
					+ ")");
			return this.jdbcTemplate.queryForInt(sql, args);
		} catch (DataAccessException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
	}

}
