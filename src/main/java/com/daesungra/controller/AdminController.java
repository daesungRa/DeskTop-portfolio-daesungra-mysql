package com.daesungra.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daesungra.component.FileUpload;
import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.MemberVo;
import com.daesungra.domain.PageDto;
import com.daesungra.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	@Autowired
	private PageDto pageDto;
	@Autowired
	private FileUpload fileUpload;
	
	// 게시글 리스트 조회 및 페이징 처리를 위한 변수
	private int listSize = 10;
	private int blockSize = 5;
	private int nowPage = 1;
	
	/*
	 * get admin page
	 */
	// 최초 로딩 시 관련된 모든 객체를 얻어옴
	@RequestMapping(value="/getAdminPage/{nowPage}", method=RequestMethod.GET)
	public ModelAndView getAdminPage (Model model, HttpSession session, @PathVariable(name = "nowPage", required = false) int nowPage) {
		logger.info("[admin] load admin page");
		
		// 응답 객체
		ModelAndView mav = new ModelAndView();
		int dateFlag = 3; // 조회 날짜 매개변수 flag (1: 오늘, 2: 하루 전, 3: 일주일 전, 4: 한달 전)
		
		// 권한 수준이 맞지 않다면 리다이렉트
		try {
			System.out.println("session authority : " + session.getAttribute("authority"));
			String authority = (String) session.getAttribute("authority");
			if (authority == null || authority.equals("0")) {
				mav.setViewName("redirect:/");
				return mav;
			}
		} catch (Exception ex) { ex.printStackTrace(); }
		
		// 페이징 처리를 위한 dto 객체 결과값이 세팅된 매개변수 정의
		this.nowPage = 1;
		pageDto.setAdminPageDto(this.listSize, this.blockSize, this.nowPage, dateFlag); // 페이징 처리를 위한 도메인 객체
		
		/*
		 * 게시글 신고 리스트
		 */
		pageDto.adminBoardReportPageCompute();
		
		Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BoardReportVo> brvoList = null;
		
		// board report list 저장 객체 조회 및 세팅
		brvoList = adminService.getBoardReportList(pagenatedInputData);
		if (brvoList != null) {
			logger.info("[boardreport list - admin controller] 신고 리스트 조회 완료");
			// board report list 에 대한 pageDto 생성
			PageDto brPageDto = new PageDto();
			brPageDto.setNowPage(pageDto.getNowPage());
			brPageDto.setTotSize(pageDto.getTotSize());
			brPageDto.setTotPage(pageDto.getTotPage());
			brPageDto.setTotBlock(pageDto.getTotBlock());
			brPageDto.setNowBlock(pageDto.getNowBlock());
			brPageDto.setStartNo(pageDto.getStartNo());
			brPageDto.setEndNo(pageDto.getEndNo());
			brPageDto.setStartPage(pageDto.getStartPage());
			brPageDto.setEndPage(pageDto.getEndPage());
			
			// 응답 객체에 세팅
			mav.addObject("brvoList", brvoList);
			mav.addObject("brPageDto", brPageDto);
		}
		
		/*
		 * 새 책 등록 요청 리스트
		 */
		pageDto.adminBookRegisterPageCompute();
		
		pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BookVo> bkvoList = null;
		
		// board report list 저장 객체 조회 및 세팅
		bkvoList = adminService.getBookRegisterList(pagenatedInputData);
		if (bkvoList != null) {
			logger.info("[book register list - admin controller] 새 책 등록요청 조회 완료");
			// board report list 에 대한 pageDto 생성
			PageDto bkPageDto = new PageDto();
			bkPageDto.setNowPage(pageDto.getNowPage());
			bkPageDto.setTotSize(pageDto.getTotSize());
			bkPageDto.setTotPage(pageDto.getTotPage());
			bkPageDto.setTotBlock(pageDto.getTotBlock());
			bkPageDto.setNowBlock(pageDto.getNowBlock());
			bkPageDto.setStartNo(pageDto.getStartNo());
			bkPageDto.setEndNo(pageDto.getEndNo());
			bkPageDto.setStartPage(pageDto.getStartPage());
			bkPageDto.setEndPage(pageDto.getEndPage());
			
			// 응답 객체에 세팅
			mav.addObject("bkvoList", bkvoList);
			mav.addObject("bkPageDto", bkPageDto);
		}
		
		/*
		 * 새로운 게시글 리스트
		 */
		pageDto.adminNewBoardPageCompute();
		
		pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BoardVo> bdvoList = null;
		
		// board report list 저장 객체 조회 및 세팅
		bdvoList = adminService.getNewBoardList(pagenatedInputData);
		if (bdvoList != null) {
			logger.info("[new board list - admin controller] 새로운 게시글 리스트 조회 완료");
			// new board list 에 대한 pageDto 생성
			PageDto bdPageDto = new PageDto();
			bdPageDto.setNowPage(pageDto.getNowPage());
			bdPageDto.setTotSize(pageDto.getTotSize());
			bdPageDto.setTotPage(pageDto.getTotPage());
			bdPageDto.setTotBlock(pageDto.getTotBlock());
			bdPageDto.setNowBlock(pageDto.getNowBlock());
			bdPageDto.setStartNo(pageDto.getStartNo());
			bdPageDto.setEndNo(pageDto.getEndNo());
			bdPageDto.setStartPage(pageDto.getStartPage());
			bdPageDto.setEndPage(pageDto.getEndPage());
			
			// 응답 객체에 세팅
			mav.addObject("bdvoList", bdvoList);
			mav.addObject("bdPageDto", bdPageDto);
		}
		
		mav.setViewName("/admin/adminPage");
		return mav;
	}
	
	/*
	 * board report
	 */
	// 게시글 신고 리스트 관련 정보
	@RequestMapping(value="/getBoardReportList", method=RequestMethod.POST)
	public ModelAndView getBoardReportList (HttpServletRequest request) {
		logger.info("[boardreport list - admin controller] 게시글 신고 목록 요청");
		// 응답 객체
		ModelAndView mav = new ModelAndView();
		int dateFlag = 3; // 조회 날짜 매개변수 flag (1: 오늘, 2: 하루 전, 3: 일주일 전, 4: 한달 전)
		
		// 요청 데이터 세팅
		try {
			this.nowPage = Integer.parseInt(request.getParameter("nowPage"));
			dateFlag = Integer.parseInt(request.getParameter("dateFlag"));
		} catch (Exception ex) { ex.printStackTrace(); }
		
		// 페이징 처리 후 결과값이 세팅된 매개변수 정의
		pageDto.setAdminPageDto(this.listSize, this.blockSize, this.nowPage, dateFlag); // 페이징 처리를 위한 도메인 객체
		pageDto.adminBoardReportPageCompute();
		
		Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BoardReportVo> brvoList = null;
		
		// 신고글 리스트를 구해서 mav 로 반환
		brvoList = adminService.getBoardReportList(pagenatedInputData);
		if (brvoList != null) {
			logger.info("[boardreport list - admin controller] 신고 리스트 조회 완료");
			// board report list 에 대한 pageDto 생성
			PageDto brPageDto = new PageDto();
			brPageDto.setNowPage(pageDto.getNowPage());
			brPageDto.setTotSize(pageDto.getTotSize());
			brPageDto.setTotPage(pageDto.getTotPage());
			brPageDto.setTotBlock(pageDto.getTotBlock());
			brPageDto.setNowBlock(pageDto.getNowBlock());
			brPageDto.setStartNo(pageDto.getStartNo());
			brPageDto.setEndNo(pageDto.getEndNo());
			brPageDto.setStartPage(pageDto.getStartPage());
			brPageDto.setEndPage(pageDto.getEndPage());
			
			mav.addObject("brvoList", brvoList);
			mav.addObject("brPageDto", brPageDto);
		}

		mav.setViewName("/admin/adminReportListPart"); // 리턴 경로
		return mav;
	}
	
	// 게시글 신고정보 가져오기
	@RequestMapping(value="/getBoardReportInfo/{serial}", method=RequestMethod.GET)
	public ModelAndView getBoardReportInfo (HttpServletRequest request, @PathVariable(name = "serial", required = false) int serial) {
		logger.info("[get boardreport info - admin controller] 게시글 신고정보 요청, serial : " + serial);
		ModelAndView mav = new ModelAndView();
		BoardReportVo brvo = null;
		
		brvo = adminService.getBoardReportInfo(serial);
		if (brvo != null) {
			logger.info("[get boardreport info - admin controller] 게시글 신고정보 반환완료, serial : " + brvo.getSerial());
			mav.addObject("brvo", brvo);
		}
		
		mav.setViewName("/admin/adminReportControlPart");
		return mav;
	}
	
	// 게시글 블럭 처리
	@ResponseBody
	@RequestMapping(value="/boardBlockAction", method=RequestMethod.POST)
	public String boardBlockAction (HttpServletRequest request) {
		String result = "0";
		int fSerial = Integer.parseInt(request.getParameter("fSerial"));
		logger.info("[board blocking action - admin controller] 게시글 블럭처리, fSerial : " + fSerial);
		
		boolean blockingResult = adminService.boardBlockAction(fSerial);
		if (blockingResult) {
			result = "1";
		}
		
		return result;
	}
	
	// 게시글 블럭 해제
	@ResponseBody
	@RequestMapping(value="/boardBlockFreeAction", method=RequestMethod.POST)
	public String boardBlockFreeAction (HttpServletRequest request) {
		String result = "0";
		int fSerial = Integer.parseInt(request.getParameter("fSerial"));
		logger.info("[board block free action - admin controller] 게시글 블럭해제 요청, fSerial : " + fSerial);
		
		boolean blockingResult = adminService.boardBlockFreeAction(fSerial);
		if (blockingResult) {
			result = "1";
		}
		
		return result;
	}
	
	// 게시글 신고요청 완료처리
	@ResponseBody
	@RequestMapping(value="/boardReportComplete", method=RequestMethod.POST)
	public String boardReportComplete (HttpServletRequest request) {
		String result = "0";
		int serial = Integer.parseInt(request.getParameter("serial"));
		logger.info("[boardreport complete - admin controller] 게시글 신고정보 완료처리, serial : " + serial);
		
		boolean reportComplete = adminService.boardReportCompleteAction(serial);
		if (reportComplete) {
			result = "1";
		}
		
		return result;
	}
	
	/*
	 * method book register
	 */
	// 새 책 등록요청 정보 리스트
	@RequestMapping(value="/getBookRegisterList", method=RequestMethod.POST)
	public ModelAndView getBookRegisterList (HttpServletRequest request) {
		logger.info("[book register list - admin controller] 새 책 등록요청 목록");
		// 응답 객체
		ModelAndView mav = new ModelAndView();
		int dateFlag = 3; // 조회 날짜 매개변수 flag (1: 오늘, 2: 하루 전, 3: 일주일 전, 4: 한달 전)
		
		// 요청 데이터 세팅
		try {
			this.nowPage = Integer.parseInt(request.getParameter("nowPage"));
			dateFlag = Integer.parseInt(request.getParameter("dateFlag"));
		} catch (Exception ex) { ex.printStackTrace(); }
		
		// 페이징 처리 후 결과값이 세팅된 매개변수 정의
		pageDto.setAdminPageDto(this.listSize, this.blockSize, this.nowPage, dateFlag); // 페이징 처리를 위한 도메인 객체
		pageDto.adminBookRegisterPageCompute();
		
		Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BookVo> bkvoList = null;
		
		// board report list 저장 객체 조회 및 세팅
		bkvoList = adminService.getBookRegisterList(pagenatedInputData);
		if (bkvoList != null) {
			logger.info("[book register list - admin controller] 새 책 등록요청 조회 완료");
			// board report list 에 대한 pageDto 생성
			PageDto bkPageDto = new PageDto();
			bkPageDto.setNowPage(pageDto.getNowPage());
			bkPageDto.setTotSize(pageDto.getTotSize());
			bkPageDto.setTotPage(pageDto.getTotPage());
			bkPageDto.setTotBlock(pageDto.getTotBlock());
			bkPageDto.setNowBlock(pageDto.getNowBlock());
			bkPageDto.setStartNo(pageDto.getStartNo());
			bkPageDto.setEndNo(pageDto.getEndNo());
			bkPageDto.setStartPage(pageDto.getStartPage());
			bkPageDto.setEndPage(pageDto.getEndPage());
			
			// 응답 객체에 세팅
			mav.addObject("bkvoList", bkvoList);
			mav.addObject("bkPageDto", bkPageDto);
		}
		
		mav.setViewName("/admin/adminBookListPart"); // 리턴 경로
		return mav;
	}
	
	// 새 책 등록정보 가져오기
	@RequestMapping(value="/getBookRegisterInfo/{bookNo}", method=RequestMethod.GET)
	public ModelAndView getBookRegisterInfo (HttpServletRequest request, @PathVariable(name = "bookNo", required = false) String bookNo) {
		logger.info("[get book register info - admin controller] 새 책 등록정보 요청, bookNo : " + bookNo);
		ModelAndView mav = new ModelAndView();
		BookVo bkvo = null;
		
		bkvo = adminService.getBookRegisterInfo(bookNo);
		if (bkvo != null) {
			logger.info("[get book register info - admin controller] 새 책 등록정보 반환완료, bookNo : " + bkvo.getBookNo());
			mav.addObject("bkvo", bkvo);
		}
		
		mav.setViewName("/admin/adminBookControlPart");
		return mav;
	}
	
	// 책 등록요청 거부 처리
	@ResponseBody
	@RequestMapping(value="bookRegisterProhibitAction")
	public String bookRegisterProhibitAction (HttpServletRequest request) {
		String result = "0";
		String bookNo = request.getParameter("bookNo");
		logger.info("[book register prohibit action - admin controller] 책 등록요청 거부 처리, bookNo : " + bookNo);
		
		boolean prohibitResult = adminService.prohibitBookRegister(bookNo);
		if (prohibitResult) {
			logger.info("[book register prohibit action - admin controller] 거부 처리 완료, bookNo " + bookNo); 
			result = "1";
		}
		
		return result;
	}
	
	// 책 등록요청 허가 처리 및 수정된 내용 입력
	@ResponseBody
	@RequestMapping(value="/bookRegisterPermitAction")
	public String bookRegisterPermitAction (HttpServletRequest request) {
		String result = "0";
		BookVo bkvo = null;
		logger.info("[bookregister permit logic - controller] 책 등록 허가 : ");
		
		bkvo = fileUpload.getBookVo(request);
		if (bkvo != null) {
			logger.info("[bookregister permit logic - controller] vo 객체 생성 완료");
			bkvo.toString();
			
			boolean permitResult = adminService.permitBookRegister(bkvo);
			if (permitResult) {
				logger.info("[bookregister permit logic - controller] 허가 완료(modify)");
				result = "1";
			}
		} else {
			result = "2";
		}
		
		return result;
	}
	
	// 등록 허가 해제 처리
	
	/*
	 * new board - 새로운 게시글 처리
	 */
	// 새로운 게시글 리스트
	@RequestMapping(value="/getNewBoardList")
	public ModelAndView getNewBoardList (HttpServletRequest request) {
		logger.info("[new board list - admin controller] 새로운 게시글 목록");
		// 응답 객체
		ModelAndView mav = new ModelAndView();
		int dateFlag = 3; // 조회 날짜 매개변수 flag (1: 오늘, 2: 하루 전, 3: 일주일 전, 4: 한달 전)
		
		// 요청 데이터 세팅
		try {
			this.nowPage = Integer.parseInt(request.getParameter("nowPage"));
			dateFlag = Integer.parseInt(request.getParameter("dateFlag"));
		} catch (Exception ex) { ex.printStackTrace(); }
		
		// 페이징 처리 후 결과값이 세팅된 매개변수 정의
		pageDto.setAdminPageDto(this.listSize, this.blockSize, this.nowPage, dateFlag); // 페이징 처리를 위한 도메인 객체
		pageDto.adminNewBoardPageCompute();
		
		Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("dateFlag", dateFlag);
		
		// board report list 저장 객체 선언
		List<BoardVo> bdvoList = null;
		
		// board report list 저장 객체 조회 및 세팅
		bdvoList = adminService.getNewBoardList(pagenatedInputData);
		if (bdvoList != null) {
			logger.info("[new board list - admin controller] 새로운 게시글 리스트 조회 완료");
			// board report list 에 대한 pageDto 생성
			PageDto bdPageDto = new PageDto();
			bdPageDto.setNowPage(pageDto.getNowPage());
			bdPageDto.setTotSize(pageDto.getTotSize());
			bdPageDto.setTotPage(pageDto.getTotPage());
			bdPageDto.setTotBlock(pageDto.getTotBlock());
			bdPageDto.setNowBlock(pageDto.getNowBlock());
			bdPageDto.setStartNo(pageDto.getStartNo());
			bdPageDto.setEndNo(pageDto.getEndNo());
			bdPageDto.setStartPage(pageDto.getStartPage());
			bdPageDto.setEndPage(pageDto.getEndPage());
			
			// 응답 객체에 세팅
			mav.addObject("bdvoList", bdvoList);
			mav.addObject("bdPageDto", bdPageDto);
		}
		
		mav.setViewName("/admin/adminBoardListPart"); // 리턴 경로
		return mav;
	}
	
	// 게시글 등록정보 가져오기
	@RequestMapping(value="/getNewBoardInfo/{serial}", method=RequestMethod.GET)
	public ModelAndView getNewBoardInfo (HttpServletRequest request, @PathVariable(name = "serial", required = false) int serial) {
		logger.info("[get now board info - admin controller] 새로운 게시글 정보 요청, serial : " + serial);
		ModelAndView mav = new ModelAndView();
		BoardVo bdvo = null;
		
		bdvo = adminService.getNewBoardInfo(serial);
		if (bdvo != null) {
			logger.info("[get new board info - admin controller] 새로운 게시글 정보 반환완료, serial : " + bdvo.getSerial());
			mav.addObject("bdvo", bdvo);
		}
		
		mav.setViewName("/admin/adminBoardControlPart");
		return mav;
	}
	
	/*
	 * member control
	 */
	// 회원정보 조회 및 컨트롤 페이지 로드
	@RequestMapping(value="/getMemberControlPart", method=RequestMethod.GET)
	public ModelAndView getMemberControlPart (HttpServletRequest request) {
		logger.info("[get member control part - admin controller] 멤버 컨트롤 페이지 요청");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/admin/adminMemberControlPart");
		return mav;
	}
	
	// 회원정보 조회
	@RequestMapping(value="/searchMemberInfo", method=RequestMethod.POST)
	public String searchMemberInfo (HttpServletRequest request) {
		String userId = request.getParameter("userId");
		logger.info("[search member info - admin controller] 회원정보 요청, userId : " + userId);
		MemberVo mbvo = null;
		
		mbvo = adminService.searchMemberInfo(userId);
		if (mbvo != null) {
			logger.info("[search member info - admin controller] 회원정보 요청 완료");
			request.setAttribute("mbvo", mbvo);
		} else {
			logger.info("[search member info - admin controller] 조회된 회원정보가 존재하지 않음");
		}
		/*if (mbvo != null) {
			jsonResult = "{\"userId\":\"" + mbvo.getUserId() + "\", \"mDate\":\"" + mbvo.getmDate() + "\", \"isBlocked\":\"" + mbvo.getIsBlocked() + "\"}";
			logger.info("[search member info - admin controller] 회원정보 요청 완료");
			logger.info("[search member info - admin controller] json 결과 : " + jsonResult);
		} else {
			jsonResult = "{\"userId\":\"\"}";
			logger.info("[search member info - admin controller] 조회된 회원정보가 존재하지 않음");
		}*/
		
		return "/admin/adminMemberSearchResultPart";
	}
	// 회원 블럭 처리
	@ResponseBody
	@RequestMapping(value="/memberBlockAction", method=RequestMethod.POST)
	public String memberBlockAction (HttpServletRequest request) {
		String result = "0";
		String userId = request.getParameter("userId");
		logger.info("[member block action - admin controller] 회원 블럭 처리, userId : " + userId);
		
		boolean blockResult = adminService.memberBlockAction(userId);
		if (blockResult) {
			logger.info("[member block action - admin controller] 회원 블럭 처리 완료!, userId : " + userId);
			result = "1";
		}
		
		return result;
	}
	// 회원 블럭 해제
	@ResponseBody
	@RequestMapping(value="/memberBlockFreeAction", method=RequestMethod.POST)
	public String memberBlockFreeAction (HttpServletRequest request) {
		String result = "0";
		String userId = request.getParameter("userId");
		logger.info("[member block free action - admin controller] 회원 블럭 해제, userId : " + userId);
		
		boolean blockFreeResult = adminService.memberBlockFreeAction(userId);
		if (blockFreeResult) {
			logger.info("[member block free action - admin controller] 회원 블럭 해제 완료!, userId : " + userId);
			result = "1";
		}
		
		return result;
	}
	
}
