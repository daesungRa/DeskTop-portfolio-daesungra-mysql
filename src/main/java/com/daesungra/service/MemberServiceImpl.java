package com.daesungra.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.daesungra.component.GetHashedData;
import com.daesungra.controller.MemberController;
import com.daesungra.dao.MemberDao;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.MemberSaltVo;
import com.daesungra.domain.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberDao dao;
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 성공하면 vo 그대로 반환, 실패면 null 반환
	// vo 를 반환하는 이유는, 로그인 성공 시 세션 세팅을 위해서
	@Override
	public MemberVo login (String userId, String userPwd) {
		MemberVo vo = null;
		logger.info("[MemberService] login 시작");
		
		vo = dao.login(userId, userPwd);
		
		return vo;
	}

	@Override
	public MemberVo memberView (String userId) {
		MemberVo vo = null;
		vo = dao.memberSelect(userId);
		
		return vo;
	}
	
	// 등록된 프로필 조회
	@Override
	public MemberVo profileView (String userId) {
		MemberVo vo = null;
		
		return vo;
	}
	
	// 회원목록 조회
	@Override
	public List<MemberVo> memberList () {
		List<MemberVo> memberList = null;
		memberList = dao.memberList();
		
		return memberList;
	}
	
	// result 1 이면 중복 아이디가 존재하는 것, 0 이면 없는 것
	@Override
	public boolean idCheck (String userId) {
		boolean result = false;
		
		// id check
		result= dao.idCheck(userId);
		
		return result;
	}
	
	// 파일 업로드 결과정보까지 포함된 vo 객체를 받아서 dao 로 db 에 투입함
	@Override
	public boolean memberRegister (MemberVo vo) {
		boolean result = false;
		logger.info("[MemberService] register 시작");
		
		/*
		 * 비밀번호 암호화 처리
		 */
		// 소금코드 생성 후
		// 소금 + 비밀번호 결과를 해싱
		String saltData = GetHashedData.generateRandomString();
		String userPwd = GetHashedData.generateHashedString(saltData + vo.getUserPwd());
		logger.info("[join] 비밀번호 해싱 결과 (saltData, userPwd) : " + saltData + ", " + userPwd);
		
		// 해싱 결과가 있다면 vo 에 생성된 비밀번호 해시코드 세팅
		if (userPwd != null && !userPwd.equals("")) {
			vo.setUserPwd(userPwd);
		}
		
		// dmember 에 저장
		result = dao.memberInsert(vo);

		// 회원등록 성공 시 소금코드를 db 에 저장
		if (result && userPwd != null && !userPwd.equals("")) {
			// salt vo 객체 생성
			MemberSaltVo svo = new MemberSaltVo();
			svo.setUserId(vo.getUserId());
			svo.setSaltData(saltData);
			
			// insert 실행
			int r = sqlSession.insert("member.saltInsert", svo);
			
			if (r > 0) { // saltInsert 성공 시 커밋
				logger.info("[memberRegister] db 에 salt 코드 저장 성공");
				// sqlSession.commit();
			} else {
				logger.info("[memberRegister] db 에 salt 코드 저장 실패");
				// sqlSession.rollback();
			}  // sqlSessionTemplate 사용 시, 프로그램 단위에서 트랜잭션 제어는 불가능함!!
			// 일단은 걍 믿고 쓸것
			// 추후 프로그램 단위에서 트랜잭션 제어하는 방법을 찾아볼 것
		}
		
		return result;
	}
	
	// 회원정보 수정
	@Override
	public boolean memberModify (HttpServletRequest request, MemberVo vo) {
		boolean result = false;
		result = dao.memberUpdate(request, vo);
		
		return result;
	}
	
	// 프로필 수정 (비공개는 isPublic = '0')
	// 회원정보 삭제 시 cascade
	@Override
	public boolean profileModify (HttpServletRequest request, MemberVo vo) {
		boolean result = false;
		result = dao.profileUpdate(request, vo);
		
		return result;
	}
	
	// 회원정보 삭제
	// 게시글이 존재하면 실패할 수 있음
	@Override
	public boolean memberDelete (HttpServletRequest request) {
		boolean result = false;
		result = dao.memberDelete(request);
		
		return result;
	}
	
	// get my board list
	@Override
	public List<BoardVo> getMyBoardList (String userId) {
		List<BoardVo> bvoList = null;
		bvoList = dao.selectMyBoardList(userId);
		
		return bvoList;
	}
	
	// get writer list
	@Override
	public List<MemberVo> getWriterList () {
		List<MemberVo> mbvoList = null;
		mbvoList = dao.getWriterList();
		
		return mbvoList;
	}
	// get writer info
	@Override
	public MemberVo searchWriterInfo (Map<String, String> searchWriterMap) {
		MemberVo mbvo = null;
		mbvo = dao.selectWriterInfo(searchWriterMap);
		
		return mbvo;
	}
	
	// follow / unfollow
	@Override
	public boolean followAction (Map<String, String> searchWriterMap) {
		boolean result = false;
		result = dao.followAction(searchWriterMap);
		
		return result;
	}
	@Override
	public boolean unFollowAction (Map<String, String> searchWriterMap) {
		boolean result = false;
		result = dao.unFollowAction(searchWriterMap);
		
		return result;
	}
	@Override
	public List<MemberVo> getFolloweeList (String userId) {
		List<MemberVo> followeeList = null;
		followeeList = dao.selectFolloweeList(userId);
		
		return followeeList;
	}
	
}
