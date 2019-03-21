package com.daesungra.service;

import com.daesungra.domain.MemberVo;

public interface EmailService {

	public String findIdAction (MemberVo mbvo);
	public String findPwdAction (MemberVo mbvo);
	
}
