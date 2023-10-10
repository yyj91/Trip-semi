package com.trip.web.dto;

import lombok.Data;

@Data
public class MypageDTO {
	
	private String mlastname, mfirstname, mid, mpw, mphone, memail, muuid;

	//private String fuuid, flight_uuid,flight_name, departure, departure_time, arrival, arrival_time, seat_grade;
	private String fuuid, fname, fairline, fdeparture, farrival, ftod, ftoa, sgrade;
}
