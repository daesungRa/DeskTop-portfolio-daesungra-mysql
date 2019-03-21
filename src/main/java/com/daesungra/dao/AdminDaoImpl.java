package com.daesungra.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.daesungra.controller.AdminController;
import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.MemberVo;

@Repository
public class AdminDaoImpl implements AdminDao {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private SqlSession sqlSession;

	/*
	 * board report
	 */
	@Override
	public List<BoardReportVo> selectBoardReportList (Map<String, Object> pagenatedInputData) {
		List<BoardReportVo> brvoList = null;
		logger.info(pagenatedInputData.toString());
		brvoList = sqlSession.selectList("admin.getBoardReportList", pagenatedInputData);
		if (brvoList != null) {
			logger.info("[get board report list - dao] 조회 성공, 리스트 길이 : " + brvoList.size());
		} else {
			logger.info("[get board report list - dao] 조회 실패");
		}
		
		return brvoList;
	}
	@Override
	public BoardReportVo selectBoardReportInfo (int serial) {
		BoardReportVo brvo = null;
		brvo = sqlSession.selectOne("admin.selectBoardReportInfo", serial);
		
		return brvo;
	}
	@Override
	public boolean deleteBoardReport (int serial) {
		boolean result = false;
		int updateResult = sqlSession.update("admin.deleteBoardReport", serial);
		if (updateResult > 0) {
			logger.info("[board report delete - dao] 신고 요청 처리 성공");
			result = true;
		}
		
		return result;
	}
	@Override
	public boolean updateBoardBlockAction (int fSerial) {
		boolean result = false;
		int updateResult = sqlSession.update("admin.updateBoardBlock", fSerial);
		if (updateResult > 0) {
			logger.info("[block reported board - dao] 블럭 처리 완료");
			result = true;
		}
		
		return result;
	}
	@Override
	public boolean updateBoardBlockFreeAction (int fSerial) {
		boolean result = false;
		int updateResult = sqlSession.update("admin.updateBoardBlockFree", fSerial);
		if (updateResult > 0) {
			logger.info("[free blocked board - dao] 블럭 해제 완료");
			result = true;
		}
		
		return result;
	}
	
	/*
	 * book register
	 */
	@Override
	public List<BookVo> selectBookRegisterList (Map<String, Object> pagenatedInputData) {
		List<BookVo> bkvoList = null;
		bkvoList = sqlSession.selectList("admin.getBookRegisterList", pagenatedInputData);
		if (bkvoList != null) {
			logger.info("[get book register list - dao] 조회 성공, 리스트 길이 : " + bkvoList.size());
		} else {
			logger.info("[get book register list - dao] 조회 실패");
		}
		
		return bkvoList;
	}
	@Override
	public BookVo selectBookRegisterInfo (String bookNo) {
		BookVo bkvo = null;
		bkvo = sqlSession.selectOne("admin.selectBookRegisterInfo", bookNo);
		if (bkvo != null) {
			logger.info("[get book register info - dao] 조회 성공, bookNo : " + bkvo.getBookNo());
		}
		
		return bkvo;
	}
	@Override
	public boolean deleteBookRegisterInfo (String bookNo) {
		boolean result = false;
		logger.info("[book register prohibit - dao] 거부 시작, bookNo : " + bookNo);
		
		int updateResult = sqlSession.update("admin.deleteBookRegister", bookNo);
		if (updateResult > 0) {
			logger.info("[book register prohibit - dao] 거부 완료, bookNo : " + bookNo);
			result = true;
		}
		
		return result;
	}
	@Override
	public boolean updateBookRegisterInfo (BookVo bkvo) {
		boolean result = false;
		int updateResult = 0;
		logger.info("[book register permit - dao] 허가 시작, bookNo : " + bkvo.getBookNo());
		
		// 새로 수정되는 커버이미지가 있다면, 기존의 이미지 정보를 select 하여 실제 경로에서 삭제 후 저장한다
		if (!bkvo.getCoverImg().equals("")) {
			BookVo temp = sqlSession.selectOne("admin.selectBookRegisterInfo", bkvo.getOriBookNo());
			String delCoverImg = temp.getCoverImg();
			String delFilePath = "D://git/DeskTop-portfolio-daesungra/src/main/webapp/resources/imgs/bookAttFiles/" + delCoverImg.substring(delCoverImg.lastIndexOf("/") + 1, delCoverImg.length());
			
			// 해당 경로 파일이 존재하는지 확인 후 삭제
			File delFile = new File(delFilePath);
			if (delFile.exists()) {
				delFile.delete();
				logger.info("[book register permit - dao] 기존 파일 존재함!, 삭제! >> " + delFilePath);
			}
			
			// 이후 정상 저장
			updateResult = sqlSession.update("admin.permitBookRegister", bkvo);
		} else {
			// 새로 수정되는 커버이미지가 없다면 바로 저장하되, 이미지 변수에는 공백 문자열이 들어 있으므로
			// 기존 이미지 문자열을 select 해서 세팅 후 다시 저장한다
			BookVo temp = sqlSession.selectOne("admin.selectBookRegisterInfo", bkvo.getOriBookNo());
			String coverImg = temp.getCoverImg();
			String coverImgOri = temp.getCoverImgOri();
			
			bkvo.setCoverImg(coverImg);
			bkvo.setCoverImgOri(coverImgOri);
			updateResult = sqlSession.update("admin.permitBookRegister", bkvo);
		}
		
		// 쿼리 결과에 따른 완료 유무 처리
		if (updateResult > 0) {
			logger.info("[book register permit - dao] 허가 완료, bookNo : " + bkvo.getBookNo());
			result = true;
		} else {
			logger.info("[book register permit - dao] 허가 실패, bookNo : " + bkvo.getBookNo());
		}
		
		return result;
	}
	
	/*
	 * new board
	 */
	@Override
	public List<BoardVo> selectNewBoardList (Map<String, Object> pagenatedInputData) {
		List<BoardVo> bdvoList = null;
		bdvoList = sqlSession.selectList("admin.getNewBoardList", pagenatedInputData);
		if (bdvoList != null) {
			logger.info("[get new board list - dao] 조회 성공, 리스트 길이 : " + bdvoList.size());
		} else {
			logger.info("[get new board list - dao] 조회 실패");
		}
		
		return bdvoList;
	}
	@Override
	public BoardVo selectNewBoardInfo (int serial) {
		BoardVo bdvo = null;
		bdvo = sqlSession.selectOne("admin.selectNewBoardInfo", serial);
		if (bdvo != null) {
			logger.info("[get new board info - dao] 새로운 게시글 조회 성공, serial : " + bdvo.getSerial());
		}
		
		return bdvo;
	}
	
	/*
	 * member control
	 */
	@Override
	public MemberVo selectMemberInfo (String userId) {
		MemberVo mbvo = null;
		mbvo = sqlSession.selectOne("admin.getMemberInfo", userId);
		if (mbvo != null) {
			logger.info("[search member info - dao] 회원 정보 조회 완료, serial : " + mbvo.getUserId());
			logger.info("[search member info - dao] isBlocked : " + mbvo.getIsBlocked());
		}
		
		return mbvo;
	}
	@Override
	public boolean memberBlockAction (String userId) {
		boolean result = false;
		int blockResult = sqlSession.update("admin.memberBlockAction", userId);
		if (blockResult > 0) {
			logger.info("[block member - dao] 회원 블럭 처리 완료, userId : " + userId);
			result = true;
		}
		
		return result;
	}
	@Override
	public boolean memberBlockFreeAction (String userId) {
		boolean result = false;
		int blockFreeResult = sqlSession.update("admin.memberBlockFreeAction", userId);
		if (blockFreeResult > 0) {
			logger.info("[block member free - dao] 회원 블럭 해제 완료, userId : " + userId);
			result = true;
		}
		
		return result;
	}
}
