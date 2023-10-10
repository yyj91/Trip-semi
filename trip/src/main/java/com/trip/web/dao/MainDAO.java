package com.trip.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainDAO {

	List<String> arrivalList(String departure);
}
