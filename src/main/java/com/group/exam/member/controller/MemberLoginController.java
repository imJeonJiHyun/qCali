package com.group.exam.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
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
import com.group.exam.member.service.MemberService;
import com.group.exam.member.vo.MemberVo;
import com.group.exam.utils.MemberSessionConfig;


@Controller
public class MemberLoginController {
	
	
	private BCryptPasswordEncoder passwordEncoder;
	
	
	private MemberService memberService;
	
	@Autowired
	public MemberLoginController(BCryptPasswordEncoder passwordEncoder, MemberService memberService) {
		// TODO Auto-generated constructor stub
		this.passwordEncoder = passwordEncoder;
		this.memberService = memberService;
	}

	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String handleLogin(@ModelAttribute("loginMemberData") LoginCommand logincommand, HttpSession session) {
		
		//로그인 세션이 이미 있을 경우 
		if (session.getAttribute("memberLogin") != null) {
			return "/";
		}
		
		
		return "/member/loginForm";
	}
	
	
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(@Valid @ModelAttribute("loginMemberData") LoginCommand command, BindingResult bindingResult,HttpSession session, Model model) {
		
		if(bindingResult.hasErrors()) {
			return "/member/loginForm";
		}
		
		
		LoginCommand member = memberService.login(command.getMemberId());
		
		if(member == null) {
			System.out.println("로그인 정보 없음 or 비밀번호 불일치 : " + member);
			
			model.addAttribute("msg", "해당 회원 정보가 없습니다.");
			return "/member/loginForm";
		}
	
		String password = command.getMemberPassword();
		
		LoginCommand login = member;
		
		//로그인 (비밀번호 암호화 했을 때)
		String encodePassword = member.getMemberPassword();
		boolean pwdEncode= passwordEncoder.matches(password, encodePassword);
	
		
		
		if(member != null && pwdEncode) {

			System.out.println("로그인 성공 ");
			//중복 로그인 방지
			String memberId = MemberSessionConfig.getSessionidCheck("memberLogin",
					command.getMemberId());
			
			// 세션 만료 시간
			session.setMaxInactiveInterval(60 * 60);

			session.setAttribute("memberLogin", login);	
			return "redirect:/board/list";
		} else {
			System.out.println("로그인 정보 없음 or 비밀번호 불일치 : " + member);
			
			model.addAttribute("msg", "해당 회원 정보가 없습니다.");
			return "/member/loginForm";
		}
	}
	
	
	
	
	
}
