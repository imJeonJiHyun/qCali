package com.group.exam.board.command;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;


public class BoardupdateCommand {
	
	private int boardSeq;
	private int memberSeq;
	@Length(min=2, max=30, message="2자 이상, 30자 미만으로 입력해주세요.")
	@NotBlank(message="제목을 입력해 주세요")
	private String boardTitle;
	@NotEmpty(message="내용을 입력해 주세요")
	private String boardContent;
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
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	


	
}
