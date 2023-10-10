package com.trip.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.trip.web.dao.MypageDAO;
import com.trip.web.dto.MypageDTO;

@Service
public class MypageService {

	@Autowired
	private MypageDAO mypageDAO;
	
	
	//회원정보 불러오기
	public List<MypageDTO> list(String uuid) {

		return mypageDAO.list(uuid);
	}
	
	//회원 탈퇴
	public boolean remove(String mid) {

		return mypageDAO.remove(mid);
	}

	//회원정보 수정
	@Transactional
	public boolean mpupdate(Map<String, Object> map) {
	
		int rowsAffected = mypageDAO.mpupdate(map);
		
		return rowsAffected > 0;//업데이트 된 행의 수가 0보다 크면 true, 아니면 false 반환
		
	}
	
	//예약 내역 불러오기
	public List<MypageDTO> rvlist(String uuid) {
		
		return mypageDAO.rvlist(uuid);
	}

	//예약 내역 취소하기
	public boolean cancleReservation(Map<String, Object> map) {
		
		int rowsAffected = mypageDAO.cancleReservation(map);
		
		return rowsAffected > 0;
		
	}
	
	

	

}

	  
