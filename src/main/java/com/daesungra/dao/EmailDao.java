package com.daesungra.dao;

import com.daesungra.domain.MemberVo;

public interface EmailDao {

	public String selectUserId (MemberVo mbvo);
	public String selectUserPwd (MemberVo mbvo);
	
	
}
