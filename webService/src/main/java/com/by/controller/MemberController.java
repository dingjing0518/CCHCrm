package com.by.controller;

import java.util.Locale;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.by.exception.Fail;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.MemberRequestJson;
import com.by.model.Member;
import com.by.model.MemberDetail;
import com.by.service.CardService;
import com.by.service.MemberService;
import com.by.utils.FailBuilder;
import com.by.utils.JWTUtils;

@RestController
@RequestMapping(value = "/member")
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	private CardService cardService;
	@Autowired
	@Qualifier("memberNameValidator")
	private Validator validator;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private ShaPasswordEncoder encoder;

	// 用户注册
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	@ResponseBody
	public Status signUp(@Valid @RequestBody MemberRequestJson json, BindingResult result) {
		validator.validate(json, result);
		if (result.hasErrors()) {
			return FailBuilder.buildFail(result);
		}
		MemberDetail detail = new MemberDetail();
		if (!StringUtils.isEmpty(json.getPassword())) {
			detail.setPassword(encoder.encodePassword(json.getPassword(), null));
		}
		Member member = new Member(json);
		member.setMemberDetail(detail);
		member = service.save(member);
		cardService.addSignUpScore(member);
		return new Success<>(JWTUtils.encode(member));
	}

	// 用户登入
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	@ResponseBody
	public Status signIn(@RequestBody MemberRequestJson json) {
		Member member = service.findByName(json.getName());
		if (member != null) {
			return new Success<>(JWTUtils.encode(member));
		}
		return new Fail("用户不存在");
	}

	// 用户是否存在 存在返回status fail 不存在返回success
	@RequestMapping(value = "/exist", method = RequestMethod.GET)
	@ResponseBody
	public Status count(@RequestParam("mobile") String mobile) {
		Long count = service.countByName(mobile);
		if (count > 0)
			return new Fail(messageSource.getMessage("name.unique", new Object[] {}, Locale.CHINA));
		return new Success<>(null);
	}

}
