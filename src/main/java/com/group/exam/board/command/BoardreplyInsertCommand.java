package com.group.exam.board.command;

public class BoardreplyInsertCommand {
	private int replySeq;
	private int boardReplySeq;
	private String replyContent;
	private int memberReplySeq;
	
	public int getReplySeq() {
		return replySeq;
	}
	public void setReplySeq(int replySeq) {
		this.boardReplySeq = replySeq;
	}
	public int getBoardReplySeq() {
		return boardReplySeq;
	}
	public void setBoardReplySeq(int boardReplySeq) {
		this.boardReplySeq = boardReplySeq;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public int getMemberReplySeq() {
		return memberReplySeq;
	}
	public void setMemberReplySeq(int memberReplySeq) {
		this.memberReplySeq = memberReplySeq;
	}
	@Override
	public String toString() {
		return "BoardreplyInsertCommand [boardReplySeq=" + boardReplySeq + ", replyContent=" + replyContent
				+ ", memberReplySeq=" + memberReplySeq + "]";
	}
}
