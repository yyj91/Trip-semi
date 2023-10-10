package com.trip.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trip.web.dto.PaymentDTO;
import com.trip.web.service.PaymentService;

@Controller
public class PaymentController {
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/payment")
	public String payment(HttpSession session, @RequestParam Map<String, Object> map, Model model) {
		System.out.println(map);
		Map<String, Object> Pmap = paymentService.payment((String)map.get("depfuuid"));
		model.addAttribute("choice", map.get("choice"));
		model.addAttribute("adultCount", map.get("adultCount"));
		model.addAttribute("childCount", map.get("childCount"));
		model.addAttribute("infantCount", map.get("infantCount"));
		model.addAttribute("depdate", map.get("depdate"));
		model.addAttribute("depairline", map.get("depairline"));
		model.addAttribute("depfname", map.get("depfname"));
		model.addAttribute("depsgrade", map.get("depsgrade"));
		model.addAttribute("depftod", map.get("depftod"));
		model.addAttribute("depftoa", map.get("depftoa"));
		model.addAttribute("depadultsprice", map.get("depadultsprice"));
		model.addAttribute("depchildsprice", map.get("depchildsprice"));
		model.addAttribute("depfuuid", map.get("depfuuid"));
		model.addAttribute("depsno", map.get("depsno"));
		model.addAttribute("arival", map.get("arival"));
		
		model.addAttribute("arrdate", map.get("arrdate"));
		model.addAttribute("arrairline", map.get("arrairline"));
		model.addAttribute("arrfname", map.get("arrfname"));
		model.addAttribute("arrsgrade", map.get("arrsgrade"));
		model.addAttribute("arrftod", map.get("arrftod"));
		model.addAttribute("arrftoa", map.get("arrftoa"));
		model.addAttribute("arradultsprice", map.get("arradultsprice"));
		model.addAttribute("arrfuuid", map.get("arrfuuid"));
		model.addAttribute("arrchildsprice", map.get("arrchildsprice"));
		model.addAttribute("arrsno", map.get("arrsno"));
		model.addAttribute("arrsno", map.get("arrsno"));
		model.addAttribute("fdeparture", Pmap.get("fdeparture"));
		model.addAttribute("farrival", Pmap.get("farrival"));
		
		
		System.out.println("map이 여기 " +  (String)map.get("choice"));
		String uuid = (String) session.getAttribute("uuid");		
		if (uuid != null) { //로그인 했을때만 payment 들어갈 수 있게
			return "payment";
		} else {
			return "redirect:/main";
		}
	}	
	@PostMapping("/passengers")
	public String passengers(@RequestParam("plastname") String[] plastname,
	        @RequestParam("pfirstname") String[] pfirstname,  
	        @RequestParam("pnationality") String[] pnationality,  
	        @RequestParam("pbirth") String[] pbirth, 
	        @RequestParam("pgender") String[] pgender,
	        @RequestParam("sno") int[] sno){
	    List<PaymentDTO> paymentList = new ArrayList<>();
	    System.out.println(plastname);

	    for (int i = 0; i < plastname.length; i++) {
	        PaymentDTO paymentDTO = new PaymentDTO();
	        paymentDTO.setPlastname(plastname[i]);
	        paymentDTO.setPfirstname(pfirstname[i]);
	        paymentDTO.setPnationality(pnationality[i]);
	        paymentDTO.setPbirth(pbirth[i]);
	        paymentDTO.setPgender(pgender[i]);
	        paymentDTO.setSno(sno[i]);

	        paymentList.add(paymentDTO);
	    }
	    int res = paymentService.passengers(paymentList);	   
	    System.out.println(paymentList);
	    if (res == 1 || res == 2 || res == 3 || res == 4) { //탑승객이 몇명이냐를 세는거임
	    	return "redirect:/mypage";
	        
	    } else {
	        return "redirect:/main";
	    }
	}
	
	@PostMapping("/sremainder")
	public void sremainder(PaymentDTO dto) {
		paymentService.sremainder(dto);
	}
	
	@ResponseBody
	@PostMapping("/totalamount")
	public void totalamount(PaymentDTO dto2) {
		
	}

	  @ResponseBody
	  @PostMapping("/getPno") 
	  public Boolean getPno(HttpServletRequest req, @RequestParam  Map<String, Object> map, Model model, PaymentDTO dto, PaymentDTO dto2) { 
		  System.out.println("aa 실행");
		  int hi = paymentService.getPno(dto);
		 
		  dto.setPno(hi); 
		  System.out.println("pno 값 = " + hi);
		  paymentService.totalamount(dto);
		  
		  
		  return true;
	  }
	 
	  @PostMapping("/reservations")
	  public void reservations(PaymentDTO dto) {
		  
	  }
	  @PostMapping("/reservations2")
	  public void reservations2(PaymentDTO dto) {
		  paymentService.reservations2(dto);
		  System.out.println("reservations2 실행" + dto);
	  }
	  
	  
	  
	  @PostMapping("/getruuid")
	  public String getruuid(PaymentDTO dto, Model model) {
		  
		  int getruuid = paymentService.getruuid(dto); //rno임 
		  dto.setRno(getruuid);
		  model.addAttribute("getruuid", getruuid); // jsp의 merchant_uid 계속 갱신해주려고 던져줌
		  System.out.println("ruuid 값 = " + getruuid);
		  paymentService.reservations(dto);
		  
		  return "redirect:/mypage";
	  }
	  
	  

		}
