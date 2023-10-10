package com.trip.web.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {
	
	Map<String, Object> login(Map<String, String> map);

	int signin(Map<String, String> map);

	int idCheck(String val);

	int phoneCheck(String val);

	int emailCheck(String val);
}