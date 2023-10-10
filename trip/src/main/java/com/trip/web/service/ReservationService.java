package com.trip.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.ReservationDAO;

@Service
public class ReservationService {

	@Autowired
	private ReservationDAO reservationDAO;

	public List<Map<String, Object>> list(Map<String, Object> map, int i) {
		if(i == 0) {
			return reservationDAO.deplist(map);
		} else {
			return reservationDAO.arrlist(map);
		}
	}

	public List<Map<String, Object>> sortedByCost(String section, Map<String, Object> searchCriteria, int i) {

		System.out.println(searchCriteria);
		
		switch(section) {
		case "dep":
			if(i == 0) {
				System.out.println("sortDepListCostDesc run");
				return reservationDAO.sortDepListCostDesc(searchCriteria);
			} else {
				System.out.println("sortDepListCostAsc run");
				return reservationDAO.sortDepListCostAsc(searchCriteria);
			}
		case "arr":
			if(i == 0) {
				System.out.println("sortArrListCostDesc run");
				return reservationDAO.sortArrListCostDesc(searchCriteria);
			} else {
				System.out.println("sortArrListCostAsc run");
				return reservationDAO.sortArrListCostAsc(searchCriteria);
			}
		default:
			return null;
		}
	}

	public List<Map<String, Object>> sortedByTime(String section, Map<String, Object> searchCriteria, int i) {
		
		switch(section) {
		case "dep":
			if(i == 0) {
				System.out.println("sortDepListTimeDesc run");
				return reservationDAO.sortDepListTimeDesc(searchCriteria);
			} else {
				System.out.println("sortDepListTimeAsc run");
				return reservationDAO.sortDepListTimeAsc(searchCriteria);
			}
		case "arr":
			if(i == 0) {
				System.out.println("sortArrListTimeDesc run");
				return reservationDAO.sortArrListTimeDesc(searchCriteria);
			} else {
				System.out.println("sortArrListTimeAsc run");
				return reservationDAO.sortArrListTimeAsc(searchCriteria);
			}
		default:
			return null;
		}
	}

	public List<Map<String, Object>> seatList(String fuuid) {
		return reservationDAO.seatList(fuuid);
	}

	public Map<String, Object> getFInfo(Object fuuid) {
		return reservationDAO.getFInfo(fuuid);
	}

	public Map<String, Object> getSInfo(Object sno) {
		return reservationDAO.getSInfo(sno);
	}

	public List<Map<String, Object>> getAInfo() {
		return reservationDAO.getAInfo();
	}
}
