package com.esp.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.esp.model.Books;
import com.esp.model.Comment;
import com.esp.model.Review;
import com.esp.model.User;
import com.esp.service.NotesService;
import com.esp.utils.Utils;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring/applicationContext-jdbc.xml")
public class NotesTest extends AbstractTransactionalJUnit4SpringContextTests {

	@Resource
	private NotesService notes;

	@Before
	public void setUp() throws Exception {
		System.out.println("Begin to test.");
	}
	@After
	public void tearDown() throws Exception {
		System.out.println("Test finished");
	}
	
	/******************************************
	 * TEST QUERIES
	 ******************************************
	 */
	@Test
	public void testGetAllUsers() {
		List<User> list = notes.getAllUsers();
		System.out.println("Got " + list.size() + " objects...");
		for (User user : list) {
			System.out.println(Utils.print(user));
		}
	}
	@Test
	public void testGetAllBooks() {
		List<Books> list = notes.getAllBooks();
		System.out.println("Got " + list.size() + " objects...");
		for (Books book : list) {
			System.out.println(Utils.print(book));
		}
	}
	@Test
	public void testGetBooksByISBN() {
		Books book = notes.getBooks("9787111255833");
		System.out.println("Got 1 objects...");
		System.out.println(Utils.print(book));
	}
	//@Test
	public void testGetAllReviews() {
		//List<Review> list = notes.getAllReviews();
		//System.out.println("Got " + list.size() + " objects...");
		//for (Review review : list) {
			//System.out.println(Utils.print(review));
		//}
	}
	@Test
	public void testGetReviewsById() {
		Review review = notes.getReviewsById(15);
		System.out.println("Got 1 objects...");
		System.out.println(Utils.print(review));
	}	
	@Test
	public void testGetReviewsByUser() {
		List<Review> list = notes.getReviewsByUser("echo", "chris");
		System.out.println("Got " + list.size() + " objects...");
		for (Review review : list) {
			System.out.println(Utils.print(review));
		}
	}
	@Test
	public void testGetCommentsById() {
		Review review = new Review();
		review.setReview_id(10);
		List<Comment> list = notes.getCommentsByReview_id(review);
		System.out.println("Got " + list.size() + " objects...");
		for (Comment comment : list) {
			System.out.println(Utils.print(comment));
		}
	}
		
	/******************************************
	 * TEST UPDATES
	 ******************************************
	 */
	@Test
	public void testCreateReview() {
		Review review = new Review();
		review.setIsbn("9787111255833");
		review.setUser_id("echo");
		review.setRating(5);
		review.setContent("<h3>测试</h3><p>很不错的一本书，值得推荐！</p>");
		review.setTag("散文");
		notes.createReview(review);
		System.out.println("succesfully created a review.");
	}
	@Test
	public void testUpdateReview() {
		Review review = new Review();
		review.setReview_id(1);
		review.setIsbn("9787111255833");
		review.setUser_id("echo");
		review.setRating(5);
		review.setContent("<h3>测试</h3><p>很不错的一本书，值得推荐！</p>");
		review.setTag("散文");
		notes.updateReview(review);
		System.out.println("succesfully updated a review.");
	}
	@Test
	public void testDeleteReview() {
		//notes.deleteReview(16);
		System.out.println("succesfully updated a review.");
	}
	@Test
	public void testForwardReview() {
		notes.forwardReview(1, "chris");
		System.out.println("succesfully created a review.");
	}
	@Test
	public void testCreateUp() {
		notes.createUp(1, "chris");
		System.out.println("succesfully created a review.");
	}
	@Test
	public void testCreateRate() {
		notes.createRate(1, "chris", 5);
		System.out.println("succesfully created a review.");
	}
	@Test
	public void testCreateComment() {
		notes.createComment(1, "chris", "评论测试");
		System.out.println("succesfully created a review.");
	}
}
