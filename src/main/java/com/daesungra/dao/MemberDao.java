package com.daesungra.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.daesungra.domain.BoardVo;
import com.daesungra.domain.MemberVo;

public interface MemberDao {
	
	// login
	public MemberVo login (String userId, String userPwd);
	
	// select user info
	public MemberVo memberSelect (String userId);
	public List<MemberVo> memberList ();
	
	// join
	public boolean idCheck (String userId);
	public boolean memberInsert (MemberVo vo);
	
	// update
	public boolean memberUpdate (HttpServletRequest request, MemberVo vo);
	public boolean profileUpdate (HttpServletRequest request, MemberVo vo);
	
	// delete
	public boolean memberDelete (HttpServletRequest request);
	// public boolean memberDeleteConfirm (); // 보류
	
	// get my board list
	public List<BoardVo> selectMyBoardList (String userId);

	// get writer list
	public List<MemberVo> getWriterList ();
	// get writer info
	public MemberVo selectWriterInfo (Map<String, String> searchWriterMap);
	
	// follow / unfollow
	public boolean followAction (Map<String, String> searchWriterMap);
	public boolean unFollowAction (Map<String, String> searchWriterMap);
	public List<MemberVo> selectFolloweeList (String userId);
	
}
