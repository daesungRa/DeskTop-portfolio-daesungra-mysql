package com.daesungra.domain;

public class BoardVo {

	private int serial;
	private String userId;
	private String bookNo;
	private int category;
	private String title;
	private String content;
	private int gSerial;
	private int pSerial;
	private int depth;
	private int indent;
	private String bDate;
	private int hit;
	private int isDelete;
	private int isBlocked;
	
	// DBOOK
	private String title_kor;
	private String title_eng;
	private String introduce;
	private String author;
	private String publisher;
	private String country;
	private String coverImg;
	private String pDate;
	
	// commentCnt
	private int commentCnt;
	
	// thumbUpCnt
	private int thumbUpCnt;
	
	// isThumbUp
	private int isThumbUp;
	
	// DBOARD
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBookNo() {
		return bookNo;
	}
	public void setBookNo(String bookNo) {
		this.bookNo = bookNo;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
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
	
	// DBOOK
	public String getTitle_kor() {
		return title_kor;
	}
	public void setTitle_kor(String title_kor) {
		this.title_kor = title_kor;
	}
	public String getTitle_eng() {
		return title_eng;
	}
	public void setTitle_eng(String title_eng) {
		this.title_eng = title_eng;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCoverImg() {
		return coverImg;
	}
	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
	
	// commentCnt
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	// thumbUpCnt
	public int getThumbUpCnt() {
		return thumbUpCnt;
	}
	public void setThumbUpCnt(int thumbUpCnt) {
		this.thumbUpCnt = thumbUpCnt;
	}
	
	// isThumbUp
	public int getIsThumbUp() {
		return isThumbUp;
	}
	public void setIsThumbUp(int isThumbUp) {
		this.isThumbUp = isThumbUp;
	}	
	
}
