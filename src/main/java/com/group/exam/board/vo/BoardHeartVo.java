package com.group.exam.board.vo;

public class BoardHeartVo {
	
	private int heartSeq;
	private int boardSeq;
	private int memberSeq;
	
	public int getHeartSeq() {
		return heartSeq;
	}
	public void setHeartSeq(int heartSeq) {
		this.heartSeq = heartSeq;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public int getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}
	@Override
	public String toString() {
		return "BoardHeartVo [heartSeq=" + heartSeq + ", boardSeq=" + boardSeq + ", memberSeq=" + memberSeq + "]";
	}
	
	
	
	
	
	

}
