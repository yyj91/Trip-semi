package com.trip.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trip.web.dto.MypageDTO;
import com.trip.web.service.MypageService;

@Controller
public class MypageController {

	@Autowired
	private MypageService mypageService;
	
	 @Autowired
	    public MypageController(MypageService mypageService) {
	        this.mypageService = mypageService;
	    }
	
	

	// 회원정보/예약내역 불러오기
	@GetMapping("/mypage")
	public String mypage(Model model, HttpSession session) {

		String uuid = (String) session.getAttribute("uuid");
		
		if (uuid != null) {
			// 로그인 했을 때
			
			List<MypageDTO> list = mypageService.list(uuid);
			List<MypageDTO> rvlist = mypageService.rvlist(uuid);
			
			model.addAttribute("rvlist", rvlist);
			model.addAttribute("mypage", list);

			return "mypage";
			
		} else {
			// 로그인 안했을 때
			return "redirect:/main";
		}

	}
	
	//예약내역 취소하기
	@PostMapping("/mypage/cancel")
	@ResponseBody
	public  String cancelReservation(@RequestBody Map<String, Object> requestData) {
		 
		try {
			//requestData에서 rvlist, fuuid 데이터값 뽑기
	        List<Integer> rvlist = (List<Integer>) requestData.get("rvlist");
	        String fuuid = (String) requestData.get("fuuid");

	        return "예약이 취소되었습니다.";
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 예약 취소 중 오류가 발생한 경우 오류 메시지 반환
	        return "예약 취소 중 오류가 발생했습니다.";
	    }
	}
	
	// 회원정보 수정하기
	@PostMapping("/mypage/update")
	public String mpupdate(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request) {

		String mid = request.getParameter("mid");
		
		MypageDTO dto = new MypageDTO();

		//map.remove("mid");
		mypageService.mpupdate(map);

		System.out.println(map);
		return "redirect:/mypage";
	}

	// 탈퇴하기
	@GetMapping("/mypage/remove")
	public String remove() {

		return "mypage";
	}

	@PostMapping("/mypage/remove")
	public String remove(HttpServletRequest request, HttpSession session) {

		String mid = request.getParameter("mid");

		if (mypageService.remove(mid)) {

			session.invalidate();
			return "redirect:/index";

		} else {

			return "redirect:/mypage";
		}

	}

}
