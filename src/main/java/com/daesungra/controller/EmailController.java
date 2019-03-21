package com.daesungra.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.daesungra.domain.MemberVo;
import com.daesungra.service.EmailService;

@Controller
@RequestMapping(value="/email")
public class EmailController {
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private EmailService emailService;
	
	// 아이디 찾기 메서드
	@ResponseBody
	@RequestMapping(value="/findIdAction")
	public String findIdAction (HttpServletRequest request) {
		logger.info("[email controller] find id action!");
		// 최종 결과 플래그
		String result = "0";
		// 아이디 조회 결과가 저장될 변수
		String findResult = "";
		// 계정 조회를 위한 멤버 객체
		MemberVo mbvo = new MemberVo();
		// 이메일 전송을 위한 세팅변수 > setFrom, receiver, subject, content
		String setFrom = "chaeksang2018@gmail.com";
		String userName = (String) request.getParameter("userName");
		String receiver = (String) request.getParameter("receiver");
		String subject = (String) request.getParameter("subject");
		String content = ""; // 조회된 아이디가 있다면 세팅될 본문 스트링
		
		// 매개변수 객체 세팅
		mbvo.setUserName(userName);
		mbvo.setEmail(receiver);
		
		findResult = emailService.findIdAction(mbvo);
		if (findResult != null && !findResult.equals("")) {
			// 조회 성공 시 이메일로 아이디 전송 후 성공플래그 세팅
			content = "조회된 아이디 : " + findResult; // 본문
			
			try {
				MimeMessage message = mailSender.createMimeMessage(); // 메세지 객체 생성
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8"); // 메세지 헬퍼 생성
				
				// 메세지 내용 세팅
				messageHelper.setFrom(setFrom);
				messageHelper.setTo(receiver);
				messageHelper.setSubject(subject);
				messageHelper.setText(content);
				
				// 메세지 전송!
				mailSender.send(message);
				logger.info("[email controller] 이메일 전송 완료");
				result = "1";
			} catch (Exception ex) { ex.printStackTrace(); }
		} else {
			// 조회 실패 플래그 (0 은 서버 에러 플래그임)
			result = "2";
		}
		
		return result;
	}
	
	// 비밀번호 찾기 메서드
	@ResponseBody
	@RequestMapping(value="/findPwdAction")
	public String findPwdAction (HttpServletRequest request) {
		logger.info("[email controller] find pwd action!");
		// 최종 결과 플래그
		String result = "0";
		// 아이디 조회 결과가 저장될 변수
		String findResult = "";
		// 계정 조회를 위한 멤버 객체
		MemberVo mbvo = new MemberVo();
		// 이메일 전송을 위한 세팅변수 > setFrom, receiver, subject, content
		String setFrom = "chaeksang2018@gmail.com";
		String userId = (String) request.getParameter("userId");
		String userName = (String) request.getParameter("userName");
		String receiver = (String) request.getParameter("receiver");
		String subject = (String) request.getParameter("subject");
		String content = ""; // 조회된 비밀번호가 있다면 세팅될 본문 스트링
		
		// 매개변수 객체 세팅
		mbvo.setUserId(userId);
		mbvo.setUserName(userName);
		mbvo.setEmail(receiver);
		
		findResult = emailService.findPwdAction(mbvo);
		if (findResult != null && !findResult.equals("")) {
			// 조회 성공 시 이메일로 임시 비밀번호 전송 후 성공플래그 세팅
			content = "임시 비밀번호 : " + findResult + "\n > 로그인 후 비밀번호를 변경하세요"; // 본문
			
			try {
				MimeMessage message = mailSender.createMimeMessage(); // 메세지 객체 생성
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8"); // 메세지 헬퍼 생성
				
				// 메세지 내용 세팅
				messageHelper.setFrom(setFrom);
				messageHelper.setTo(receiver);
				messageHelper.setSubject(subject);
				messageHelper.setText(content);
				
				// 메세지 전송!
				mailSender.send(message);
				logger.info("[email controller] 이메일 전송 완료");
				result = "1";
			} catch (Exception ex) { ex.printStackTrace(); }
		} else {
			// 조회 실패 플래그 (0 은 서버 에러 플래그임)
			result = "2";
		}
		
		return result;
	}
}
