package com.trip.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.FlightScheduleDAO;

@Service
public class FlightScheduleService {
	
	@Autowired
	private FlightScheduleDAO flightScheduledao;

	public void saveFlightData0(Map<String, Object> map) {
		int result = flightScheduledao.saveFlightData3(map);
		System.out.println(result);
		if(result == 0) {
			
			flightScheduledao.saveFlightData0(map);
		}
		
	}

	public void saveFlightData1(Map<String, Object> map) {
		int result = flightScheduledao.saveFlightData2(map);
		System.out.println(result);
		if(result == 0) {
			
			flightScheduledao.saveFlightData1(map);
		}
		
	}

	
	
	
}
