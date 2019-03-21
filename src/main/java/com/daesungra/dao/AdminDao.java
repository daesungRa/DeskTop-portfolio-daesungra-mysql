package com.daesungra.dao;

import java.util.List;
import java.util.Map;

import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.MemberVo;

public interface AdminDao {
	
	// board report
	public List<BoardReportVo> selectBoardReportList (Map<String, Object> pagenatedInputData); // 신고 리스트
	public BoardReportVo selectBoardReportInfo (int serial); // 신고 정보 조회
	public boolean deleteBoardReport (int serial); // 신고 정보 처리 완료
	
	public boolean updateBoardBlockAction (int fSerial); // 신고된 게시글 블럭 처리
	public boolean updateBoardBlockFreeAction (int fSerial); // 블럭 해제
	
	// book register
	public List<BookVo> selectBookRegisterList (Map<String, Object> pagenatedInputData); // 새 책 등록요청 리스트
	public BookVo selectBookRegisterInfo (String bookNo);
	public boolean deleteBookRegisterInfo (String bookNo);
	public boolean updateBookRegisterInfo (BookVo bkvo);
	
	// new board
	public List<BoardVo> selectNewBoardList (Map<String, Object> pagenatedInputData);
	public BoardVo selectNewBoardInfo (int serial);
	
	// member control
	public MemberVo selectMemberInfo (String userId);
	public boolean memberBlockAction (String userId);
	public boolean memberBlockFreeAction (String userId);
	
}
