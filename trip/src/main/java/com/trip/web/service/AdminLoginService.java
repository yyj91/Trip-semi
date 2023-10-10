package com.trip.web.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.AdminLoginDAO;

@Service
public class AdminLoginService {
	
	@Autowired
	private AdminLoginDAO adminLoginDAO;

	public int adminLogin(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return adminLoginDAO.adminLogin(map);
	}

	public String adminLoginUuid(String getuuid) {
		
		return adminLoginDAO.adminLoginUuid(getuuid);
	}
}
