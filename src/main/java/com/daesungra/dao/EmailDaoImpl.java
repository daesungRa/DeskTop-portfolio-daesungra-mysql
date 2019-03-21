package com.daesungra.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.daesungra.component.GetHashedData;
import com.daesungra.controller.EmailController;
import com.daesungra.domain.MemberSaltVo;
import com.daesungra.domain.MemberVo;

@Repository
public class EmailDaoImpl implements EmailDao {
	
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	@Autowired
	private SqlSession sqlSession;

	@Override
	public String selectUserId(MemberVo mbvo) {
		String result = "";
		logger.info("[email dao] call find id");
		logger.info("[email dao] 요청정보 / 이름, 이메일 : " + mbvo.getUserName() + ", " + mbvo.getEmail());
		
		result = sqlSession.selectOne("email.findId", mbvo);
		if (result != null && !result.equals("")) {
			logger.info("[email dao] 아이디 조회 성공");
		}
		
		return result;
	}

	@Override
	public String selectUserPwd(MemberVo mbvo) {
		String result = "";
		logger.info("[email dao] call find pwd");
		logger.info("[email dao] 요청정보 / 아이디, 이름, 이메일 : " + mbvo.getUserId() + ", " + mbvo.getUserName() + ", " + mbvo.getEmail());
		
		String pwdResult = sqlSession.selectOne("email.findPwd", mbvo);
		if (pwdResult != null && !pwdResult.equals("")) {
			logger.info("[email dao] 비밀번호 조회 성공");
			// 업데이트를 위한 객체 생성
			MemberSaltVo mbsvo = new MemberSaltVo();
			
			// 새로운 비밀번호와 salt 값과 생성 후 그것을 디비에 저장
			String tempPwd = GetHashedData.generateRandomString(); // new pwd, 이것을 임시 비밀번호로 반환할 것임
			String saltData = GetHashedData.generateRandomString(); // new salt data
			pwdResult = GetHashedData.generateHashedString(saltData + tempPwd); // update pwd in db
			
			// 새로운 데이터 저장
			mbsvo.setUserId(mbvo.getUserId());
			mbsvo.setSaltData(saltData);
			int i = sqlSession.update("email.updateSaltData", mbsvo);
			if (i > 0) {
				// 새로운 임시비번 세팅 후 저장
				mbvo.setUserPwd(pwdResult);
				i = sqlSession.update("email.updatePwd", mbvo);
				if (i > 0) {
					result = tempPwd;
					logger.info("[email dao] 임시 비밀번호 생성 후 저장 완료 / salt, pwd : " + saltData + ", " + result);
				}
			}
		}
		
		return result;
	}

}
