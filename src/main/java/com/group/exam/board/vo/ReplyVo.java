package com.group.exam.board.vo;

public class ReplyVo {
	private int replySeq;
	private int boardReplySeq;
	private int memberReplySeq;
	private String replyContent;
	private String memberNickname;
	private String replyRegDay; //변수명을 p키들과 맞춰야하나?
	
	public int getReplySeq() {
		return replySeq;
	}
	public void setReplySeq(int replySeq) {
		this.replySeq = replySeq;
	}
	public int getBoardReplySeq() {
		return boardReplySeq;
	}
	public void setBoardReplySeq(int boardReplySeq) {
		this.boardReplySeq = boardReplySeq;
	}
	public int getMemberReplySeq() {
		return memberReplySeq;
	}
	public void setMemberReplySeq(int memberReplySeq) {
		this.memberReplySeq = memberReplySeq;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getReplyRegDay() {
		return replyRegDay;
	}
	public void setReplyRegDay(String replyRegDay) {
		this.replyRegDay = replyRegDay;
	}
}
