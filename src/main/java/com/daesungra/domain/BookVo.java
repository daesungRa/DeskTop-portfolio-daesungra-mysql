package com.daesungra.domain;

public class BookVo {

	private String oriBookNo; // 임시
	private String bookNo; // 관리자 입력
	private String title_kor;
	private String title_eng;
	private String introduce;
	private String author;
	private int category; // 관리자 입력
	private String publisher;
	private String country;
	private String coverImg;
	private String coverImgOri;
	private String pDate; // 자동 입력
	private int isPermitted; // 승인 전까지 0
	private int isDelete;
	private String userId;
	
	public String getBookNo() {
		return bookNo;
	}
	public void setBookNo(String bookNo) {
		this.bookNo = bookNo;
	}
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
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
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
	public String getCoverImgOri() {
		return coverImgOri;
	}
	public void setCoverImgOri(String coverImgOri) {
		this.coverImgOri = coverImgOri;
	}
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
	public int getIsPermitted() {
		return isPermitted;
	}
	public void setIsPermitted(int isPermitted) {
		this.isPermitted = isPermitted;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	

	@Override
	public String toString() {
		return "BookVo [bookNo=" + bookNo + ", title_kor=" + title_kor + ", title_eng=" + title_eng + ", introduce="
				+ introduce + ", author=" + author + ", category=" + category + ", publisher=" + publisher
				+ ", country=" + country + ", coverImg=" + coverImg + ", coverImgOri=" + coverImgOri + ", pDate="
				+ pDate + ", isPermitted=" + isPermitted + ", isDelete=" + isDelete + ", userId=" + userId + "]";
	}
	
	public String toJson() {
		/*String jsonResult = String.format("{\"bookNo\":\"%s\", "
											+ "'title_kor':\"%s\", "
											+ "'title_eng':\"%s\", "
											+ "'introduce':\"%s\", "
											+ "'author':\"%s\", "
											+ "'category':\"%d\", "
											+ "'publisher':\"%s\", "
											+ "'country':\"%s\", "
											+ "'coverImg':\"%s\", "
											+ "'pDate':\"%s\", "
											+ "\"isPermitted\":\"%d\"}", bookNo, title_kor, title_eng, introduce, author, category, publisher, country, coverImg, pDate, isPermitted);*/
		
		String jsonResult = String.format("{\"title_kor\":\"%s\", "
											+ "\"bookNo\":\"%s\", "
											+ "\"title_eng\":\"%s\", "
											+ "\"category\":\"%d\", "
											+ "\"coverImg\":\"%s\", "
											+ "\"pDate\":\"%s\"}", title_kor, bookNo, title_eng, category, coverImg, pDate);
		return jsonResult;
		
		/*"{'bookNo':'" + bookNo + "', 'title_kor':'" + title_kor + "', 'title_eng':'" + title_eng + "', 'introduce':'"
		+ introduce + "', 'author':'" + author + "', 'category':'" + category + "', 'publisher':'" + publisher
		+ "', 'country':'" + country + "', 'coverImg':'" + coverImg + "', 'pDate':'" + pDate + "', 'isPermitted':'"
		+ isPermitted + "'}"*/
	}
	
	// 임시
	public String getOriBookNo() {
		return oriBookNo;
	}
	public void setOriBookNo(String oriBookNo) {
		this.oriBookNo = oriBookNo;
	}
	
}
