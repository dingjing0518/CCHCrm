package com.by.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.MemberDetailJson;
import com.by.model.Member;
import com.by.model.MemberDetail;
import com.by.service.MemberDetailService;
import com.by.service.MemberService;
import com.by.utils.FailBuilder;

@Controller
@RequestMapping(value = "/api/member")
public class MemberDetailController implements UtilContoller {
	@Autowired
	private MemberDetailService service;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ShaPasswordEncoder encoder;

	/*
	 * @param detail:realName,address,birthday
	 */
	// 更新用户资料 除了password
	@RequestMapping(value = "/details", method = RequestMethod.PUT)
	@ResponseBody
	public Status update(@Valid @RequestBody MemberDetailJson detail, BindingResult result,
			HttpServletRequest request) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		if (result.hasErrors()) {
			return FailBuilder.buildFail(result);
		}
		return new Success<>(new MemberDetailJson(service.update(member.getId(), detail)));
	}

	// 获取用户资料
	@RequestMapping(value = "/details", method = RequestMethod.GET)
	@ResponseBody
	public Status get(HttpServletRequest request) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		MemberDetail detail = member.getMemberDetail();
		return new Success<>(new MemberDetailJson(detail));
	}

	// 更新用户密码
	@RequestMapping(value = "/password", method = RequestMethod.PUT)
	@ResponseBody
	public Status updatePassword(@Valid @RequestBody MemberDetailJson detail, BindingResult result,
			HttpServletRequest request) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOne(member.getId());
		validMember(member);
		if (result.hasErrors()) {
			return FailBuilder.buildFail(result);
		}
		detail.setPassword(encoder.encodePassword(detail.getPassword(), null));
		return new Success<>(new MemberDetailJson(service.updatePassword(member.getId(), detail)));
	}
}
