package com.trip.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.trip.web.dto.PaymentDTO;

@Repository
@Mapper
public interface PaymentDAO {

	int passengers(List<PaymentDTO> paymentList);

	void sremainder(PaymentDTO dto);

	void totalamount(PaymentDTO dto2);

	int getPno(PaymentDTO dto);

	void reservations(PaymentDTO dto);

	int getruuid(PaymentDTO dto);

	void reservations2(PaymentDTO dto);

	Map<String, Object> payment(String string); 

}
