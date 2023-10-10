package com.trip.web.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface FlightScheduleDAO {

	void saveFlightData0(Map<String, Object> map);

	void saveFlightData1(Map<String, Object> map);

	int saveFlightData3(Map<String, Object> map);

	int saveFlightData2(Map<String, Object> map);
	
}
