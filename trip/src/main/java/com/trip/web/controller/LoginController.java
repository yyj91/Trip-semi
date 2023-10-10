package com.trip.web.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trip.web.service.LoginService;
import com.trip.web.util.Util;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private Util util;

	/* LOGIN : 로그인 */

	@ResponseBody
	@PostMapping(value = "/login", produces = "application/json; charset=utf8")
	public Map<String, Object> login(@RequestParam(name = "id") String id, @RequestParam(name = "pw") String pw,
			HttpServletRequest request) {

		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);

		Map<String, Object> result = loginService.login(map);

		if (result != null && (Long) result.get("count") == 1L) {
			HttpSession session = request.getSession();
			session.setAttribute("uuid", result.get("uuid"));
			session.setAttribute("grade", result.get("grade"));
		}
		return result;
	}

	/* LOGOUT : 로그아웃 */

	@ResponseBody
	@GetMapping("/logout")
	public Map<String, Object> logout(HttpSession httpSession) {

		Map<String, Object> response = new HashMap<>();
		response.put("result", "true");
		if (httpSession.getAttribute("uuid") != null) {
			httpSession.invalidate();
		}
		return response;
	}

	/* SIGN IN : 회원가입 */

	// 회원가입 로딩
	@GetMapping("/signin")
	public String signin() {

		return "signin";
	}
	
	// 화원가입 결과
	@PostMapping("/signin")
	public String signin(@RequestParam Map<String, String> map, HttpServletResponse response) {

		int result = loginService.signin(map);

		if (result == 1) {
			String script = "<script>window.close();</script>";
			response.setContentType("text/html; charset=UTF-8");
			try {
				response.getWriter().print(script);
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		} else {
			return "redirect:signin";
		}
	}

	// 입력값 중복검사
	@ResponseBody
	@PostMapping("/validate")
	public int validate(@RequestParam String fieldName, @RequestParam String value) {

		int result = -1;
		switch (fieldName) {
		case "id":
			result = loginService.idCheck(value);
			break;
		case "phone":
			result = loginService.phoneCheck(value);
			break;
		case "email":
			result = loginService.emailCheck(value);
			break;
		}
		return result;
	}
	
	// 이메일 인증코드 생성 발송
	@ResponseBody
	@PostMapping("/sendVerificationCode")
	public boolean sendVerificationCode(@RequestParam String email, HttpServletRequest request) {

		String charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
		String code = "";
		int length = 10;

		for (int i = 0; i < length; i++) {
			code += charset.charAt((int) (Math.random() * charset.length()));
		}
		System.out.println(code);

		try {
			util.sendVerificationCode(email, code);

			HttpSession session = request.getSession();
			String existingCode = (String) session.getAttribute("emailCode");
			if (existingCode != null) {
				session.removeAttribute("emailCode");
			}
			session.setAttribute("emailCode", code);

			return true;
		} catch (EmailException e) {
			e.printStackTrace();
			return false;
		}
	}

	// 이메일 인증코드 확인
	@ResponseBody
	@PostMapping("/checkVerificationCode")
	public boolean checkVerificationCode(@RequestParam String code, HttpServletRequest request) {

		HttpSession session = request.getSession();
		String verificationCode = (String) session.getAttribute("emailCode");
		if (verificationCode != null && verificationCode.equals(code))
			return true;
		else
			return false;
	}

	/* FIND ID : 아이디 찾기 */

	@GetMapping("/findid")
	public String findid() {
		return "findid";
	}

	/* FIND PW : 비밀번호 찾기 */

	@GetMapping("/findpw")
	public String findpw() {
		return "findpw";
	}
}