package com.group.exam.member.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.command.MemberchangePwd;
import com.group.exam.member.service.MemberService;

@Controller
@RequestMapping(value = "/member/mypage")
public class MemberMypageController {

	private MemberService memberService;

	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public MemberMypageController(MemberService memberService, BCryptPasswordEncoder passwordEncoder) {

		this.memberService = memberService;
		this.passwordEncoder = passwordEncoder;
	}

	@GetMapping(value = "/confirmPwd")
	public String confirmPwd(String memberPassword, HttpSession session) {

		return "/member/mypagePwd";
	}

	// 마이페이지 가기 전에 비밀번호 체크
	@PostMapping(value = "/confirmPwd")
	public String confirmPwd(@RequestParam String memberPassword, Model model, HttpSession session) {
		
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		String encodePassword = command.getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(memberPassword, encodePassword);

		if (pwdEncode) {
			return "/member/mypage";
		}
		model.addAttribute("msg", "비밀번호가 다릅니다.");

		return "/member/mypagePwd";
	}

	// 비밀번호 변경
	@GetMapping(value = "changePwd")
	public String changePwd(@ModelAttribute("changepwdData") MemberchangePwd changepwdData, HttpSession session) {
		return "/member/changePwdForm";
	}

	@PostMapping(value = "changePwd")
	public String changePwd(@Valid @ModelAttribute("changepwdData") MemberchangePwd changepwdData, BindingResult bindingResult, HttpSession session,
			 Model model) {

		if (bindingResult.hasErrors()) {
			return "/member/changePwdForm";
		}
		
		// 비밀번호-비밀번호 확인 check
		boolean pwdcheck = changepwdData.getMemberPassword().equals(changepwdData.getMemberPasswordCheck());
		if (pwdcheck != true) {
			return "/member/changePwdForm";
		}

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		// 임시 비밀번호와 같은지 체크
		String encodePassword = command.getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(changepwdData.getMemberPassword(), encodePassword);

		if (pwdEncode) {

			model.addAttribute("msg", "기존 비밀번호와 동일합니다.");
			return "/member/changePwdForm";
		}

		// 기존 비밀번호와 같은지 체크
		encodePassword = command.getMemberBpw();
		pwdEncode = passwordEncoder.matches(changepwdData.getMemberPassword(), encodePassword);

		if (pwdEncode) {
			model.addAttribute("msg", "기존 비밀번호와 동일합니다.");
			return "/member/changePwdForm";
		}

		String updateEncodePassword = passwordEncoder.encode(changepwdData.getMemberPassword());

		int result = memberService.updateMemberPwd(updateEncodePassword, command.getMemberSeq());

		if (result != 1) {
			System.out.println("비밀번호 변경 실패");
			return "/errors/mypageChangeError";
		}

		// 세션 로그인 정보
		LoginCommand login = memberService.login(command.getMemberId());

		session.setAttribute("memberLogin", login);

		return "/member/member_alert/changeNext";
	}
	
	
	//닉네임 변경
	@GetMapping(value = "/changeNickname")
	public String changeNickname(HttpSession session) {
		
		return "/member/changeNicknameForm";
	}

	
	@PostMapping(value = "/changeNickname")
	public String changeNickname(@RequestParam(required = false) String memberNickname, HttpSession session,Model model) {
		
		if (memberNickname == null) {
			model.addAttribute("msg", "변경 할 닉네임을 입력해 주세요.");
			return "/member/changeNicknameForm";
		}
		
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		
		int result = memberService.updateMemberNickname(memberNickname, command.getMemberSeq());
		
		if (result != 1) {
			System.out.println("닉네임 변경 실패");
			return "errors/mypageChangeError";//에러 페이지 
		}
		
		// 세션 로그인 정보
		LoginCommand login = memberService.login(command.getMemberId());

		session.setAttribute("memberLogin", login);
		return "/member/member_alert/changeNext";
	}
	
	
	// 회원 탈퇴	
	@GetMapping(value = "/delete")
	public String deleteMember(HttpSession session) {

		return "/member/deleteForm";

	}


	@PostMapping(value = "/delete")
	public String deleteMember(@RequestParam String memberPassword, Model model, HttpSession session) {

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		String encodePassword = command.getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(memberPassword, encodePassword);

		if (pwdEncode) {

			int result = memberService.deleteMember(command.getMemberSeq());

			if (result != 1) {
				System.out.println("회원 탈퇴 실패");
				return "errors/mypageChangeError";
			}

			session.invalidate(); //탈퇴 성공시, 로그인 세션 제거 
			
			return "/member/member_alert/memberDeleteNext";

		}
		model.addAttribute("msg", "비밀번호가 다릅니다.");

		return "/member/deleteForm";
	}
	

}
