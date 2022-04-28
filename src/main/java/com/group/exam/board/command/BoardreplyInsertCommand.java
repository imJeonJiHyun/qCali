package com.group.exam.board.command;

public class BoardreplyInsertCommand {
	private int boardReplySeq;
	private String replyContent;
	private int memberSeq;
	
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
	public int getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}
	@Override
	public String toString() {
		return "BoardreplyInsertCommand [boardReplySeq=" + boardReplySeq + ", replyContent=" + replyContent
				+ ", memberSeq=" + memberSeq + "]";
	}
}
