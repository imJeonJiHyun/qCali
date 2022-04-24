package com.group.exam.board.command;

public class BoardreplyInsertCommand {
	private int boardReplySeq;
	private String replyContent;
	
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
}
