package com.by.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.by.exception.Fail;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.form.UserQueryForm;
import com.by.json.UserJson;
import com.by.model.Authority;
import com.by.model.Menu;
import com.by.model.User;
import com.by.service.AuthorityService;
import com.by.service.UserService;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 15-12-11.
 */
@Controller
@RequestMapping(value = "/admin/users")
public class AdminUserController extends BaseController {
	private final String LISTS = "admin/user/lists";
	private final String EDIT = "admin/user/edit";
	private final String CREATE = "admin/user/create";
	private final String REDIRECT = "redirect:/admin/users/";
	private final Menu subMenu = new Menu(17);
	@Autowired
	private UserService service;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	@Qualifier("userNameValidator")
	private Validator validator;
	@Autowired
	private ShaPasswordEncoder encoder;

	@ModelAttribute("authorities")
	public List<Authority> authorities() {
		return authorityService.findAll().stream().filter(i -> i.getValid().equals(ValidEnum.VALID))
				.collect(Collectors.toList());
	}

	@RequestMapping(value = "/duplicate", method = RequestMethod.GET)
	@ResponseBody
	public Status duplicate(@RequestParam("name") String name) {
		if (service.countByName(name) > 0)
			return new Fail("fail");
		return new Success<String>("success");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model uiModel, UserQueryForm form,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "beginTime", direction = Sort.Direction.DESC) Pageable pageable) {
		Page<User> lists = service.findAll(form, pageable);
		uiModel.addAttribute("users", service.toJson(lists, pageable));
		uiModel.addAttribute("last", computeLastPage(lists.getTotalPages()));
		uiModel.addAttribute("form", form);
		return LISTS;
	}

	@RequestMapping(params = "form", method = RequestMethod.GET)
	public String form(Model uiModel) {
		uiModel.addAttribute("user", new User());
		return CREATE;
	}

	@RequestMapping(params = "form", method = RequestMethod.POST)
	public String save(@Valid @ModelAttribute("user") User user, BindingResult result, Model uiModel,
			RedirectAttributes redirectAttributes) {
		validator.validate(user, result);
		if (result.hasErrors()) {
			uiModel.addAttribute("user", user);
			uiModel.addAttribute("message", failMessage(messageSource));
			return CREATE;
		}
		user.setCreatedBy(userContext.getCurrentUser().getName());

		user.setPassword(encoder.encodePassword(user.getPassword(),null));
		User u = service.save(user);
		redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
		return REDIRECT + u.getId();
	}

	@RequestMapping(value = "/json", method = RequestMethod.GET)
	@ResponseBody
	public Success<Page<UserJson>> listJson(UserQueryForm form,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "beginTime", direction = Sort.Direction.DESC) Pageable pageable) {
		Page<User> users = service.findAll(form, pageable);
		return new Success<>(service.toJson(users, pageable));
	}

	@RequestMapping(value = "/{id}/validate", method = RequestMethod.PUT)
	public String validate(@PathVariable("id") int id) {
		service.validate(id);
		return REDIRECT + id;
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public String update(@PathVariable("id") int id, @Valid @ModelAttribute("user") User user, BindingResult result,
			Model uiModel, RedirectAttributes redirectAttributes) {
		user.setId(id);
		if (result.hasErrors()) {
			uiModel.addAttribute("user", user);
			uiModel.addAttribute("message", failMessage(messageSource));
			return EDIT;
		}
		User source = service.update(user);
		redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
		return REDIRECT + source.getId();
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") int id, Model uiModel) {
		User user = service.findOne(id);
		uiModel.addAttribute("user", user);
		return EDIT;
	}

	@RequestMapping(value = "/name/duplicate", method = RequestMethod.GET)
	@ResponseBody
	public boolean nameDuplicate(@RequestParam("name") String name,
			@RequestParam(value = "id", required = false) Integer id) {
		if (id == null) {
			Long count = service.countByName(name);
			return count > 0 ? false : true;
		} else {
			User user = service.findByName(name);
			if (user != null)
				return user.getId() == id ? true : false;
			return true;
		}
	}
	//重置密码
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	@ResponseBody
	public String resetPassword(@RequestParam("name") String name) {
		User user=service.findByName(name);
		user.setPassword(encoder.encodePassword("123456", null));
		service.updatePassword(user);
		return "success";
	}
	@Override
	public Menu getSubMenu() {
		return subMenu;
	}
}
