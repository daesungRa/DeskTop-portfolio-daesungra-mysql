package com.daesungra.domain;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PageDto {
	
	@Autowired
	private SqlSession sqlSession;
	
	private Map<String, Object> inputData = new HashMap<>(); // db select 파라미터
	private int category = 1;
	private String search = "";
	private int searchByContent = 1; // 1: 제목 + 내용, 2: 제목만, 3: 내용만, 4: 작가별
	private int fSerial; // 댓글 처리를 위한 참조 게시판 시리얼
	private int dateFlag = 3; // admin 처리를 위한 조회 일자 플래그 (1: 오늘, 2: 하루 전, 3: 일주일 전, 4: 한달 전)

	private int listSize = 10;
	private int blockSize = 5;
	private int nowPage = 1;
	
	private int totSize;
	private int totPage;
	private int totBlock;
	private int nowBlock;
	
	private int startNo;
	private int endNo;
	private int startPage;
	private int endPage;
	
	// 게시판 페이지네이션
	public void setBoardPageDto (int listSize, int blockSize, int nowPage, int category) {
		this.listSize = listSize;
		this.blockSize = blockSize;
		this.nowPage = nowPage;
		this.category = category;
	}
	
	// 게시판 페이지네이션 (검색)
	public void setPageDtoSearch (int listSize, int blockSize, int nowPage, int category, String search, int searchByContent) {
		this.listSize = listSize;
		this.blockSize = blockSize;
		this.nowPage = nowPage;
		this.category = category;
		this.search = search;
		this.searchByContent = searchByContent;
	}

	// 댓글 페이지네이션
	public void setCommentPageDto (int listSize, int blockSize, int nowPage, int fSerial) {
		this.listSize = listSize;
		this.blockSize = blockSize;
		this.nowPage = nowPage;
		this.fSerial = fSerial;
	}
	
	// admin 페이지네이션
	public void setAdminPageDto (int listSize, int blockSize, int nowPage, int dateFlag) {
		this.listSize = listSize;
		this.blockSize = blockSize;
		this.nowPage = nowPage;
		this.dateFlag = dateFlag;
	}
	
	// 게시판 페이지네이션 실행
	public void boardPageCompute () {
		// 쿼리에 입력할 hashMap 세팅
		this.inputData.put("search", this.search); // 검색어
		this.inputData.put("category", this.category); // 카테고리
		this.inputData.put("searchByContent", searchByContent); // 검색 필터 (정렬은 필요없음. 어차피 갯수 totSize 만 반환되기 때문)
		
		// 입력된 카테고리 기반으로 totSize 구한 뒤 나머지 요소 구하기
		this.totSize = sqlSession.selectOne("board.boardListPagenation", this.inputData);
		this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
		this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
		this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
		this.endNo = this.nowPage * this.listSize;
		this.startNo = this.endNo - this.listSize;
		if (this.endNo > this.totSize) this.endNo = this.totSize;
		this.endPage = this.nowBlock * this.blockSize;
		this.startPage = this.endPage - this.blockSize + 1;
		if (this.endPage > this.totPage) this.endPage = this.totPage;
		System.out.println("[boardPageCompute 완료]====================");
		
		System.out.println("listSize: " + listSize);
		System.out.println("blockSize: " + blockSize);
		System.out.println("nowPage: " + nowPage);
		System.out.println("totSize: " + totSize);
		System.out.println("totPage: " + totPage);
		System.out.println("totBlock: " + totBlock);
		System.out.println("nowBlock: " + nowBlock);
		System.out.println("endNo: " + endNo);
		if (this.startNo > 0) {
			System.out.println("startNo: " + (startNo - 1));
		} else {
			System.out.println("startNo: " + startNo);
		}
		System.out.println("endPage: " + endPage);
		System.out.println("startPage: " + startPage);
		System.out.println("========================================");
	}
	
	// 댓글 페이지네이션 실행
	public void commentPageCompute () {
		// 쿼리에 입력할 hashMap 세팅
		this.inputData.put("fSerial", this.fSerial);
		
		// 입력된 카테고리 기반으로 totSize 구한 뒤 나머지 요소 구하기
		this.totSize = sqlSession.selectOne("comment.commentListPagenation", this.inputData);
		this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
		this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
		this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
		this.endNo = this.nowPage * this.listSize;
		this.startNo = this.endNo - this.listSize;
		if (this.endNo > this.totSize) this.endNo = this.totSize;
		this.endPage = this.nowBlock * this.blockSize;
		this.startPage = this.endPage - this.blockSize + 1;
		if (this.endPage > this.totPage) this.endPage = this.totPage;
		System.out.println("[commentPageCompute 완료]====================");
		
		System.out.println("listSize: " + listSize);
		System.out.println("blockSize: " + blockSize);
		System.out.println("nowPage: " + nowPage);
		System.out.println("totSize: " + totSize);
		System.out.println("totPage: " + totPage);
		System.out.println("totBlock: " + totBlock);
		System.out.println("nowBlock: " + nowBlock);
		System.out.println("endNo: " + endNo);
		if (this.startNo > 0) {
			System.out.println("startNo: " + (startNo - 1));
		} else {
			System.out.println("startNo: " + startNo);
		}
		System.out.println("endPage: " + endPage);
		System.out.println("startPage: " + startPage);
		System.out.println("========================================");
	}
	
	// admin board report 페이지네이션 실행
	public void adminBoardReportPageCompute () {
		// 입력된 dateFlag 기반으로 totSize 구한 뒤 나머지 요소 구하기
		this.totSize = sqlSession.selectOne("admin.boardReportListPagenation", dateFlag);
		this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
		this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
		this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
		this.endNo = this.nowPage * this.listSize;
		this.startNo = this.endNo - this.listSize;
		if (this.endNo > this.totSize) this.endNo = this.totSize;
		this.endPage = this.nowBlock * this.blockSize;
		this.startPage = this.endPage - this.blockSize + 1;
		if (this.endPage > this.totPage) this.endPage = this.totPage;
		System.out.println("[adminBoardReportPageCompute 완료]====================");
		
		System.out.println("listSize: " + listSize);
		System.out.println("blockSize: " + blockSize);
		System.out.println("nowPage: " + nowPage);
		System.out.println("totSize: " + totSize);
		System.out.println("totPage: " + totPage);
		System.out.println("totBlock: " + totBlock);
		System.out.println("nowBlock: " + nowBlock);
		System.out.println("endNo: " + endNo);
		if (this.startNo > 0) {
			System.out.println("startNo: " + (startNo - 1));
		} else {
			System.out.println("startNo: " + startNo);
		}
		System.out.println("endPage: " + endPage);
		System.out.println("startPage: " + startPage);
		System.out.println("========================================");
	}
	
	// admin book register 페이지네이션 실행
	public void adminBookRegisterPageCompute () {
		// 입력된 dateFlag 기반으로 totSize 구한 뒤 나머지 요소 구하기
		this.totSize = sqlSession.selectOne("admin.bookRegisterPagenation", dateFlag);
		
		this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
		this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
		this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
		this.endNo = this.nowPage * this.listSize;
		this.startNo = this.endNo - this.listSize;
		if (this.endNo > this.totSize) this.endNo = this.totSize;
		this.endPage = this.nowBlock * this.blockSize;
		this.startPage = this.endPage - this.blockSize + 1;
		if (this.endPage > this.totPage) this.endPage = this.totPage;
		System.out.println("[adminBookRegisterPageCompute 완료]====================");
		
		System.out.println("listSize: " + listSize);
		System.out.println("blockSize: " + blockSize);
		System.out.println("nowPage: " + nowPage);
		System.out.println("totSize: " + totSize);
		System.out.println("totPage: " + totPage);
		System.out.println("totBlock: " + totBlock);
		System.out.println("nowBlock: " + nowBlock);
		System.out.println("endNo: " + endNo);
		if (this.startNo > 0) {
			System.out.println("startNo: " + (startNo - 1));
		} else {
			System.out.println("startNo: " + startNo);
		}
		System.out.println("endPage: " + endPage);
		System.out.println("startPage: " + startPage);
		System.out.println("========================================");
	}
	
	// admin new board 페이지네이션 실행
	public void adminNewBoardPageCompute () {
		// 입력된 dateFlag 기반으로 totSize 구한 뒤 나머지 요소 구하기
		this.totSize = sqlSession.selectOne("admin.newBoardPagenation", dateFlag);
		
		this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
		this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
		this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
		this.endNo = this.nowPage * this.listSize;
		this.startNo = this.endNo - this.listSize;
		if (this.endNo > this.totSize) this.endNo = this.totSize;
		this.endPage = this.nowBlock * this.blockSize;
		this.startPage = this.endPage - this.blockSize + 1;
		if (this.endPage > this.totPage) this.endPage = this.totPage;
		System.out.println("[adminBookRegisterPageCompute 완료]====================");
		
		System.out.println("listSize: " + listSize);
		System.out.println("blockSize: " + blockSize);
		System.out.println("nowPage: " + nowPage);
		System.out.println("totSize: " + totSize);
		System.out.println("totPage: " + totPage);
		System.out.println("totBlock: " + totBlock);
		System.out.println("nowBlock: " + nowBlock);
		System.out.println("endNo: " + endNo);
		if (this.startNo > 0) {
			System.out.println("startNo: " + (startNo - 1));
		} else {
			System.out.println("startNo: " + startNo);
		}
		System.out.println("endPage: " + endPage);
		System.out.println("startPage: " + startPage);
		System.out.println("========================================");
	}

	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getTotSize() {
		return totSize;
	}
	public void setTotSize(int totSize) {
		this.totSize = totSize;
	}
	public int getTotPage() {
		return totPage;
	}
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
	public int getTotBlock() {
		return totBlock;
	}
	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}
	public int getNowBlock() {
		return nowBlock;
	}
	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	// 댓글
	public int getfSerial() {
		return fSerial;
	}

	// admin dateFlag
	public int getDateFlag() {
		return dateFlag;
	}
	
}