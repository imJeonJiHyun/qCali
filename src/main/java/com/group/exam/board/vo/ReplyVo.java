package com.group.exam.board.vo;

public class ReplyVo {
	private int replySeq; //댓글 번호
	private int boardReplySeq; //게시물 번호
	private int memberReplySeq; //댓글 작성자 번호
	private String replyContent; //댓글 내용
	private String memberNickname; //댓글 작성자
	private String replyRegDay; //댓글 작성 날짜
	
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
	@Override
	public String toString() {
		return "ReplyVo [replySeq=" + replySeq + ", boardReplySeq=" + boardReplySeq + ", memberReplySeq="
				+ memberReplySeq + ", replyContent=" + replyContent + ", memberNickname=" + memberNickname
				+ ", replyRegDay=" + replyRegDay + "]";
	}
}
