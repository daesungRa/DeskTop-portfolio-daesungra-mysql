package com.daesungra.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daesungra.component.FileUpload;
import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.CommentVo;
import com.daesungra.domain.PageDto;
import com.daesungra.service.BoardService;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private PageDto pageDto;
	@Autowired
	private FileUpload fileUpload;
	
	// 게시글 리스트 조회 및 페이징 처리를 위한 변수
	private int listSize = 20;
	private int blockSize = 5;
	private int nowPage = 1;
	
	private int searchBySort = 1; // 1: 최신순, 2: 오래된순, 3: 조회순, 4: 추천순
	private int searchByContent = 1; // 1: 제목 + 내용, 2: 제목만, 3: 내용만, 4: 작가별
	private String searchContent = ""; // 검색어

	/*
	 * 1. 페이징 처리 객체 생성 후 pagenation
	 * 2. 그 결과를 기반으로 매개변수 map 생성 (category, startNo, endNo)
	 * 3. map 을 매개변수로 받는 해당 카테고리 게시글 리스트 조회 (날짜순, 조회순)
	 * 4. request 객체에 페이지 객체, 날짜순 리스트, 조회순 리스트를 setAttribute 하고 반환
	 */
	// get board list
	// 카테고리별 전체검색 (날짜별, 조회별, get 방식)
	@RequestMapping(value="/boardListPage/{category}/{nowPage}", method=RequestMethod.GET)
	public String getBoardListPage (HttpServletRequest request, @PathVariable int category, @PathVariable(name = "nowPage", required = false) int nowPage) {
		logger.info("call boardListPage category : " + category);
		
		if (nowPage < 1) {
			nowPage = 1;
		}
		pageDto.setBoardPageDto(this.listSize, this.blockSize, this.nowPage, category); // 페이징 처리를 위한 도메인 객체
		pageDto.boardPageCompute();
		
		Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
		pagenatedInputData.put("category", category);
		pagenatedInputData.put("listSize", pageDto.getListSize());
		pagenatedInputData.put("startNo", pageDto.getStartNo());
		pagenatedInputData.put("endNo", pageDto.getEndNo());
		pagenatedInputData.put("searchBySort", 1);
		
		List<BoardVo> listDate = boardService.getBoardList(pagenatedInputData); // 날짜별 정렬결과 리스트
		
		pagenatedInputData.put("searchBySort", 3);
		List<BoardVo> listHit = boardService.getBoardList(pagenatedInputData); // 조회수별 정렬결과 리스트
		logger.info("[getBoardList] 검색 리스트 길이(date, hit) / 현재 페이지 >>> " + listDate.size() + ", " + listHit.size() + " / " + this.nowPage);
		
		request.setAttribute("boardListDate", listDate);
		request.setAttribute("boardListHit", listHit);
		request.setAttribute("pageDto", pageDto);
		request.setAttribute("category", category);
		
		return "/board/boardListPage";
	}
	
	// get board list including search content (검색 폼으로 검색시, ajax, post 방식)
	@RequestMapping(value="/boardListSearch", method=RequestMethod.POST)
	public String getBoardListWithSearch (HttpServletRequest request) {
		int category = 1;
		// form 전송내용 >> searchBySort, searchByContent, searchContent, category, nowPage
		try {
			this.searchBySort = Integer.parseInt(request.getParameter("searchBySort")); // 1: 최신순, 2: 오래된순, 3: 조회순, 4: 추천순
			this.searchByContent = Integer.parseInt(request.getParameter("searchByContent")); // 1: 제목 + 내용, 2: 제목만, 3: 내용만, 4: 작가별
			this.searchContent = request.getParameter("searchContent");
			category = Integer.parseInt(request.getParameter("category"));
			this.nowPage = Integer.parseInt(request.getParameter("nowPage"));
		} catch (Exception ex) { ex.printStackTrace(); }
		logger.info("[search board list]");
		logger.info("searchBySort, searchByContent, searchContent, category, nowPage : "
				+ searchBySort + ", " + searchByContent + ", " + searchContent + ", " + category + ", " + this.nowPage);
		
		pageDto.setPageDtoSearch(this.listSize, this.blockSize, this.nowPage, category, this.searchContent, this.searchByContent);
		pageDto.boardPageCompute();
		
		Map<String, Object> searchInputData = new HashMap<String, Object>();
		searchInputData.put("searchBySort", searchBySort);
		searchInputData.put("searchByContent", searchByContent);
		searchInputData.put("searchContent", searchContent);
		searchInputData.put("category", category);
		searchInputData.put("listSize", pageDto.getListSize());
		searchInputData.put("startNo", pageDto.getStartNo());
		searchInputData.put("endNo", pageDto.getEndNo());
		
		List<BoardVo> list = boardService.getBoardList(searchInputData); // 정렬결과 리스트
		logger.info("[getBoardList] 검색 리스트 길이 : " + list.size());
		
		request.setAttribute("boardList", list);
		request.setAttribute("pageDto", pageDto);
		request.setAttribute("category", category);
		request.setAttribute("searchInputData", searchInputData);
		
		return "/board/boardListViewPart";
	}
	
	/*
	 * regard to book info
	 */
	// search book info
	@ResponseBody // json 타입으로 반환하기 위함
	@RequestMapping(value="/searchBookInfo", method=RequestMethod.POST)
	public String searchBookInfo (HttpServletRequest request) {
		StringBuffer jsonResult = new StringBuffer();
		String search = request.getParameter("searchBookInfo");
		logger.info("search book info :" + search);
		
		List<BookVo> bookList = boardService.getBookInfo(search);
		if (bookList != null && bookList.size() > 0) { // 검색된 vo 객체만큼 json 타입 문자열 생성
			jsonResult.append("[" + bookList.get(0).toJson());
			for (int i = 1; i < bookList.size(); i++) {
				jsonResult.append(", " + bookList.get(i).toJson());
			}
			jsonResult.append("]");
		}
		
		logger.info("jsonResult : " + jsonResult.toString());
		return jsonResult.toString();
	}
	
	// load book register page
	@RequestMapping(value="/getBookRegisterForm", method=RequestMethod.GET)
	public ModelAndView getBookRegisterPage (HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.info("[get book register page] 책 등록 페이지 요청");
		mav.setViewName("/board/bookRegisterPart");
		
		return mav;
	}
	
	// book register action
	@ResponseBody
	@RequestMapping(value="/bookRegisterAction", method=RequestMethod.POST)
	public String bookRegisterAction (HttpServletRequest request) {
		String result = "0"; // 0: 실패, 1: 성공, 2: 접속정보 없음
		Boolean registerResult = false; 
		logger.info("[book register action] 책 등록 요청");
		
		// 파일업로드 객체확인
		if (fileUpload == null) {
			logger.info("fileupload object is null");
		}
		
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) { // 접속정보가 있다면
			// 파일 업로드 수행 후 BookVo 객체 반환
			BookVo bkvo = fileUpload.getBookVo(request);
			
			// 업로드 결과가 있다면 디비 저장 수행
			if (bkvo != null) {
				bkvo.setUserId((String) request.getSession().getAttribute("userId"));
				logger.info("[book register action] BookVo 생성완료====================");
				logger.info("bookNo: " + bkvo.getBookNo());
				logger.info("title_kor: " + bkvo.getTitle_kor());
				logger.info("title_eng: " + bkvo.getTitle_eng());
				logger.info("introduce: " + bkvo.getIntroduce());
				logger.info("author: " + bkvo.getAuthor());
				logger.info("category: " + bkvo.getCategory());
				logger.info("publisher: " + bkvo.getPublisher());
				logger.info("country: " + bkvo.getCountry());
				logger.info("coverImg: " + bkvo.getCoverImg());
				logger.info("coverImgOri: " + bkvo.getCoverImgOri());
				logger.info("pDate: " + bkvo.getpDate());
				logger.info("isPermitted: " + bkvo.getIsPermitted());
				logger.info("userId: " + bkvo.getUserId());
				logger.info("========================================");
				registerResult = boardService.bookRegister(bkvo);
				if (registerResult) {
					result = "1"; // 성공
				}
			}
		} else {
			result = "2"; // 접속정보 없음
		}
		
		return result;
	}
	
	// load board report page
	@RequestMapping(value="/getBoardReportForm", method=RequestMethod.GET)
	public ModelAndView getBoardReportPage (HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.info("[get board report page] 신고 페이지 요청");
		mav.setViewName("/board/boardReportPart");
		
		return mav;
	}
	
	// board report action
	@ResponseBody
	@RequestMapping(value="/boardReportAction", method=RequestMethod.POST)
	public String boardReportAction (HttpServletRequest request) {
		String result = "0"; // 0: 실패, 1: 성공, 2: 접속정보 없음
		boolean reportResult = false;
		logger.info("[board report action] 게시글 신고 요청 / rUserId, reportType : " + request.getParameter("rUserId") + ", " + request.getParameter("reportType"));
		
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) { // 접속정보가 있다면
			BoardReportVo brvo = new BoardReportVo(); // 매개변수 객체
			try {
				brvo.setfSerial(Integer.parseInt(request.getParameter("fSerial"))); // 신고할 게시글 시리얼
			} catch (Exception ex) { ex.printStackTrace(); }
			brvo.setrUserId((String) request.getSession().getAttribute("userId")); // 신고자 (세션에 저장된 아이디를 가져옴)
			brvo.setrContent(request.getParameter("rContent"));
			try {
				brvo.setReportType(Integer.parseInt(request.getParameter("reportType"))); // 신고 분류 > 1: (통)부적절한 게시글, 2: 광고, 3: 욕설, 4: 음란물, 5: 저작권 침해
			} catch (Exception ex) { ex.printStackTrace(); }
			
			reportResult = boardService.boardReport(brvo);
			if (reportResult) {
				result = "1"; // 성공
			}
		} else {
			result = "2"; // 접속정보 없음
		}
		
		return result;
	}
	
	/*
	 * board write
	 */
	// get write page
	@RequestMapping(value="/boardWritePage/{category}", method=RequestMethod.GET)
	public String getBoardWritePage (HttpServletRequest request, @PathVariable int category) {
		logger.info("call boardWritePage category:" + category);
		request.setAttribute("category", category);
		
		return "/board/boardWritePage";
	}
	
	// write action
	@ResponseBody
	@RequestMapping(value="/boardWriteAction", method=RequestMethod.POST)
	public String boardWriteAction (HttpServletRequest request, @ModelAttribute BoardVo bvo) {
		String resultStr = "0";
		boolean result = false;
		logger.info("call board write action");
		
		bvo.setUserId((String) request.getSession().getAttribute("userId")); // 제출할 게시글 정보에 유저아이디 추가
		result = boardService.boardWrite(bvo); // 게시글 등록 (userId, bookNo, category, title, content)
		if (result) { // 등록 성공 시
			resultStr = "1";
		}
		request.setAttribute("category", request.getParameter("category"));
		
		return resultStr; // 작성 후 해당 뷰 페이지로 이동
	}
	
	/*
	 * board view
	 */
	// view
	@RequestMapping(value="/boardViewPage/{serial}/{category}", method=RequestMethod.GET)
	public String getBoardViewPage (HttpServletRequest request, @PathVariable int serial, @PathVariable int category) {
		BoardVo resultVo = null;
		BoardVo insertVo = new BoardVo();
		logger.info("call boardViewPage serial, category : " + serial + ", " + category);
		
		insertVo.setSerial(serial);
		insertVo.setCategory(category);
		if (request.getSession().getAttribute("userId") != null) { // 접속정보가 있으면 아이디 세팅
			insertVo.setUserId((String) request.getSession().getAttribute("userId"));
		}
		
		resultVo = boardService.boardView(insertVo);
		if (resultVo != null) {
			// 조회 성공 시 해당하는 댓글 불러오기
			this.nowPage = 1; // 1 페이지 내용 불러온다
			pageDto.setCommentPageDto(this.listSize, this.blockSize, this.nowPage, serial); // board 테이블의 serial 은 댓글 테이블 입장에서 참조하는 fSerial 임
			pageDto.commentPageCompute();
			
			Map<String, Object> pagenatedInputData = new HashMap<String, Object>(); // 페이징 결과값을 포함한 db input data
			pagenatedInputData.put("fSerial", pageDto.getfSerial());
			pagenatedInputData.put("listSize", pageDto.getListSize());
			pagenatedInputData.put("startNo", pageDto.getStartNo());
			pagenatedInputData.put("endNo", pageDto.getEndNo());
			
			List<CommentVo> commentList = boardService.getCommentList(pagenatedInputData);
			logger.info("[boardview] comment list size : " + commentList.size());
			
			// 조회 결과 세팅
			request.setAttribute("boardVo", resultVo);
			request.setAttribute("commentList", commentList);
			request.setAttribute("category", resultVo.getCategory());
		} else {
			request.setAttribute("category", insertVo.getCategory());
		}
		
		return "/board/boardViewPage";
	}
	
	// thumbup
	@ResponseBody
	@RequestMapping(value="/boardThumbUp", method=RequestMethod.POST)
	public String boardThumbUp (HttpServletRequest request) {
		String result = "0";
		int boardSerial = -1;
		
		// 로그인 상태라면 실행, 아니라면 종료
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) {
			// input 객체 세팅
			try {
				boardSerial = Integer.parseInt(request.getParameter("serial"));
			} catch (Exception ex) { ex.printStackTrace(); }
			BoardVo bvo = new BoardVo();
			bvo.setSerial(boardSerial);
			bvo.setUserId((String) request.getSession().getAttribute("userId"));
			
			// 추천 실행
			boolean thumbupResult = boardService.boardThumbUp(bvo);
			if (thumbupResult) {
				result = "1";
			}
		}
		
		return result;
	}
	// thumbup free
	@ResponseBody
	@RequestMapping(value="/boardThumbUpFree", method=RequestMethod.POST)
	public String boardThumbUpFree (HttpServletRequest request) {
		String result = "0";
		int boardSerial = -1;
		
		// 로그인 상태라면 실행, 아니라면 종료
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) {
			// input 객체 세팅
			try {
				boardSerial = Integer.parseInt(request.getParameter("serial"));
			} catch (Exception ex) { ex.printStackTrace(); }
			BoardVo bvo = new BoardVo();
			bvo.setSerial(boardSerial);
			bvo.setUserId((String) request.getSession().getAttribute("userId"));
			
			// 추천 해제 실행
			boolean thumbupFreeResult = boardService.boardThumbUpFree(bvo);
			if (thumbupFreeResult) {
				result = "1";
			}
		}
		
		return result;
	}
	
	/*
	 * board modify
	 */
	// modify
	@RequestMapping(value="/boardModifyAction", method=RequestMethod.POST)
	public String boardModifyAction (HttpServletRequest request, @ModelAttribute BoardVo bvo) {
		boolean result = false;
		BoardVo resultVo = null;
		logger.info("call board modify action");
		
		bvo.setUserId((String) request.getSession().getAttribute("userId"));
		result = boardService.boardModify(bvo);
		if (result) { // modify 성공 시
			resultVo = boardService.boardView(bvo); // 해당 게시글 조회 및 세팅
			request.setAttribute("boardVo", resultVo);
			request.setAttribute("category", resultVo.getCategory());
		} else { // modify 실패 시
			request.setAttribute("category", bvo.getCategory()); // 카테고리만 세팅
		}
		
		return "/board/boardViewPage"; // 수정 후 해당 뷰 페이지로 이동
	}
	
	/*
	 * board remove
	 */
	// remove
	@ResponseBody
	@RequestMapping(value="/boardRemoveAction", method=RequestMethod.GET)
	public String boardRemoveAction (HttpServletRequest request, @ModelAttribute BoardVo bvo) {
		String result = "0";
		bvo.setUserId((String) request.getSession().getAttribute("userId"));
		logger.info("call remove action");
		logger.info("[remove] 요청 serial, userId : " + bvo.getSerial() + ", " + bvo.getUserId());
		
		boolean deleteResult = boardService.boardRemove(bvo);
		if (deleteResult) {
			result = "1";
			logger.info("[boare remove] 게시글 삭제 성공");
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/commentWriteAction", method=RequestMethod.POST)
	public String commentWriteAction (HttpServletRequest request, @ModelAttribute CommentVo cvo) {
		String boardSerial = "";
		boolean writeResult = false;
		logger.info("[comment write] 요청 fSerial, gSerial : " + cvo.getfSerial() + ", " + cvo.getgSerial());
		
		if (cvo.getfSerial() > 0) { // 요청 시리얼이 존재한다면
			cvo.setUserId((String) request.getSession().getAttribute("userId")); // 작성한 유저 아이디 세팅 
			writeResult = boardService.commentWriteAction(cvo);
			if (writeResult) { // 댓글 입력 성공시 참조하는 게시글의 시리얼을 반환하여 ajax 방식으로 해당 게시글의 view 페이지를 재호춣하도록 함
				boardSerial = String.valueOf(cvo.getfSerial());
				logger.info("[comment write] 댓글 쓰기 성공 (" + boardSerial + ")");
			}
		}
		
		return boardSerial;
	}
	
	@ResponseBody
	@RequestMapping(value="/commentDeleteAction", method=RequestMethod.POST)
	public String commentDeleteAction (HttpServletRequest request) {
		String result = "0";
		boolean deleteResult = false;
		CommentVo cvo = new CommentVo();
		cvo.setSerial(Integer.parseInt(request.getParameter("serial")));
		
		if (cvo.getSerial() > 0) { // 요청 시리얼이 존재한다면
			cvo.setUserId((String) request.getSession().getAttribute("userId")); // 작성한 유저 아이디 세팅 
			logger.info("[comment delete] 요청 serial, userId : " + cvo.getSerial() + ", " + cvo.getUserId());
			
			deleteResult = boardService.commentDeleteAction(cvo);
			if (deleteResult) { // 댓글 삭제 성공 시
				result = "1";
				logger.info("[comment delete] 댓글 삭제 성공");
			}
		}
		
		return result;
	}
}
