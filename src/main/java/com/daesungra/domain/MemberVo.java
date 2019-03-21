package com.daesungra.domain;

import java.util.List;

public class MemberVo {
	
	// 관리자 정보
	private int authority;

	// 기본 회원 정보
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String phone;
	private String postal;
	private String address;
	private String addressAdd;
	private String photo;
	private String photoOri;
	private String mDate;
	private int isDelete; // 디폴트 0, 삭제되지 않음
	private int isBlocked;
	
	// 프로필 정보
	private String nickName;
	private String introduce;
	private String interest;
	private int isPublic; // 디폴트 0, 공개되지 않음
	
	// 팔로우
	private int fNum;
	private List<String> followees; // 별도 쿼리로 팔로워 vo 객체를 만들어 리스트로 가져올 것
	private int isFollow; // 회원 조회 시 해당 회원을 팔로우하고 있는지?
	
	// 게시글 정보
	private int boardCnt;
	private int commentCnt;
	private int thumbUpCnt;
	
	// admin
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
	
	// info
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPostal() {
		return postal;
	}
	public void setPostal(String postal) {
		this.postal = postal;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressAdd() {
		return addressAdd;
	}
	public void setAddressAdd(String addressAdd) {
		this.addressAdd = addressAdd;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getPhotoOri() {
		return photoOri;
	}
	public void setPhotoOri(String photoOri) {
		this.photoOri = photoOri;
	}
	public String getmDate() {
		return mDate;
	}
	public void setmDate(String mDate) {
		this.mDate = mDate;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public int getIsBlocked() {
		return isBlocked;
	}
	public void setIsBlocked(int isBlocked) {
		this.isBlocked = isBlocked;
	}
	
	// profile
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public int getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(int isPublic) {
		this.isPublic = isPublic;
	}
	
	// follow
	public int getfNum() {
		return fNum;
	}
	public void setfNum(int fNum) {
		this.fNum = fNum;
	}
	public List<String> getFollowees() {
		return followees;
	}
	public void setFollowees(List<String> followees) {
		this.followees = followees;
	}
	public int getIsFollow() {
		return isFollow;
	}
	public void setIsFollow(int isFollow) {
		this.isFollow = isFollow;
	}
	
	// my board
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public int getThumbUpCnt() {
		return thumbUpCnt;
	}
	public void setThumbUpCnt(int thumbUpCnt) {
		this.thumbUpCnt = thumbUpCnt;
	}
	
	// info json > 수정요망
	public String toJsonInfo() {
		return "{\"userId\":\"" + userId + "\", \"userPwd\":\"" + userPwd + "\", \"userName\":\"" + userName + "\", \"email\":\"" + email
				+ "\", \"postal\":\"" + postal + "\", \"address\":\"" + address + "\", \"photo\":\"" + photo + "\", \"photoOri\":\"" + photoOri
				+ "\", \"mDate\":\"" + mDate + "\", \"addressAdd:\":\"" + addressAdd + "\"}";
	}
	
	// profile json
	public String toJsonProfile() {
		return "{\"userId\":\"" + userId + "\", \"userName\":\"" + userName + "\", \"photo\":\"" + photo + "\", \"photoOri\":\"" + photoOri
					+ "\", \"introduce:\":\"" + introduce + "\", \"interest:\":\"" + interest + "\", \"isPublic\":\"" + isPublic + "\"}";
	}
	
}
