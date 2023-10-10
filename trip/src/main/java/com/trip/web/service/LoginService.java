package com.trip.web.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.LoginDAO;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;

	public Map<String, Object> login(Map<String, String> map) {
		return loginDAO.login(map);
	}

	public int signin(Map<String, String> map) {
		return loginDAO.signin(map);
	}

	public int idCheck(String val) {
		return loginDAO.idCheck(val);
	}

	public int phoneCheck(String val) {
		return loginDAO.phoneCheck(val);
	}

	public int emailCheck(String val) {
		return loginDAO.emailCheck(val);
	}
}