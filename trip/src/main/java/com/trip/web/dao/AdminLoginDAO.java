package com.trip.web.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminLoginDAO {

	int adminLogin(Map<String, Object> map);

	String adminLoginUuid(String getuuid);
	
}
