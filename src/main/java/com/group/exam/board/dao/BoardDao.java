package com.group.exam.board.dao;

import java.util.HashMap;
import java.util.List;

import com.group.exam.board.command.BoardlistCommand;
import com.group.exam.board.command.QuestionAdayCommand;
import com.group.exam.board.vo.BoardHeartVo;
import com.group.exam.board.vo.BoardVo;
import com.group.exam.utils.Criteria;

public interface BoardDao {
	
	public void insertBoard (BoardVo boardVo); //새 게시글 쓰기
	
	public void updateBoard (HashMap<String, Object> map); //게시글 수정
	
	public void deleteBoardOne (HashMap<String, Integer> map); //게시글 삭제
	
	public List<BoardlistCommand> boardList(Criteria cri); // 게시글 전체 리스트
	
	public List<BoardlistCommand> boardMyList (HashMap<String, Object> map); // 내가 쓴 글 모아보기
	
	public BoardlistCommand boardListDetail (int boardSeq); // 특정 게시글 디테일
	
	public int listCount (); // board 테이블 전체 글 수
	
	public int boardMylistCount (int memberSeq); // 내가 쓴 글 수 
	
	public void boardCountup (int boardSeq); // 해당 게시글 카운트 업
	
	public String memberAuth (int memberSeq); //멤버 Auth 상태 체크
	
	public int memberLevelup (HashMap<String, Object> map); //멤버 level up 기능
	
	public List<BoardlistCommand> boardSearch (HashMap<String, Object> map); //닉네임, 제목으로 검색
	
	//질문 하루마다 출력 기능 관련
	public QuestionAdayCommand questionselect(int num);
	
	public int getSequence();
	
	public int currentSequence();
	
	//좋아요 기능 관련
    public int getBoardLike(BoardHeartVo vo);

    public void insertBoardLike(BoardHeartVo vo);

    public void deleteBoardLike(BoardHeartVo vo);

    public void updateBoardLike(int boardSeq);
}
