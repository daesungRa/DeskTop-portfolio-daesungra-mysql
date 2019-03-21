package com.daesungra.controller;

import java.sql.Connection;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private DataSource dataSource;
	@Autowired
	private SqlSessionFactory sqlFactory;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		logger.info("current context path: " + request.getContextPath());
		logger.info("current servletContext context path: " + request.getSession().getServletContext().getContextPath());
		logger.info("current servletContext get real path: " + request.getSession().getServletContext().getRealPath("/"));
		logger.info("current servletContext get real path (/resources/imgs): " + request.getSession().getServletContext().getRealPath("/resources/imgs"));
		
		// 커넥션 성공유무 테스트
		// 데이터소스 url 에 문법에러 있었음 > 고침
		try (Connection conn = dataSource.getConnection()) {
			logger.info("\n >>>>>>>>>> Connection 출력 : " + conn + "\n");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		// 마이바티스 sqlSession 생성유무 테스트
		// 잘됨
		try(SqlSession session = sqlFactory.openSession()){
            System.out.println(" >>>>>>>>>> session 출력 : "+session+"\n");
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
}