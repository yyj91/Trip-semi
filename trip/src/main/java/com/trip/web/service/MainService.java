package com.trip.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.MainDAO;

@Service
public class MainService {
	
	@Autowired
	private MainDAO mainDAO;

	public List<String> arrivalList(String departure) {
		return mainDAO.arrivalList(departure);
	}

}
