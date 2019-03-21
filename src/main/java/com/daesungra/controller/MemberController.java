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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.daesungra.component.FileUpload;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.MemberVo;
import com.daesungra.service.MemberService;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService service;
	@Autowired
	private FileUpload fileUpload;
	
	/*
	 * login, logout, findId, findPwd
	 */
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String getLoginForm () {
		logger.info("call loginForm");
		
		return "/member/loginForm";
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login (@RequestParam(value="userId") String userId, @RequestParam(value="userPwd") String userPwd, HttpServletRequest request) {
		String result = "0";
		MemberVo vo = null;
		HttpSession session = request.getSession();
		logger.info("login 시작");
		vo = service.login(userId, userPwd);
		
		// 성공시 세션 세팅 후 인덱스로 이동, 실패시 실패 이유 알려주지 않음 (실패이유는 로그에 저장됨)
		if (vo != null) {
			// 블럭 상태가 아닐 시에만 세션 세팅
			if (vo.getIsBlocked() == 0) {
				// 아이디. 이름, 권한수준 세팅
				session.setAttribute("userId", vo.getUserId());
				session.setAttribute("userName", vo.getUserName());
				session.setAttribute("authority", vo.getAuthority());
				logger.info("login 성공");
				
				if (vo.getAuthority() == 0) {
					result = "1"; // 성공, 일반 유저
				} else if (vo.getAuthority() > 0) {
					result = "2"; // 성공, 관리자
				}
			} else if (vo.getIsBlocked() == 1) {
				result = "99";
			}
		} else {
			logger.info("login 실패");
			
			result = "0"; // 실패 플래그
		}
		
		return result;
	}
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout (HttpSession session) {
		session.invalidate();
		
		return "redirect:/"; // 로그아웃 후 메인으로 보냄
	}
	// 해야함
	@RequestMapping(value="/findIdForm", method=RequestMethod.GET)
	public String getfindIdForm () {
		logger.info("call findIdForm");
		
		return "/member/findIdForm";
	}
	@RequestMapping(value="/findPwdForm", method=RequestMethod.GET)
	public String getfindPwdForm () {
		logger.info("call findPwdForm");
		
		return "/member/findPwdForm";
	}
	
	/*
	 * join (create member, profile), id check
	 */
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String getJoinForm (Model model) {
		logger.info("call joinForm");
		
		return "/member/joinForm";
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join (HttpServletRequest request) {
		String result = "0";
		boolean insertResult = false;
		logger.info("join 시작");
		
		// 파일업로드 객체확인
		if (fileUpload == null) {
			logger.info("fileupload object is null");
		}
		
		// 파일 업로드 수행
		// vo 객체가 반환된다
		MemberVo vo = fileUpload.getMemberVo(request);
		
		if (vo != null) {
			logger.info("vo 생성완료");
			logger.info("oriFileName: " + vo.getPhotoOri() + ", sysFileName: " + vo.getPhoto());
			insertResult = service.memberRegister(vo);
			
			if (insertResult) {
				logger.info("join 성공");
				result = "1";
			} else {
				logger.info("join 실패");
			}
		} else {
			logger.info("vo 생성실패");
		}
		
		return result;
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/idChk", method=RequestMethod.POST)
	public String idChk (@RequestParam(value="userId") String userId) {
		String result = "0";
		logger.info("[idChk] get user id: " + userId);
		
		boolean checkResult = service.idCheck(userId);
		
		if (checkResult == true) {
			result = "1";
		}
		
		return result;
	}
	
	/*
	 * - 회원관리 -
	 * get mypage, get member info, get member profile, member modify, profile modify, member leave,
	 * get member list
	 */
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String getMyPage (HttpServletRequest request, RedirectAttributes attributes) {
		// MemberVo vo = null;
		logger.info("call myPage");
		
		// 로그인 정보가 있다면 해당 유저의 게시글 목록 불러오기
		// 로그인 정보가 없다면 메인 페이지로 리다이렉트
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) {
			List<BoardVo> bdvoList = service.getMyBoardList((String) request.getSession().getAttribute("userId"));
			
			if (bdvoList != null) {
				logger.info("[mypage - get my board list] 완료");
				request.setAttribute("bdvoList", bdvoList);
			}
		} else {
			attributes.addFlashAttribute("notLoginMsg", "접속 정보가 없습니다. 로그인 후 이용하세요");
			return "redirect:/";
		}
		
		/*vo = service.memberView((String) request.getSession().getAttribute("userId"));
		if (vo != null) {
			request.setAttribute("vo", vo);
		}*/
		
		return "/member/myPage";
	}
	
	@RequestMapping(value={"/memberProfileForm", "/memberInfoForm"}, method=RequestMethod.GET)
	public String getMemberInfo (HttpServletRequest request) {
		String result = "";
		String requestUri = request.getRequestURI();
		String requestPage = requestUri.substring(requestUri.lastIndexOf("/") + 1, requestUri.length());
		MemberVo vo = null; // 공갈 페이지라도 넘어가서 페이지 그림
		
		// 인터셉터 통과했다면, 세션에 저장된 아이디로 회원정보를 검색해 뷰에 반환한다
		if (requestPage.equals("memberProfileForm")) {
			logger.info("call " + requestPage + " page");

			result = "/member/memberProfileForm";
		} else if (requestPage.equals("memberInfoForm")) {
			logger.info("call " + requestPage + " page");
			
			result = "/member/memberInfoForm";
		}
		
		// 응답 flag 가 0 이면 세션정보 없음, 1 이면 조회결과 없음, 2 면 조회성공
		if (request.getSession().getAttribute("userId") != null && !request.getSession().getAttribute("userId").equals("")) { // 로그인 정보가 있다면 vo 초기화
			vo = service.memberView((String)request.getSession().getAttribute("userId"));
			
			if (vo == null) {
				request.setAttribute("flag", "1");
			} else {
				request.setAttribute("flag", "2");
			}
		} else {
			request.setAttribute("flag", "0");
		}

		request.setAttribute("memberVo", vo);
		return result;
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/memberList", method=RequestMethod.GET)
	public String memberList (HttpServletRequest request) {
		String result = "0";
		List<MemberVo> memberList = null;
		logger.info("call memberList");
		
		memberList = service.memberList();
		if (memberList != null) { // 회원리스트 조회결과가 있다면 세션에 세팅 후 result 에 "1" 세팅
			request.setAttribute("memberList", memberList);
			result = "1";
		}
		
		return result;
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/memberModify", method=RequestMethod.POST)
	public String memberModify (HttpServletRequest request) {
		String result = "0";
		boolean modifyResult = false;
		logger.info("modify 시작");
		
		// 파일업로드 객체확인
		if (fileUpload == null) {
			logger.info("fileupload object is null");
		}
		
		// 파일 업로드 수행
		// vo 객체가 반환된다
		MemberVo vo = fileUpload.getMemberVo(request);
		
		if (vo != null) {
			modifyResult = service.memberModify(request, vo);
			
			if (modifyResult) { // 성공했다면 result 를 "1" 로 초기화
				logger.info("modify 성공");
				request.getSession().setAttribute("userName", request.getParameter("userName"));
				result = "1";
			} else {
				logger.info("modify 실패");
			}
		} else {
			logger.info("[modify] vo 생성 실패");
		}
		
		return result;
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/profileModify", method=RequestMethod.POST)
	public String profileModify (HttpServletRequest request) {
		String result = "0";
		boolean modifyResult = false;
		logger.info("profile modify 시작");
		
		// 파일업로드 객체확인
		if (fileUpload == null) {
			logger.info("fileupload object is null");
		}
		
		// 파일 업로드 수행
		// vo 객체가 반환된다
		MemberVo vo = fileUpload.getProfileVo(request);
		
		if (vo != null) {
			vo.setUserId((String) request.getSession().getAttribute("userId"));
			modifyResult = service.profileModify(request, vo);
			
			if (modifyResult) { // 성공했다면 result 를 "1" 로 초기화
				logger.info("profile modify 성공");
				request.getSession().setAttribute("userName", vo.getUserName()); // 사용자가 이름을 변경할 수 있으므로 무조건 초기화 진행
				
				result = "1";
			} else {
				logger.info("profile modify 실패");
			}
		} else {
			logger.info("[profile modify] vo 생성 실패");
		}
		
		return result;
	}
	@ResponseBody // ViewResolver 를 거치지 않고 응답객체 자체를 반환. (json 에 주로 활용됨)
	@RequestMapping(value="/memberLeave", method=RequestMethod.POST)
	public String memberLeave (HttpServletRequest request) {
		String result = "0";
		boolean leaveResult = false;
		logger.info("memberLeave 시작");
		
		leaveResult = service.memberDelete(request);
		if (leaveResult) {
			logger.info("[memberLeave] 회원탈퇴 성공");
			if (!request.getSession().getAttribute("userId").equals("")) {
				request.getSession().invalidate(); // 세션이 존재한다면 해제
			}
			result = "1";
		} else {
			logger.info("[memberLeave] 회원탈퇴 실패");
		}
		
		return result;
	}
	
	/*
	 * 작가 페이지
	 */
	// 인기 작가 리스트, 3명까지
	@RequestMapping(value="/getWriterListPage", method=RequestMethod.GET)
	public String getWriterListPage (HttpServletRequest request) {
		logger.info("[member controller - call writer list page] 콜!");
		List<MemberVo> mbvoList = null;
		mbvoList = service.getWriterList();
		if (mbvoList != null) {
			request.setAttribute("mbvoList", mbvoList);
			logger.info("[member controller - call writer list page] 작가 리스트 세팅완료");
		}
		
		return "/writer/writerListPage";
	}
	// 작가 검색
	@RequestMapping(value="/searchWriterAction", method=RequestMethod.POST)
	public String searchWriterAction (HttpServletRequest request) {
		String userId = request.getParameter("search");
		MemberVo mbvo = null;
		logger.info("[member controller - search writer info] 작가 검색, userId : " + userId);
		
		// 작가 정보 조회
		Map<String, String> searchWriterMap = new HashMap<String, String>();
		searchWriterMap.put("follower", (String) request.getSession().getAttribute("userId")); // 팔로워 (자기자신)
		searchWriterMap.put("followee", userId); // 팔로우 당하는? 회원아이디
		mbvo = service.searchWriterInfo(searchWriterMap);
		request.setAttribute("mbvo", mbvo);
		
		// 해당 작가의 게시글 리스트 조회
		List<BoardVo> bdvoList = service.getMyBoardList(userId);
		
		if (bdvoList != null) {
			logger.info("[member controller - search writer info] 게시글 조회 완료");
			request.setAttribute("bdvoList", bdvoList);
		}
		
		return "/writer/selectedWriterPart";
	}
	
	/*
	 * 팔로우 로직
	 */
	// 팔로우 하기
	@ResponseBody
	@RequestMapping(value="/followAction", method=RequestMethod.POST)
	public String followAction (HttpServletRequest request) {
		String result = "0";
		String userId = request.getParameter("userId");
		
		// input 객체 생성
		Map<String, String> searchWriterMap = new HashMap<String, String>();
		searchWriterMap.put("follower", (String) request.getSession().getAttribute("userId")); // 팔로워 (자기자신)
		searchWriterMap.put("followee", userId); // 팔로우 당하는? 회원아이디
		logger.info("[member controller - follow action] 팔로우 시작");
		
		boolean followResult = service.followAction(searchWriterMap);
		if (followResult) {
			logger.info("[member controller - follow action] 팔로우 완료");
			result = "1";
		}
		
		return result;
	}
	
	// 팔로우 해제
	@ResponseBody
	@RequestMapping(value="/unFollowAction", method=RequestMethod.POST)
	public String unFollowAction (HttpServletRequest request) {
		String result = "0";
		String userId = request.getParameter("userId");
		
		// input 객체 생성
		Map<String, String> searchWriterMap = new HashMap<String, String>();
		searchWriterMap.put("follower", (String) request.getSession().getAttribute("userId")); // 팔로워 (자기자신)
		searchWriterMap.put("followee", userId); // 팔로우 당하는? 회원아이디
		logger.info("[member controller - unFollow action] 언팔로우 시작");
		
		boolean unFollowResult = service.unFollowAction(searchWriterMap);
		if (unFollowResult) {
			logger.info("[member controller - unFollow action] 언팔로우 완료");
			result = "1";
		}
		
		return result;
	}
	
	// 내가 팔로우하는 작가정보 리스트 조회
	@RequestMapping(value="/getFolloweeList")
	public ModelAndView getFolloweeList (HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String userId = (String) request.getSession().getAttribute("userId");
		logger.info("[member controller] call followee list, caller : " + userId);
		
		List<MemberVo> followeeList = service.getFolloweeList(userId);
		if (followeeList != null) {
			mav.addObject("followeeList", followeeList);
		}
		
		mav.setViewName("/member/followeeListPart");
		return mav;
	}
}