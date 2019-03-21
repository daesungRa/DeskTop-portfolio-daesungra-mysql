package com.daesungra.component;

import java.io.File;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.daesungra.domain.BookVo;
import com.daesungra.domain.MemberVo;

/*
 * 파일 업로드를 위한 멀티파트 객체 활용
 * 반환값은 각 요청 형식에 맞는 vo 객체이다
 */
@Repository
public class FileUpload {
	private MemberVo mvo = null;
	private BookVo bkvo = null;

	private String oriFileName = "";
	private String sysFileName = "";
	private String saveDir = "D://git/DeskTop-portfolio-daesungra/src/main/webapp/resources/imgs/memberImg/";
	private String saveDirBookInfo = "D://git/DeskTop-portfolio-daesungra/src/main/webapp/resources/imgs/bookAttFiles/";
	
	// constructor
	// 저장 경로를 세팅
	public FileUpload () {
		
	}
	
	// 전달받은 요청 객체의 파일을 multipart 인스턴스를 활용해 서버에 저장한 후 (sysFileName)
	// 오리지널 파일명, 실제 저장 파일명 구분해 vo 객체 생성 후 반환
	public MemberVo getMemberVo (HttpServletRequest request) {		
		// 프로젝트의 실제 절대경로가 존재한다면 그것으로 세팅
		File file = new File(request.getSession().getServletContext().getRealPath("/"));
		if (file.isDirectory()) {
			// 저장 디렉토리 절대경로 설정
			saveDir = request.getSession().getServletContext().getRealPath("/resources/imgs/memberImg/");
			saveDirBookInfo = request.getSession().getServletContext().getRealPath("/resources/imgs/bookAttFiles/");
			System.out.println("[File Upload] 절대경로 지정 완료!");
		}
		
		try {
			// enctype='multipart/form-data' 방식으로 넘어온 요청정보를 다루기 위해 
			// 스프링 컨테이너에 포함된 MultipartHttpServletRequest 객체로 변환하여 사용한다
			// 이 클래스는 HttpServletRequest, MultipartRequest, ServletRequest 의 세 인터페이스를 구현한 자손 인터페이스이므로
			// 같은 계열 request 객체를 캐스팅해 활용 가능하다
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
			Iterator<String> ite = multi.getFileNames();
			if (ite.hasNext()) { // 어차피 업로드 파일은 한개이므로
				String tagName = ite.next();
				MultipartFile mFile = multi.getFile(tagName);
				
				// 전달받은 파일 확인
				System.out.println("file form name : " + mFile.getName());
				System.out.println("ori file name : " + mFile.getOriginalFilename());
				System.out.println("file size : " + mFile.getSize());
				System.out.println("is existing? : " + mFile.isEmpty());
				
				// 오리지널 파일명, 인코딩 처리
				oriFileName = new String(mFile.getOriginalFilename().getBytes("8859_1"), "utf-8");
				// 실제 저장 파일명은 오리지널 파일명으로 지정했다가, 추후 지정 경로에 동일 파일명이 존재하면 수정한다
				sysFileName = oriFileName;
				
				// 지정 경로에 파일 저장하기
				// 저장할 파일이 존재한다면 수행
				if (sysFileName != null && !sysFileName.equals("")) {
					// 지정 경로에 동일 파일명이 이미 존재한다면 실제 저장 파일명 변경 (시스템 시각을 더함)
					if (new File(saveDir + sysFileName).exists()) {
						String preName = sysFileName.substring(0, sysFileName.lastIndexOf("."));
						String postName = sysFileName.substring(sysFileName.lastIndexOf("."), sysFileName.length());
						System.out.println("preName: " + preName + ", postName: " + postName);
						sysFileName = preName + "_" + System.currentTimeMillis() + postName; // 같은 파일명이 존재하므로 저장파일명 변경
					}
					
					// 컨테이너에 임시 파일로 저장되어 있으므로, 실제 지정 경로로 transfer 해야 한다
					// InputStream 사용해도 됨
					mFile.transferTo(new File(saveDir + sysFileName)); // 최종 조립된 이름으로 지정 경로로 전송(저장)
					System.out.println("================================");
					System.out.println("[result] ori : " + oriFileName);
					System.out.println("[result] sys : " + sysFileName);
					
					// 파일 저장까지 완료했다면, 반환할 vo 객체를 생성한다
					// 여기에 ori, sys 파일을 구분해서 세팅한다
					this.mvo = new MemberVo();
					
					// id, pwd, name, email, phone 은 필수입력사항
					mvo.setUserId(multi.getParameter("userId"));
					mvo.setUserPwd(multi.getParameter("userPwd"));
					mvo.setUserName(multi.getParameter("userName"));
					mvo.setEmail(multi.getParameter("email"));
					mvo.setPhone(multi.getParameter("phone"));
					// 넘어온 postal 이 존재한다면
					if (multi.getParameter("postal") != null && !multi.getParameter("postal").equals("")) {
						mvo.setPostal(multi.getParameter("postal"));
					} else {
						mvo.setPostal("");
					}
					// 추가주소가 있다면,
					if (multi.getParameter("address") != null && !multi.getParameter("address").equals("") && !multi.getParameter("addressAdd").equals("")) {
						mvo.setAddress(multi.getParameter("address"));
						mvo.setAddressAdd(multi.getParameter("addressAdd"));
					} else if (multi.getParameter("address") != null && !multi.getParameter("address").equals("")) {
						mvo.setAddress(multi.getParameter("address"));
						mvo.setAddressAdd("");
					} else {
						mvo.setAddress("");
						mvo.setAddressAdd("");
					}
					mvo.setPhoto("/desktop/resources/imgs/memberImg/" + sysFileName); // 실제 저장 파일명. 나중에 쉽게 가져오기 위해 (contextPath 기반)전체 경로 입력
					mvo.setPhotoOri(oriFileName); // 사용자에게 보여질 오리지널 파일명
				} else {
					// 저장에 성공한 파일이 존재하지 않거나
					// 애초에 요청받은 파일 정보가 없는 경우 파일을 제외한 정보만 저장됨
					this.mvo = new MemberVo();
					
					mvo.setUserId(multi.getParameter("userId"));
					mvo.setUserPwd(multi.getParameter("userPwd"));
					mvo.setUserName(multi.getParameter("userName"));
					mvo.setEmail(multi.getParameter("email"));
					mvo.setPhone(multi.getParameter("phone"));
					// 넘어온 postal 이 존재한다면
					if (multi.getParameter("postal") != null && !multi.getParameter("postal").equals("")) {
						mvo.setPostal(multi.getParameter("postal"));
					} else {
						mvo.setPostal("");
					}
					// 추가주소가 있다면,
					if (multi.getParameter("address") != null && !multi.getParameter("address").equals("") && !multi.getParameter("addressAdd").equals("")) {
						mvo.setAddress(multi.getParameter("address"));
						mvo.setAddressAdd(multi.getParameter("addressAdd"));
					} else if (multi.getParameter("address") != null && !multi.getParameter("address").equals("")) {
						mvo.setAddress(multi.getParameter("address"));
						mvo.setAddressAdd("");
					} else {
						mvo.setAddress("");
						mvo.setAddressAdd("");
					}
					mvo.setPhoto("");
					mvo.setPhotoOri("");
				}
			} else if (multi.getParameter("photo") == null || multi.getParameter("photo").equals("")) {
				this.mvo = new MemberVo();
				
				mvo.setUserId(multi.getParameter("userId"));
				mvo.setUserPwd(multi.getParameter("userPwd"));
				mvo.setUserName(multi.getParameter("userName"));
				mvo.setEmail(multi.getParameter("email"));
				mvo.setPhone(multi.getParameter("phone"));
				// 넘어온 postal 이 존재한다면
				if (multi.getParameter("postal") != null && !multi.getParameter("postal").equals("")) {
					mvo.setPostal(multi.getParameter("postal"));
				} else {
					mvo.setPostal("");
				}
				// 추가주소가 있다면,
				if (multi.getParameter("address") != null && !multi.getParameter("address").equals("") && !multi.getParameter("addressAdd").equals("")) {
					mvo.setAddress(multi.getParameter("address"));
					mvo.setAddressAdd(multi.getParameter("addressAdd"));
				} else if (multi.getParameter("address") != null && !multi.getParameter("address").equals("")) {
					mvo.setAddress(multi.getParameter("address"));
					mvo.setAddressAdd("");
				} else {
					mvo.setAddress("");
					mvo.setAddressAdd("");
				}
				mvo.setPhoto("");
				mvo.setPhotoOri("");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return this.mvo;
	}
	
	// 프로파일 수정을 위한 객체생성
	// 정보는 > nickName, interest, introduce, isPublic (DMEMBER_PROFILE), 그리고 경우에 따라 photo (DMEMBER)
	public MemberVo getProfileVo (HttpServletRequest request) {		
		// 프로젝트의 실제 절대경로가 존재한다면 그것으로 세팅
		File file = new File(request.getSession().getServletContext().getRealPath("/"));
		if (file.isDirectory()) {
			// 저장 디렉토리 절대경로 설정
			saveDir = request.getSession().getServletContext().getRealPath("/resources/imgs/memberImg/");
			saveDirBookInfo = request.getSession().getServletContext().getRealPath("/resources/imgs/bookAttFiles/");
			System.out.println("[File Upload] 절대경로 지정 완료! : " + file.getPath());
		} else {
			System.out.println("[File Upload] 절대경로 지정 실패 : " + file.getPath());
		}
		
		try {
			// enctype='multipart/form-data' 방식으로 넘어온 요청정보를 다루기 위해 
			// 스프링 컨테이너에 포함된 MultipartHttpServletRequest 객체로 변환하여 사용한다
			// 이 클래스는 HttpServletRequest, MultipartRequest, ServletRequest 의 세 인터페이스를 구현한 자손 인터페이스이므로
			// 같은 계열 request 객체를 캐스팅해 활용 가능하다
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
			Iterator<String> ite = multi.getFileNames();
			if (ite.hasNext()) { // 어차피 업로드 파일은 한개이므로
				String tagName = ite.next();
				MultipartFile mFile = multi.getFile(tagName);
				
				// 전달받은 파일 확인
				System.out.println("file form name : " + mFile.getName());
				System.out.println("ori file name : " + mFile.getOriginalFilename());
				System.out.println("file size : " + mFile.getSize());
				System.out.println("is existing? : " + mFile.isEmpty());
				
				// 오리지널 파일명, 인코딩 처리
				oriFileName = new String(mFile.getOriginalFilename().getBytes("8859_1"), "utf-8");
				// 실제 저장 파일명은 오리지널 파일명으로 지정했다가, 추후 지정 경로에 동일 파일명이 존재하면 수정한다
				sysFileName = oriFileName;
				
				// 지정 경로에 파일 저장하기
				// 저장할 파일이 존재한다면 수행
				if (sysFileName != null && !sysFileName.equals("")) {
					// 지정 경로에 동일 파일명이 이미 존재한다면 실제 저장 파일명 변경 (시스템 시각을 더함)
					if (new File(saveDir + sysFileName).exists()) {
						String preName = sysFileName.substring(0, sysFileName.lastIndexOf("."));
						String postName = sysFileName.substring(sysFileName.lastIndexOf("."), sysFileName.length());
						System.out.println("preName: " + preName + ", postName: " + postName);
						sysFileName = preName + "_" + System.currentTimeMillis() + postName; // 같은 파일명이 존재하므로 저장파일명 변경
					}
					
					// 컨테이너에 임시 파일로 저장되어 있으므로, 실제 지정 경로로 transfer 해야 한다
					// InputStream 사용해도 됨
					mFile.transferTo(new File(saveDir + sysFileName)); // 최종 조립된 이름으로 지정 경로로 전송(저장)
					System.out.println("================================");
					System.out.println("[result] ori : " + oriFileName);
					System.out.println("[result] sys : " + sysFileName);
					
					// 파일 저장까지 완료했다면, 반환할 vo 객체를 생성한다
					// 여기에 ori, sys 파일을 구분해서 세팅한다
					this.mvo = new MemberVo();
					
					// profile 이므로 nickName, interest, introduce, isPublic, photo 입력
					mvo.setNickName(multi.getParameter("nickName"));
					mvo.setInterest(multi.getParameter("interest"));
					mvo.setIntroduce(multi.getParameter("introduce"));
					try {
						mvo.setIsPublic(Integer.parseInt(multi.getParameter("isPublic"))); // 토글로 무조건 입력됨
					} catch (Exception ex) { ex.printStackTrace(); }
					
					mvo.setPhoto("/desktop/resources/imgs/memberImg/" + sysFileName); // 실제 저장 파일명. 나중에 쉽게 가져오기 위해 (contextPath 기반)전체 경로 입력
					mvo.setPhotoOri(oriFileName); // 사용자에게 보여질 오리지널 파일명
				} else {
					// 저장에 성공한 파일이 존재하지 않거나
					// 애초에 요청받은 파일 정보가 없는 경우 파일을 제외한 정보만 저장됨
					this.mvo = new MemberVo();
					
					// profile 이므로 nickName, interest, introduce, isPublic, photo 입력
					mvo.setNickName(multi.getParameter("nickName"));
					mvo.setInterest(multi.getParameter("interest"));
					mvo.setIntroduce(multi.getParameter("introduce"));
					try {
						mvo.setIsPublic(Integer.parseInt(multi.getParameter("isPublic"))); // 토글로 무조건 입력됨
					} catch (Exception ex) { ex.printStackTrace(); }
					
					mvo.setPhoto("");
					mvo.setPhotoOri("");
				}
			} else if (multi.getParameter("photo") == null || multi.getParameter("photo").equals("")) {
				this.mvo = new MemberVo();
				
				// profile 이므로 nickName, interest, introduce, isPublic, photo 입력
				mvo.setNickName(multi.getParameter("nickName"));
				mvo.setInterest(multi.getParameter("interest"));
				mvo.setIntroduce(multi.getParameter("introduce"));
				try {
					mvo.setIsPublic(Integer.parseInt(multi.getParameter("isPublic"))); // 토글로 무조건 입력됨
				} catch (Exception ex) { ex.printStackTrace(); }
				
				mvo.setPhoto("");
				mvo.setPhotoOri("");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return this.mvo;
	}
	
	// 프로파일 수정을 위한 객체생성
	// 정보는 > nickName, interest, introduce, isPublic (DMEMBER_PROFILE), 그리고 경우에 따라 photo (DMEMBER)
	public BookVo getBookVo (HttpServletRequest request) {		
		// 프로젝트의 실제 절대경로가 존재한다면 그것으로 세팅
		File file = new File(request.getSession().getServletContext().getRealPath("/"));
		if (file.isDirectory()) {
			// 저장 디렉토리 절대경로 설정
			saveDir = request.getSession().getServletContext().getRealPath("/resources/imgs/memberImg/");
			saveDirBookInfo = request.getSession().getServletContext().getRealPath("/resources/imgs/bookAttFiles/");
			System.out.println("[File Upload] 절대경로 지정 완료!");
		} else {
			System.out.println("[File Upload] 절대경로 지정 실패 : " + file.getPath());
		}
		
		try {
			// enctype='multipart/form-data' 방식으로 넘어온 요청정보를 다루기 위해 
			// 스프링 컨테이너에 포함된 MultipartHttpServletRequest 객체로 변환하여 사용한다
			// 이 클래스는 HttpServletRequest, MultipartRequest, ServletRequest 의 세 인터페이스를 구현한 자손 인터페이스이므로
			// 같은 계열 request 객체를 캐스팅해 활용 가능하다
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
			Iterator<String> ite = multi.getFileNames();
			if (ite.hasNext()) { // 어차피 업로드 파일은 한개이므로
				String tagName = ite.next();
				MultipartFile mFile = multi.getFile(tagName);
				
				// 전달받은 파일 확인
				System.out.println("file form name : " + mFile.getName());
				System.out.println("ori file name : " + mFile.getOriginalFilename());
				System.out.println("file size : " + mFile.getSize());
				System.out.println("is existing? : " + mFile.isEmpty());
				
				// 오리지널 파일명, 인코딩 처리
				oriFileName = new String(mFile.getOriginalFilename().getBytes("8859_1"), "utf-8");
				// 실제 저장 파일명은 오리지널 파일명으로 지정했다가, 추후 지정 경로에 동일 파일명이 존재하면 수정한다
				sysFileName = oriFileName;
				
				// 지정 경로에 파일 저장하기
				// 저장할 파일이 존재한다면 수행
				if (sysFileName != null && !sysFileName.equals("")) {
					// 지정 경로에 동일 파일명이 이미 존재한다면 실제 저장 파일명 변경 (시스템 시각을 더함)
					if (new File(saveDirBookInfo + sysFileName).exists()) {
						String preName = sysFileName.substring(0, sysFileName.lastIndexOf("."));
						String postName = sysFileName.substring(sysFileName.lastIndexOf("."), sysFileName.length());
						System.out.println("preName: " + preName + ", postName: " + postName);
						sysFileName = preName + "_" + System.currentTimeMillis() + postName; // 같은 파일명이 존재하므로 저장파일명 변경
					}
					
					// 컨테이너에 임시 파일로 저장되어 있으므로, 실제 지정 경로로 transfer 해야 한다
					// InputStream 사용해도 됨
					mFile.transferTo(new File(saveDirBookInfo + sysFileName)); // 최종 조립된 이름으로 지정 경로로 전송(저장)
					System.out.println("================================");
					System.out.println("[result] ori : " + oriFileName);
					System.out.println("[result] sys : " + sysFileName);
					
					// 파일 저장까지 완료했다면, 반환할 vo 객체를 생성한다
					// 여기에 ori, sys 파일을 구분해서 세팅한다
					this.bkvo = new BookVo();
					
					/* bkvo 세팅 */
					// bookNo, category, pDate 값이 없다면 제외, 추후 관리자 입력
					if (multi.getParameter("bookNo") != null && !multi.getParameter("bookNo").equals("")) {
						bkvo.setBookNo(multi.getParameter("bookNo"));
						bkvo.setIsPermitted(1);
					} else {
						bkvo.setBookNo("notPermitted:" + System.currentTimeMillis() / 1000);
						bkvo.setIsPermitted(0);
					}
					if (multi.getParameter("category") != null) {
						try {
							bkvo.setCategory(Integer.parseInt(multi.getParameter("category")));
						} catch (Exception ex) { ex.printStackTrace(); }
					} else {
						bkvo.setCategory(9999);
					}
					
					// title_kor, title_eng, introduce, author, publisher, country, coverImg, coverImgOri, isPermitted 입력
					if (multi.getParameter("title_kor") != null) {
						bkvo.setTitle_kor(multi.getParameter("title_kor"));
					} else {
						bkvo.setTitle_kor(multi.getParameter(""));
					}
					if (multi.getParameter("title_eng") != null) {
						bkvo.setTitle_eng(multi.getParameter("title_eng"));
					} else {
						bkvo.setTitle_eng(multi.getParameter(""));
					}
					if (multi.getParameter("introduce") != null) {
						bkvo.setIntroduce(multi.getParameter("introduce"));
					} else {
						bkvo.setIntroduce(multi.getParameter(""));
					}
					if (multi.getParameter("author") != null) {
						bkvo.setAuthor(multi.getParameter("author"));
					} else {
						bkvo.setAuthor(multi.getParameter(""));
					}
					if (multi.getParameter("publisher") != null) {
						bkvo.setPublisher(multi.getParameter("publisher"));
					} else {
						bkvo.setPublisher(multi.getParameter(""));
					}
					if (multi.getParameter("country") != null) {
						bkvo.setCountry(multi.getParameter("country"));
					} else {
						bkvo.setCountry(multi.getParameter(""));
					}
					bkvo.setCoverImg("/desktop/resources/imgs/bookAttFiles/" + sysFileName); // 실제 저장 파일명. 나중에 쉽게 가져오기 위해 (contextPath 기반)전체 경로 입력
					bkvo.setCoverImgOri(oriFileName); // 사용자에게 보여질 오리지널 파일명

					// 임시
					if (multi.getParameter("oriBookNo") != null && !multi.getParameter("oriBookNo").equals("")) {
						bkvo.setOriBookNo(multi.getParameter("oriBookNo"));
					}
				} else {
					// 저장에 성공한 파일이 존재하지 않거나
					// 애초에 요청받은 파일 정보가 없는 경우 파일을 제외한 정보만 저장됨
					this.bkvo = new BookVo();
					
					/* bkvo 세팅 */
					// bookNo, category, pDate 값이 없다면 제외, 추후 관리자 입력
					if (multi.getParameter("bookNo") != null && !multi.getParameter("bookNo").equals("")) {
						bkvo.setBookNo(multi.getParameter("bookNo"));
						bkvo.setIsPermitted(1);
					} else {
						bkvo.setBookNo("notPermitted:" + System.currentTimeMillis() / 1000);
						bkvo.setIsPermitted(0);
					}
					if (multi.getParameter("category") != null) {
						try {
							bkvo.setCategory(Integer.parseInt(multi.getParameter("category")));
						} catch (Exception ex) { ex.printStackTrace(); }
					} else {
						bkvo.setCategory(9999);
					}
					
					// title_kor, title_eng, introduce, author, publisher, country, coverImg, coverImgOri, isPermitted 입력
					if (multi.getParameter("title_kor") != null) {
						bkvo.setTitle_kor(multi.getParameter("title_kor"));
					} else {
						bkvo.setTitle_kor(multi.getParameter(""));
					}
					if (multi.getParameter("title_eng") != null) {
						bkvo.setTitle_eng(multi.getParameter("title_eng"));
					} else {
						bkvo.setTitle_eng(multi.getParameter(""));
					}
					if (multi.getParameter("introduce") != null) {
						bkvo.setIntroduce(multi.getParameter("introduce"));
					} else {
						bkvo.setIntroduce(multi.getParameter(""));
					}
					if (multi.getParameter("author") != null) {
						bkvo.setAuthor(multi.getParameter("author"));
					} else {
						bkvo.setAuthor(multi.getParameter(""));
					}
					if (multi.getParameter("publisher") != null) {
						bkvo.setPublisher(multi.getParameter("publisher"));
					} else {
						bkvo.setPublisher(multi.getParameter(""));
					}
					if (multi.getParameter("country") != null) {
						bkvo.setCountry(multi.getParameter("country"));
					} else {
						bkvo.setCountry(multi.getParameter(""));
					}
					bkvo.setCoverImg(""); // 실제 저장 파일명. 나중에 쉽게 가져오기 위해 (contextPath 기반)전체 경로 입력
					bkvo.setCoverImgOri(""); // 사용자에게 보여질 오리지널 파일명

					// 임시
					if (multi.getParameter("oriBookNo") != null && !multi.getParameter("oriBookNo").equals("")) {
						bkvo.setOriBookNo(multi.getParameter("oriBookNo"));
					}
				}
			} else if (multi.getParameter("coverImg") == null || multi.getParameter("coverImg").equals("")) {
				this.bkvo = new BookVo();
				
				/* bkvo 세팅 */
				// bookNo, category, pDate 값이 없다면 제외, 추후 관리자 입력
				if (multi.getParameter("bookNo") != null && !multi.getParameter("bookNo").equals("")) {
					bkvo.setBookNo(multi.getParameter("bookNo"));
					bkvo.setIsPermitted(1);
				} else {
					bkvo.setBookNo("notPermitted:" + System.currentTimeMillis() / 1000);
					bkvo.setIsPermitted(0);
				}
				if (multi.getParameter("category") != null) {
					try {
						bkvo.setCategory(Integer.parseInt(multi.getParameter("category")));
					} catch (Exception ex) { ex.printStackTrace(); }
				} else {
					bkvo.setCategory(9999);
				}
				
				// title_kor, title_eng, introduce, author, publisher, country, coverImg, coverImgOri, isPermitted 입력
				if (multi.getParameter("title_kor") != null) {
					bkvo.setTitle_kor(multi.getParameter("title_kor"));
				} else {
					bkvo.setTitle_kor(multi.getParameter(""));
				}
				if (multi.getParameter("title_eng") != null) {
					bkvo.setTitle_eng(multi.getParameter("title_eng"));
				} else {
					bkvo.setTitle_eng(multi.getParameter(""));
				}
				if (multi.getParameter("introduce") != null) {
					bkvo.setIntroduce(multi.getParameter("introduce"));
				} else {
					bkvo.setIntroduce(multi.getParameter(""));
				}
				if (multi.getParameter("author") != null) {
					bkvo.setAuthor(multi.getParameter("author"));
				} else {
					bkvo.setAuthor(multi.getParameter(""));
				}
				if (multi.getParameter("publisher") != null) {
					bkvo.setPublisher(multi.getParameter("publisher"));
				} else {
					bkvo.setPublisher(multi.getParameter(""));
				}
				if (multi.getParameter("country") != null) {
					bkvo.setCountry(multi.getParameter("country"));
				} else {
					bkvo.setCountry(multi.getParameter(""));
				}
				bkvo.setCoverImg(""); // 실제 저장 파일명. 나중에 쉽게 가져오기 위해 (contextPath 기반)전체 경로 입력
				bkvo.setCoverImgOri(""); // 사용자에게 보여질 오리지널 파일명
				
				// 임시
				if (multi.getParameter("oriBookNo") != null && !multi.getParameter("oriBookNo").equals("")) {
					bkvo.setOriBookNo(multi.getParameter("oriBookNo"));
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return this.bkvo;
	}
}