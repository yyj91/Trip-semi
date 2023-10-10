package com.trip.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trip.web.service.ReservationService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	
	@GetMapping("/reservation")
	public String reservation(@RequestParam Map<String, Object> map, Model model) {
		System.out.println(map);
		model.addAllAttributes(map);
		
		List<Map<String, Object>> depList = reservationService.list(map, 0);
		List<Map<String, Object>> arrList = new ArrayList<Map<String,Object>>();
		if(map.get("choice").equals("B"))
			arrList = reservationService.list(map, 1);
		
		//System.out.println(depList);
		//System.out.println(arrList);
		
		model.addAttribute("depList", depList);
		model.addAttribute("arrList", arrList);
		
		return "reservation";
	}
	
	@ResponseBody
	@GetMapping(value = "/getSortedList", produces = "application/text; charset=utf8")
	public String getSortedList(@RequestParam String option, @RequestParam String section, @RequestParam Map<String, Object> searchCriteria) {
				
		Map<String, Object> map = new HashMap<>();
		map.put("choice", searchCriteria.get("searchCriteria[choice]"));
		map.put("departure", searchCriteria.get("searchCriteria[departure]"));
		map.put("arrival", searchCriteria.get("searchCriteria[arrival]"));
		map.put("tod", searchCriteria.get("searchCriteria[tod]"));
		map.put("toa", searchCriteria.get("searchCriteria[toa]"));
		map.put("adultCount", searchCriteria.get("searchCriteria[adultCount]"));
		map.put("childCount", searchCriteria.get("searchCriteria[childCount]"));
		map.put("infantCount", searchCriteria.get("searchCriteria[infantCount]"));
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		switch(option) {
		case "가격 낮은순":
			list = reservationService.sortedByCost(section, map, 1);
			break;
		case "가격 높은순":
			list = reservationService.sortedByCost(section, map, 0);
			break;
		case "출발 빠른순":
			list = reservationService.sortedByTime(section, map, 1);
			break;
		case "출발 늦은순":
			list = reservationService.sortedByTime(section, map, 0);
			break;
		}
		
		JSONObject json = new JSONObject();
		JSONArray arr = new JSONArray(list);
		json.put("list", arr);
		//System.out.println(json.toString());
		
		return json.toString();
	}
	
	@ResponseBody
	@GetMapping(value = "/getDetailInfo", produces = "application/text; charset=utf8")
	public String getDetailInfo(@RequestParam String fuuid) {
		
		List<Map<String, Object>> seatList = reservationService.seatList(fuuid);
		System.out.println(seatList);
		
		JSONObject json = new JSONObject();
		JSONArray arr = new JSONArray(seatList);
		json.put("list", arr);
		
		return json.toString();
	}
	
	@ResponseBody
	@GetMapping(value = "/selectedInfo", produces = "application/text; charset=utf8")
	public String selectedInfo(@RequestParam Map<String, Object> map) {
		
		Map<String, Object> fInfo = reservationService.getFInfo(map.get("fuuid"));
		Map<String, Object> sInfo = reservationService.getSInfo(map.get("sno"));
		List<Map<String, Object>> aInfo = reservationService.getAInfo();
		
		System.out.println("fInfo : " + fInfo);
		System.out.println("sInfo : " + sInfo);
		System.out.println("aInfo : " + aInfo);
		
		JSONObject json = new JSONObject();
		json.put("fInfo", fInfo);
		json.put("sInfo", sInfo);
		json.put("aInfo", aInfo);
		
		return json.toString();
	}
}
