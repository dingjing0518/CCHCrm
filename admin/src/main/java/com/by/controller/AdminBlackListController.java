package com.by.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.form.AdminMemberForm;
import com.by.json.MemberJson;
import com.by.model.Card;
import com.by.model.Menu;
import com.by.service.CardService;
import com.by.service.MemberService;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 16-1-5.
 */
@Controller
@RequestMapping("/admin/blackList")
public class AdminBlackListController extends BaseController {
	private final String LIST = "admin/blacklist/lists";
	private final Menu subMenu = new Menu(3);
	@Autowired
	private MemberService service;
	@Autowired
	private CardService cardService;

	@ModelAttribute("cards")
	public List<Card> findAllCard() {
		return cardService.findAllCache().stream().filter(i -> i.getValid().equals(ValidEnum.VALID))
				.collect(Collectors.toList());
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(AdminMemberForm form, Model uiModel,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "createdTime", direction = Sort.Direction.DESC) Pageable pageable) {
		Page<MemberJson> list = service.findAll(form, pageable, ValidEnum.INVALID);
		uiModel.addAttribute("form", form);
		uiModel.addAttribute("lists", list);
		uiModel.addAttribute("last", computeLastPage(list.getTotalPages()));
		return LIST;
	}
	@RequestMapping(value = "/json", method = RequestMethod.GET)
	@ResponseBody
	public Status list(AdminMemberForm form,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "createdTime", direction = Sort.Direction.DESC) Pageable pageable) {
		Page<MemberJson> results = service.findAll(form, pageable, ValidEnum.INVALID);
		return new Success<>(results);
	}
	@Override
	public Menu getSubMenu() {
		return subMenu;
	}
}
