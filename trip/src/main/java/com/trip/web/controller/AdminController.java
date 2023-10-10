package com.trip.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.trip.web.service.AdminLoginService;
import com.trip.web.service.FlightScheduleService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminLoginService adminLoginService;
	
	@GetMapping("/")
	public String adminLogin() {
		return "/admin/login";
	}
	
	@PostMapping("/login")
	public String adminLogin(@RequestParam Map<String, Object> map, HttpSession session) {
		
		int login = adminLoginService.adminLogin(map);
		System.out.println(login);
		
		if(login == 1) {
			session.setAttribute("id", map.get("username").toString());
			
			return "redirect:/admin/admin";
		} else {
			return "/admin/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("id");
		return "/admin/login";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("/admin")
	public String admin(Model airport, Model airline, HttpSession session) throws IOException {
		if(session.getAttribute("id") != null) {
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=F6JXyeatHxaFUgIUoAVecT003hs2VhqGazwev8BzGQWVYeiL%2FixeAuSqmrDeeZsZytkqLlCJV2DKdurqso7IOA%3D%3D"); /*
																														 * Service
																														 * Key
																														 */
		urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
				+ URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		String response = sb.toString();
		rd.close();
		conn.disconnect();

		// JSON 데이터를 Java 객체로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> data = objectMapper.readValue(response, Map.class);

		// 필요한 데이터 추출
		Map<String, Object> responseMap = (Map<String, Object>) data.get("response");
		Map<String, Object> bodyMap = (Map<String, Object>) responseMap.get("body");
		Map<String, Object> itemsMap = (Map<String, Object>) bodyMap.get("items");
		List<Map<String, Object>> itemList = (List<Map<String, Object>>) itemsMap.get("item");

		// 모델에 데이터 추가
		airport.addAttribute("departureAirport", itemList);
		airport.addAttribute("arrivalAirport", itemList);

		StringBuilder urlBuilder0 = new StringBuilder(
				"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList"); /* URL */
		urlBuilder0.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=F6JXyeatHxaFUgIUoAVecT003hs2VhqGazwev8BzGQWVYeiL%2FixeAuSqmrDeeZsZytkqLlCJV2DKdurqso7IOA%3D%3D"); /*
																														 * Service
																														 * Key
																														 */
		urlBuilder0.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
				+ URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
		URL url0 = new URL(urlBuilder0.toString());
		HttpURLConnection conn0 = (HttpURLConnection) url0.openConnection();
		conn0.setRequestMethod("GET");
		conn0.setRequestProperty("Content-type", "application/json");
		BufferedReader rd0;
		if (conn0.getResponseCode() >= 200 && conn0.getResponseCode() <= 300) {
			rd0 = new BufferedReader(new InputStreamReader(conn0.getInputStream()));
		} else {
			rd0 = new BufferedReader(new InputStreamReader(conn0.getErrorStream()));
		}
		StringBuilder sb0 = new StringBuilder();
		String line0;
		while ((line0 = rd0.readLine()) != null) {
			sb0.append(line0);
		}
		String response0 = sb0.toString();
		rd0.close();
		conn0.disconnect();

		// JSON 데이터를 Java 객체로 변환
		ObjectMapper objectMapper0 = new ObjectMapper();
		Map<String, Object> data0 = objectMapper0.readValue(response0, Map.class);

		// 필요한 데이터 추출
		Map<String, Object> responseMap0 = (Map<String, Object>) data0.get("response");
		Map<String, Object> bodyMap0 = (Map<String, Object>) responseMap0.get("body");
		Map<String, Object> itemsMap0 = (Map<String, Object>) bodyMap0.get("items");
		List<Map<String, Object>> itemList0 = (List<Map<String, Object>>) itemsMap0.get("item");

		// 모델에 데이터 추가
		airline.addAttribute("airline", itemList0);

		return "/admin/admin";
		} else {
			return "/admin/login";
		}
		
	}

	@SuppressWarnings("unchecked")
	@PostMapping("/admin")
	public String admin0(Model airport, Model airline, @RequestParam Map<String, Object> map, Model model, HttpSession session) throws IOException, Exception {
		if(session.getAttribute("id") != null) {
			StringBuilder urlBuilder = new StringBuilder(
					"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=F6JXyeatHxaFUgIUoAVecT003hs2VhqGazwev8BzGQWVYeiL%2FixeAuSqmrDeeZsZytkqLlCJV2DKdurqso7IOA%3D%3D"); /*
																															 * Service
																															 * Key
																															 */
			urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
					+ URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			//System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			String response = sb.toString();
			rd.close();
			conn.disconnect();
			//System.out.println(response);

			// JSON 데이터를 Java 객체로 변환
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> data = objectMapper.readValue(response, Map.class);

			// 필요한 데이터 추출
			Map<String, Object> responseMap = (Map<String, Object>) data.get("response");
			Map<String, Object> bodyMap = (Map<String, Object>) responseMap.get("body");
			Map<String, Object> itemsMap = (Map<String, Object>) bodyMap.get("items");
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) itemsMap.get("item");

			// 모델에 데이터 추가
			airport.addAttribute("departureAirport", itemList);
			airport.addAttribute("arrivalAirport", itemList);

			StringBuilder urlBuilder0 = new StringBuilder(
					"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList"); /* URL */
			urlBuilder0.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=F6JXyeatHxaFUgIUoAVecT003hs2VhqGazwev8BzGQWVYeiL%2FixeAuSqmrDeeZsZytkqLlCJV2DKdurqso7IOA%3D%3D"); /*
																															 * Service
																															 * Key
																															 */
			urlBuilder0.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
					+ URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
			URL url0 = new URL(urlBuilder0.toString());
			HttpURLConnection conn0 = (HttpURLConnection) url0.openConnection();
			conn0.setRequestMethod("GET");
			conn0.setRequestProperty("Content-type", "application/json");
			//System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd0;
			if (conn0.getResponseCode() >= 200 && conn0.getResponseCode() <= 300) {
				rd0 = new BufferedReader(new InputStreamReader(conn0.getInputStream()));
			} else {
				rd0 = new BufferedReader(new InputStreamReader(conn0.getErrorStream()));
			}
			StringBuilder sb0 = new StringBuilder();
			String line0;
			while ((line0 = rd0.readLine()) != null) {
				sb0.append(line0);
			}
			String response0 = sb0.toString();
			rd0.close();
			conn0.disconnect();
			//System.out.println(response0);

			// JSON 데이터를 Java 객체로 변환
			ObjectMapper objectMapper0 = new ObjectMapper();
			Map<String, Object> data0 = objectMapper0.readValue(response0, Map.class);

			// 필요한 데이터 추출
			Map<String, Object> responseMap0 = (Map<String, Object>) data0.get("response");
			Map<String, Object> bodyMap0 = (Map<String, Object>) responseMap0.get("body");
			Map<String, Object> itemsMap0 = (Map<String, Object>) bodyMap0.get("items");
			List<Map<String, Object>> itemList0 = (List<Map<String, Object>>) itemsMap0.get("item");

			// 모델에 데이터 추가
			airline.addAttribute("airline", itemList0);

		}
		if(session.getAttribute("id") != null) {
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=F6JXyeatHxaFUgIUoAVecT003hs2VhqGazwev8BzGQWVYeiL%2FixeAuSqmrDeeZsZytkqLlCJV2DKdurqso7IOA%3D%3D"); /*
																														 * Service
																														 * Key
																														 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
				+ URLEncoder.encode("200", "UTF-8")); /* 한 페이지 결과 수 */
		urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
				+ URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
		urlBuilder.append("&" + URLEncoder.encode("depAirportId", "UTF-8") + "="
				+ URLEncoder.encode(map.get("depAirportId").toString(), "UTF-8")); /* 출발공항ID */
		urlBuilder.append("&" + URLEncoder.encode("arrAirportId", "UTF-8") + "="
				+ URLEncoder.encode(map.get("arrAirportId").toString(), "UTF-8")); /* 도착공항ID */
		urlBuilder.append("&" + URLEncoder.encode("depPlandTime", "UTF-8") + "="
				+ URLEncoder.encode(map.get("depPlandTime").toString(), "UTF-8")); /* 출발일(YYYYMMDD) */
		urlBuilder.append("&" + URLEncoder.encode("airlineId", "UTF-8") + "="
				+ URLEncoder.encode(map.get("airlineId").toString(), "UTF-8")); /* 항공사ID */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 400) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		String response = sb.toString();
		rd.close();
		conn.disconnect();

		// JSON 데이터를 Java 객체로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> data = objectMapper.readValue(response, Map.class);

		// 필요한 데이터 추출
		Map<String, Object> responseMap = (Map<String, Object>) data.get("response");
		Map<String, Object> bodyMap = (Map<String, Object>) responseMap.get("body");
		// items 필드를 확인하여 비어있는지 검사
		Object itemsObject = bodyMap.get("items");
		if (itemsObject instanceof String && ((String) itemsObject).isEmpty()) {
		    // items가 빈 문자열인 경우에 메시지를 모델에 추가
		    model.addAttribute("message", "운항 스케줄이 없습니다.");
		} else {
		    // items가 빈 문자열이 아니라면 필요한 데이터를 추출
		    Map<String, Object> itemsMap = (Map<String, Object>) itemsObject;
		    List<Map<String, Object>> itemList = (List<Map<String, Object>>) itemsMap.get("item");

		    // "yyyyMMddHHmm" 형식의 long 값을 원하는 형식으로 변환
		    SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		    SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		    
		    for (Map<String, Object> item : itemList) {
		        long depPlandTimeLong = (Long)item.get("depPlandTime");
		        long arrPlandTimeLong = (Long)item.get("arrPlandTime");
		        
		        Date depDate = inputDateFormat.parse(String.valueOf(depPlandTimeLong));
		        Date arrDate = inputDateFormat.parse(String.valueOf(arrPlandTimeLong));
		        
		        String formattedDepPlandTime = outputDateFormat.format(depDate);
		        String formattedArrPlandTime = outputDateFormat.format(arrDate);
		        
		        item.put("depPlandTime", formattedDepPlandTime);
		        item.put("arrPlandTime", formattedArrPlandTime);
		    }

		    model.addAttribute("list", itemList);
		}


		return "/admin/admin";
		} else {
			return "/admin/login";
		}
	}

}

@Controller
@RequestMapping("/admin")
class FlightScheduleController {
	
	@Autowired
	private FlightScheduleService flightScheduleService;
	
	@ResponseBody
	@PostMapping("/flightdata0")
	public void flightData0(@RequestBody Map<String, Object> map) {
			try {
				
				flightScheduleService.saveFlightData0(map);

			} catch (Exception e) {
				// TODO: handle exception
			}
        
	}
	
	@ResponseBody
	@PostMapping("/flightdata1")
	public void flightData1(@RequestBody Map<String, Object> map) {
		try {
			flightScheduleService.saveFlightData1(map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	
}
