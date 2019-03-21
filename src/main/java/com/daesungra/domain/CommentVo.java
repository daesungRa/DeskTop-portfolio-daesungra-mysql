package com.daesungra.domain;

public class CommentVo {

	private int serial;
	private int fSerial;
	private int delFSerial;
	private String userId;
	private String delUserId;
	private int isDelete;
	private String content;
	private int gSerial;
	private int pSerial;
	private int depth;
	private int indent;
	private String cDate;
	
	// member profile img
	private String photo;
	
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public int getfSerial() {
		return fSerial;
	}
	public void setfSerial(int fSerial) {
		this.fSerial = fSerial;
	}
	public int getDelFSerial() {
		return delFSerial;
	}
	public void setDelFSerial(int delFSerial) {
		this.delFSerial = delFSerial;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDelUserId() {
		return delUserId;
	}
	public void setDelUserId(String delUserId) {
		this.delUserId = delUserId;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getgSerial() {
		return gSerial;
	}
	public void setgSerial(int gSerial) {
		this.gSerial = gSerial;
	}
	public int getpSerial() {
		return pSerial;
	}
	public void setpSerial(int pSerial) {
		this.pSerial = pSerial;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	
	// member
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}
