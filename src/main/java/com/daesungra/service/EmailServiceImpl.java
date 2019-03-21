package com.daesungra.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.daesungra.dao.EmailDao;
import com.daesungra.domain.MemberVo;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired
	private EmailDao emailDao;
	
	@Override
	public String findIdAction(MemberVo mbvo) {
		String result = "";
		result = emailDao.selectUserId(mbvo);
		
		return result;
	}
	
	@Override
	public String findPwdAction(MemberVo mbvo) {
		String result = "";
		result = emailDao.selectUserPwd(mbvo);
		
		return result;
	}

}
