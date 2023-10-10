package com.trip.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.trip.web.dto.MypageDTO;

@Mapper
public interface MypageDAO {
	

	boolean remove(String mid);

	List<MypageDTO> list(String mid);

	int mpupdate(Map<String, Object> map);

	List<MypageDTO> rvlist(String mid);

	MypageDTO getUserByUsername(Object mfirstname);

	int cancleReservation(Map<String, Object> map);


	

	








}
