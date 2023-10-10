package com.trip.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReservationDAO {

	List<Map<String, Object>> deplist(Map<String, Object> map);

	List<Map<String, Object>> arrlist(Map<String, Object> map);

	List<Map<String, Object>> sortDepListCostDesc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortDepListCostAsc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortArrListCostDesc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortArrListCostAsc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortDepListTimeDesc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortDepListTimeAsc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortArrListTimeDesc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> sortArrListTimeAsc(Map<String, Object> searchCriteria);

	List<Map<String, Object>> seatList(String fuuid);

	Map<String, Object> getFInfo(Object fuuid);

	Map<String, Object> getSInfo(Object sno);

	List<Map<String, Object>> getAInfo();
}
