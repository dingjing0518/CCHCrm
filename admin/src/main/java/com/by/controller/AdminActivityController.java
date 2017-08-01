package com.by.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.by.factory.ShoppingMallFactory;
import com.by.json.ActivityJson;
import com.by.model.Activity;
import com.by.model.Menu;
import com.by.service.ActivityService;

/**
 * Created by yagamai on 16-3-29.
 */
@Controller
@RequestMapping("/admin/{mall}/activity")
public class AdminActivityController extends BaseController {
	private final Menu subMenu = new Menu();
	private final String LIST = "admin/activity/lists";
	private final String CREATE = "admin/activity/create";
	private final String EDIT = "admin/activity/edit";
	private final String REDIRECT = "redirect:/admin/";
	@Autowired
	private ActivityService service;
	@Autowired
	private MessageSource messageSource;

	@RequestMapping(method = RequestMethod.GET)
		public String list(@PathVariable("mall") String m, Model uiModel,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE) Pageable pageable) {
		Page<Activity> activities = service.findByMall(ShoppingMallFactory.MALL.fromString(m), pageable);
		List<ActivityJson> jsons = convertToJson(activities);
		uiModel.addAttribute("lists", new PageImpl<>(jsons, pageable, activities.getTotalElements()));
		uiModel.addAttribute("last", computeLastPage(activities.getTotalPages()));
		return LIST;
	}

	@RequestMapping(value = "/json", method = RequestMethod.GET)
	@ResponseBody
	public Page<ActivityJson> listJson(@PathVariable("mall") String m,
			@PageableDefault(page = INIT_PAGE, size = PAGE_SIZE) Pageable pageable) {
		Page<Activity> activities = service.findByMall(ShoppingMallFactory.MALL.fromString(m), pageable);
		List<ActivityJson> jsons = convertToJson(activities);
		return new PageImpl<>(jsons, pageable, activities.getTotalElements());
	}

	@RequestMapping(params = "form", method = RequestMethod.GET)
	public String save(Model uiModel) {
		uiModel.addAttribute("adv", new Activity());
		return CREATE;
	}

	@RequestMapping(params = "form", method = RequestMethod.POST)
	public String save(Model uiModel, @PathVariable("mall") String mall, @ModelAttribute("adv") Activity act,
			BindingResult result, RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			uiModel.addAttribute("act", act);
			uiModel.addAttribute("message", failMessage(messageSource));
			return EDIT;
		}
		act.setMall(ShoppingMallFactory.MALL.fromString(mall));
		Activity a = service.save(act);
		redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
		return REDIRECT + mall + "/films/" + a.getId();
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public String update(@PathVariable("id") int id, Model uiModel, @PathVariable("mall") String mall,
			@ModelAttribute("adv") Activity act, BindingResult result, RedirectAttributes redirectAttributes) {
		act.setId(id);
		if (result.hasErrors()) {
			uiModel.addAttribute("adv", act);
			uiModel.addAttribute("message", failMessage(messageSource));
			return EDIT;
		}
		service.update(act);
		redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
		return REDIRECT + mall + "/activity/" + id;
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String detail(@PathVariable("id") int id, Model uiModel, @PathVariable("mall") String mall) {
		Activity act = service.findOne(id);
		uiModel.addAttribute("act", act);
		uiModel.addAttribute("mall", mall);
		return EDIT;
	}

	private List<ActivityJson> convertToJson(Page<Activity> activities) {
		return activities.getContent().stream().map(i -> new ActivityJson(i)).collect(Collectors.toList());

	}

	@Override
	public Menu getSubMenu() {
		return subMenu;
	}
}
