package com.by.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Fail;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.CouponMemberJson;
import com.by.model.GiftCouponMember;
import com.by.model.Menu;
import com.by.service.GiftCouponMemberService;

/**
 * Created by yagamai on 16-3-3.
 */
@Controller
@RequestMapping(value = "/admin/giftCouponMember")
public class AdminGiftCouponMemberController extends BaseController {
	private final String LIST = "admin/giftCouponMember/lists";
	private final Menu subMenu = new Menu(7);
	@Autowired
	private GiftCouponMemberService service;

	// 卡券列表
	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(required = false, value = "code") String code, Model uiModel) {
		List<CouponMemberJson> viewList = new ArrayList<CouponMemberJson>();
		if(StringUtils.isEmpty(code)) {
			uiModel.addAttribute("lists", viewList);
			uiModel.addAttribute("search",0);
		} else {
			GiftCouponMember giftCouponMember = service.findByCodeAndValid(code);
			if(giftCouponMember == null) {
				uiModel.addAttribute("search",1);
				uiModel.addAttribute("lists", viewList);
			} else {
				uiModel.addAttribute("search",1);
				viewList.add(giftCouponMember.toJson());
				uiModel.addAttribute("lists", viewList);
			}
		}
		return LIST;
	}

	@RequestMapping(value = "/json", method = RequestMethod.GET)
	@ResponseBody
	public Status list(@RequestParam(required = false, value = "mobile") String mobile,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "exchangedTime", direction = Sort.Direction.DESC) Pageable pageable) {
		Page<CouponMemberJson> lists = service.findByMember(mobile, pageable);
		return new Success<>(lists);
	}

	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Success<String> verification(@RequestBody Verification info) {
		service.useCoupon(info.getCode(), info.getMobile());	
		return new Success<>("success");
	}
	
	@Override
	public Menu getSubMenu() {
		return subMenu;
	}

	public static class Verification {
		private String mobile;
		private String code;

		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}
	}
}
