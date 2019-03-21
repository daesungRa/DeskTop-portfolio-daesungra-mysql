package com.daesungra.dao;

import java.util.List;
import java.util.Map;

import com.daesungra.domain.BoardReportVo;
import com.daesungra.domain.BoardVo;
import com.daesungra.domain.BookVo;
import com.daesungra.domain.CommentVo;

public interface BoardDao {

	public List<BoardVo> getBoardList (Map<String, Object> pagenatedInputData);
	public BoardVo boardSelect (BoardVo bvo);
	public boolean boardInsert (BoardVo bvo);
	public boolean boardUpdate (BoardVo bvo);
	public boolean boardDelete (BoardVo bvo);

	public boolean bookInsert (BookVo bkvo);
	public List<BookVo> getBookInfo (String search);
	
	public List<CommentVo> getCommentList (Map<String, Object> pagenatedInputData);
	public boolean commentInsert (CommentVo cvo);
	public boolean commentDelete (CommentVo cvo);
	
	public boolean boardReportInsert (BoardReportVo brvo);
	
	// thumbup / free
	public boolean boardThumbUp (BoardVo bvo);
	public boolean boardThumbUpFree (BoardVo bvo);
	
}
