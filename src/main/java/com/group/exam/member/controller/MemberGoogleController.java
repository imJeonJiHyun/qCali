package com.group.exam.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.google.gson.JsonParseException;
import com.group.exam.member.command.GoogleOAuthRequest;
import com.group.exam.member.command.GoogleOAuthResponse;

@Controller
public class MemberGoogleController {
	/**
	 * Authentication Code를 전달 받는 엔드포인트
	 **/

	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";
	final static String GOOGLE_REVOKE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/revoke";

	String clientId = "68355066340-ghvpek91dtd21jgoiprdgc0115p2d42d.apps.googleusercontent.com";
	String clientSecret = "";

	@RequestMapping("/login/google/auth")
	public String googleAuth( @RequestParam(value = "code") String authCode,Model model)
			throws JsonProcessingException {

		// HTTP Request를 위한 RestTemplate
		RestTemplate restTemplate = new RestTemplate();

		// Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest.builder().clientId(clientId)
				.clientSecret(clientSecret).code(authCode).redirectUri("http://localhost:8080/exam/login/google/auth")
				.grantType("authorization_code").build();

		// JSON 파싱을 위한 기본값 세팅
		// 요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

		// AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
				String.class);

		// Token Request
		GoogleOAuthResponse result;
		try {
			result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
			});
			// ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
			String jwtToken = result.getIdToken();
			String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
					.queryParam("id_token", jwtToken).toUriString();

			String resultJson = restTemplate.getForObject(requestUrl, String.class);

			Map<String, String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>() {
			});
			model.addAllAttributes(userInfo);
			model.addAttribute("token", result.getAccessToken());
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/board/list";

	}

	/**
	 * 토큰 무효화
	 **/
//	@GetMapping("google/revoke/token")
//	@ResponseBody
//	public Map<String, String> revokeToken(@RequestParam(value = "token") String token) throws JsonProcessingException {
//
//		Map<String, String> result = new HashMap<>();
//		RestTemplate restTemplate = new RestTemplate();
//		final String requestUrl = UriComponentsBuilder.fromHttpUrl(GOOGLE_REVOKE_TOKEN_BASE_URL)
//				.queryParam("token", token).encode().toUriString();
//
//		System.out.println("TOKEN ? " + token);
//
//		String resultJson = restTemplate.postForObject(requestUrl, null, String.class);
//		result.put("result", "success");
//		result.put("resultJson", resultJson);
//
//		return result;
//
//	}

}