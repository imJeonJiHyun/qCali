package com.group.exam.member.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.command.MemberFindPwdCommand;
import com.group.exam.member.service.MailSendService;
import com.group.exam.member.service.MemberService;

@Controller
public class MemberPwdFindController {

	private BCryptPasswordEncoder passwordEncoder;

	private MailSendService mss;

	private MemberService memberService;

	@Autowired
	public MemberPwdFindController( MailSendService mss, BCryptPasswordEncoder passwordEncoder,
			MemberService memberService) {

		this.passwordEncoder = passwordEncoder;
		this.mss = mss;
		this.memberService = memberService;
	}

	@RequestMapping(value = "/member/findPwd", method = RequestMethod.GET)
	public String findPwd(@ModelAttribute("findPwdData") MemberFindPwdCommand findcommand) {

		return "member/findPwdForm";
	}

	@RequestMapping(value = "/member/findPwd", method = RequestMethod.POST)
	public String findPwd(@Valid @ModelAttribute("findPwdData") MemberFindPwdCommand findcommand,
			BindingResult bindingResult, Model model) {

		if (bindingResult.hasErrors()) {
			return "member/findPwdForm";
		}

		LoginCommand findMember = memberService.findPwd(findcommand.getMemberId());

		if (findMember != null) {
			String tmpPwd = mss.sendPwdMail(findcommand.getMemberId()); // 임시 비밀번호 메일 발송
			String encodePwd = passwordEncoder.encode(tmpPwd); // 임시 비밀번호 암호화

			int result = memberService.updateTmpPwd(encodePwd, findcommand.getMemberId()); // db에 해당 회원 비밀번호 임시 비밀번호로 변경

			if (result == 1) {
				// 임시 비밀번호로 변경 성공
				return "member/member_alert/findPwdNext";
			}

		}
		
		model.addAttribute("msg", "해당 회원 정보가 없습니다.");
		return "member/findPwdForm";
	}

}
