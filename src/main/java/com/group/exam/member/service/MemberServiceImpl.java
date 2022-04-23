package com.group.exam.member.service;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.exam.member.command.InsertCommand;
import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.dao.MemberDAO;
import com.group.exam.member.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public LoginCommand login(String memberId) {
		// TODO Auto-generated method stub
		
		return memberDAO.login(memberId);
		
	}

	@Override
	public LoginCommand findPwd(String memberId) {
		// TODO Auto-generated method stub
		return memberDAO.findPwd(memberId);
	}

	@Override
	public int updateTmpPwd(String tmpPwd, String memberId) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("tmpPwd", tmpPwd);
		map.put("memberId", memberId);
				
		return memberDAO.updateTmpPwd(map);
	}


	
	
	
	@Override
	public void memberInsert(InsertCommand insertCommand) {
		
		MemberVo memberVo = new MemberVo();
		memberVo.setMemberId(insertCommand.getMemberId());
		memberVo.setMemberPassword(insertCommand.getMemberPassword());
		memberVo.setMemberNickname(insertCommand.getMemberNickname());
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date = format.parse(insertCommand.getMemberBirthDay());
			memberVo.setMemberBirthDay(date);
			System.out.println("insert Service \n" + memberVo);
			memberDAO.insert(memberVo);
		} catch (ParseException e) {
			//날짜로 형변환 실패
		}
		
 
	}

	@Override
	public int nicknameDup(String memberNickname) {
		int res = memberDAO.nicknameDup(memberNickname);
		return res;
	}

	@Override
	public int idDup(String memberId) {	
		return memberDAO.idDup(memberId);
	}
	
	@Override
	public void updateAuthkey(InsertCommand insertCommand) {
		MemberVo memberVo = new MemberVo();
		memberVo.setMemberId(insertCommand.getMemberId());
		memberVo.setMemberAuthkey(insertCommand.getMemberAuthkey());
		memberDAO.updateAuthkey(memberVo);
	}
	
	public void updateAuth(String mAuthkey) {
		MemberVo memberVo = new MemberVo();
		memberVo.setMemberAuth("T");
		memberVo.setMemberAuthkey(mAuthkey);
		memberDAO.updateAuth(memberVo);
	}

	@Override
	public int updateMemberPwd(String memberPassword, int memberSeq) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberPassword", memberPassword);
		map.put("memberSeq", memberSeq);
		return memberDAO.updateMemberPwd(map);
	}

	@Override
	public int updateMemberNickname(String memberNickname, int memberSeq) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNickname", memberNickname);
		map.put("memberSeq", memberSeq);
		
		return memberDAO.updateMemberNickname(map);
	}

	@Override
	public int deleteMember(int memberSeq) {
		// TODO Auto-generated method stub
		return memberDAO.deleteMember(memberSeq);
	}

	@Override
	public int memberQuestionAdd(String questionContent, int memberSeq) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("questionContent", questionContent);
		map.put("memberSeq", memberSeq);
		return memberDAO.memberQuestionAdd(map);
	}


}
