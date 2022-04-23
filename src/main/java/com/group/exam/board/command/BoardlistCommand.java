package com.group.exam.board.command;

public class BoardlistCommand {
	
	private int boardSeq;
	private String boardTitle;
	private String boardRegday;
	private int boardLike;
	private int boardCount;
	private String memberNickname;
	private String boardContent;
	private int memberSeq;
	
	
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardRegday() {
		return boardRegday;
	}
	public void setBoardRegday(String boardRegday) {
		this.boardRegday = boardRegday;
	}
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public int getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}
	@Override
	public String toString() {
		return "BoardlistCommand [boardSeq=" + boardSeq + ", boardTitle=" + boardTitle + ", boardRegday=" + boardRegday
				+ ", boardLike=" + boardLike + ", boardCount=" + boardCount + ", memberNickname=" + memberNickname
				+ ", boardContent=" + boardContent + ", memberSeq=" + memberSeq + "]";
	}
		
	
	
	

}
