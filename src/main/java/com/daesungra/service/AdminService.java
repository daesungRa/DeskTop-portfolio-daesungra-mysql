package com.daesungra.service;

import java.util.List;
import java.util.Map;

import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.MemberVo;

public interface AdminService {
	
	// board report
	public List<BoardReportVo> getBoardReportList (Map<String, Object> pagenatedInputData); // 신고 리스트
	public BoardReportVo getBoardReportInfo (int serial); // 신고 정보 조회
	public boolean boardReportCompleteAction (int serial); // 신고 정보 처리 완료
	
	public boolean boardBlockAction (int fSerial); // 신고된 게시글 블럭 처리
	public boolean boardBlockFreeAction (int fSerial); // 블럭 해제
	
	// book register
	public List<BookVo> getBookRegisterList (Map<String, Object> pagenatedInputData); // 새 책 등록요청 리스트
	public BookVo getBookRegisterInfo (String bookNo);
	public boolean prohibitBookRegister (String bookNo);
	public boolean permitBookRegister (BookVo bkvo);
	
	// new board
	public List<BoardVo> getNewBoardList (Map<String, Object> pagenatedInputData);
	public BoardVo getNewBoardInfo (int serial);
	
	// member control
	public MemberVo searchMemberInfo (String userId);
	public boolean memberBlockAction (String userId);
	public boolean memberBlockFreeAction (String userId);
	
}
