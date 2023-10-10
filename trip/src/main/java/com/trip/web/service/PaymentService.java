package com.trip.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.web.dao.PaymentDAO;
import com.trip.web.dto.PaymentDTO;

@Service
public class PaymentService {

	@Autowired
	private PaymentDAO paymentDAO;

	public int passengers(List<PaymentDTO> paymentList) {
		
		return paymentDAO.passengers(paymentList);
	}

	public void sremainder(PaymentDTO dto) {
		paymentDAO.sremainder(dto);		
	}

	public void totalamount(PaymentDTO dto2) {
		paymentDAO.totalamount(dto2);		
	}

	public int getPno(PaymentDTO dto) { 
		return paymentDAO.getPno(dto); 
	}

	public void reservations(PaymentDTO dto) {
		paymentDAO.reservations(dto);
		
	}

	public int getruuid(PaymentDTO dto) {
		
		return paymentDAO.getruuid(dto);
	}

	public void reservations2(PaymentDTO dto) {
		paymentDAO.reservations2(dto);
	}

	public Map<String, Object> payment(String string) {
		
		return paymentDAO.payment(string);
	}

	
 
 }

