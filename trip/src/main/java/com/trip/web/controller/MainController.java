package com.trip.web.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trip.web.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;

	@GetMapping({"/", "/main"})
	public String main() {
       return "main";
    }
	
	@ResponseBody
	@PostMapping(value = "/getArrivalList", produces = "application/json; charset=utf8")
	public String getArrivalList(@RequestParam("departure") String departure) {
		
		List<String> arrivalList = mainService.arrivalList(departure);
		System.out.println(arrivalList);
		
		JSONObject json = new JSONObject();
		JSONArray listArr = new JSONArray(arrivalList);
		json.put("arrivalList", listArr);
		
		return json.toString();
	}
}