package com.daesungra.service;

import java.util.List;
import java.util.Map;

import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.CommentVo;

public interface BoardService {
	
	public List<BoardVo> getBoardList (Map<String, Object> pagenatedInputData);
	public BoardVo boardView (BoardVo bvo);
	public boolean boardWrite (BoardVo bvo); // 등록 및 수정 이후 해당 게시글 조회까지 수행
	public boolean boardModify (BoardVo bvo);
	public boolean boardRemove (BoardVo bvo);
	
	public boolean bookRegister (BookVo bkvo);
	public List<BookVo> getBookInfo (String search);
	
	public List<CommentVo> getCommentList (Map<String, Object> pagenatedInputData);
	public boolean commentWriteAction (CommentVo cvo);
	public boolean commentDeleteAction (CommentVo cvo);
	
	public boolean boardReport (BoardReportVo brvo);
	
	// thumbup / free
	public boolean boardThumbUp (BoardVo bvo);
	public boolean boardThumbUpFree (BoardVo bvo);
	
}
