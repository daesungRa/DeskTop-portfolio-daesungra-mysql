package com.daesungra.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.daesungra.domain.BoardVo;
import com.daesungra.domain.MemberVo;

public interface MemberService {

	// login
	public MemberVo login (String userId, String userPwd); // ok
	
	// select user info
	public MemberVo memberView (String userId); // ok
	public MemberVo profileView (String userId);
	public List<MemberVo> memberList (); // ok
	
	// join
	public boolean idCheck (String userId); // ok
	public boolean memberRegister (MemberVo vo); // ok
	
	// update
	public boolean memberModify (HttpServletRequest request, MemberVo vo); // ok
	public boolean profileModify (HttpServletRequest request,MemberVo vo);
	
	// delete
	public boolean memberDelete (HttpServletRequest request); // ok
	
	// get my board list
	public List<BoardVo> getMyBoardList (String userId);
	
	// get writer list
	public List<MemberVo> getWriterList ();
	// get writer info
	public MemberVo searchWriterInfo (Map<String, String> searchWriterMap);
	
	// follow action / unfollow
	public boolean followAction (Map<String, String> searchWriterMap);
	public boolean unFollowAction (Map<String, String> searchWriterMap);
	public List<MemberVo> getFolloweeList (String userId);
	
}
