package com.group.exam.member.command;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class MemberFindPwdCommand {
	@Email(message = "이메일 형식이 아닙니다.")
	@NotEmpty(message = "이메일을 입력하세요.")
	private String memberId;

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}



}
