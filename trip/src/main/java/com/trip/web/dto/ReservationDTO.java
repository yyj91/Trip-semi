package com.trip.web.dto;

import lombok.Data;

@Data
public class ReservationDTO {
	private String fdeparture, farrival, fname, fairline, ftod, ftoa, sgrade;
	private int sprice, sseats, sremainder;
}
