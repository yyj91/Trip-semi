package com.trip.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.InputStreamReader;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

@Controller
public class AirPortController {

	@GetMapping("/airportid")
	public String airportid(Model model) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=Nqnes5uE5IepWjrgSE%2F6a6Be9vI1hgAnEQVYIkZ%2F%2B7lg5SpPlIQhSKO4gyTSzhajDTiiu1emQgkdavo%2Flrfu4A%3D%3D"); /* Service Key */
		urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
				+ URLEncoder.encode("xml", "UTF-8")); /* 데이터 타입(xml, json) */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
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
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		model.addAttribute("airport", sb.toString())
;		return "airportid";
	}

}
