package com.by.controller;

import com.by.exception.AdminNotFoundException;
import com.by.exception.Success;
import com.by.form.BaseCouponForm;
import com.by.json.ShopCategoryJson;
import com.by.json.ShopRuleJson;
import com.by.model.Menu;
import com.by.model.Rule;
import com.by.model.ShopCategory;
import com.by.model.ShopRule;
import com.by.service.RuleService;
import com.by.service.ShopCategoryService;
import com.by.service.ShopRuleService;
import com.by.service.ShopService;
import com.by.typeEnum.ValidEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by dingjing on 2017/3/9.
 * 积分规则
 */
@Controller
@RequestMapping("/admin/rules")
public class AdminRuleController extends BaseController{
    private final Menu subMenu = new Menu(28);
    private final String LISTS = "admin/rules/lists";
    private final String EDIT = "admin/rules/edit";
    private final String CREATE = "admin/rules/create";
    private final String REDIRECT = "redirect:/admin/rules/";
    @Autowired
    private ShopRuleService service;
    @Autowired
    private ShopService shopService;
    @Autowired
    private RuleService ruleService;
    @Autowired
    private MessageSource messageSource;
    @Autowired
    private ShopCategoryService shopCategoryService;
    private static Logger log = LoggerFactory.getLogger(AdminShopRuleController.class);
    @Autowired
    @Override
    public Menu getSubMenu() {
        return subMenu;
    }
    //业态对应的店铺
    @ModelAttribute("shopCategoryJsons")
    public List<ShopCategoryJson> categories() {
        List<ShopCategory> categories = shopCategoryService.findAllFirstCategory();
        List<ShopCategoryJson> shopCategoryJsons=new ArrayList<ShopCategoryJson>();
        for(ShopCategory shopCategory:categories){
            ShopCategoryJson shopCategoryJson=new ShopCategoryJson();
            shopCategoryJson.setName(shopCategory.getName());
            shopCategoryJson.setShopList(shopService.findByFirstCategory(shopCategory));
            shopCategoryJsons.add(shopCategoryJson);
            log.error("shopCategory:"+shopService.findByFirstCategory(shopCategory).size());
        }
        log.error("shopCategoryJsons:"+shopCategoryJsons.size());
        return shopCategoryJsons;
    }
    //列表页
    @RequestMapping(method = RequestMethod.GET)
    public String list(BaseCouponForm form, Model uiModel,
                       @PageableDefault(page = INIT_PAGE, size = PAGE_SIZE) Pageable pageable) {
        Page<ShopRuleJson> lists = ruleService.findAll(form, pageable);
        uiModel.addAttribute("lists", lists);
        uiModel.addAttribute("last", computeLastPage(lists.getTotalPages()));
        uiModel.addAttribute("form", form);
        return LISTS;
    }
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String form(Model uiModel) {
        uiModel.addAttribute("rule", new ShopRule());
        return CREATE;
    }

    @RequestMapping(params = "form", method = RequestMethod.POST)
    public String save(@Valid @ModelAttribute("rule") ShopRule rule, BindingResult result, Model uiModel,
                       RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            uiModel.addAttribute("rule", rule);
            return CREATE;
        }
        rule.setCreatedBy(userContext.getCurrentUser().getName());
        rule.setCreatedTime(Calendar.getInstance());
        ShopRule r = service.save(rule);
        redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
        return REDIRECT + r.getId();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") int id, Model uiModel) {
        ShopRule rule = service.findOne(id);
        if (rule == null)
            throw new AdminNotFoundException();
        uiModel.addAttribute("rule", rule);
        uiModel.addAttribute("statusMessage", getStatusMessage(rule));
        return EDIT;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public String update(@PathVariable("id") int id, @Valid @ModelAttribute("rule") ShopRule rule, BindingResult result,
                         Model uiModel, RedirectAttributes redirectAttributes) {
        rule.setId(id);
        if (result.hasErrors()) {
            uiModel.addAttribute("rule", rule);
            rule.setValid(ValidEnum.VALID);
            uiModel.addAttribute("statusMessage", getStatusMessage(rule));
            return EDIT;
        }
        rule.setUpdatedBy(userContext.getCurrentUser().getName());
        rule.setUpdatedTime(Calendar.getInstance());
        ShopRule r = service.update(rule);
        redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
        return REDIRECT + r.getId() + "?edit";
    }

    @RequestMapping(value = "/json", method = RequestMethod.GET)
    @ResponseBody
    public Success<Page<ShopRuleJson>> list(BaseCouponForm form,
                                            @PageableDefault(page = INIT_PAGE, size = PAGE_SIZE) Pageable pageable) {
        Page<ShopRuleJson> lists = ruleService.findAll(form, pageable);
        return new Success<>(lists);
    }

    @RequestMapping(value = "/{id}/valid", method = RequestMethod.PUT)
    public String Valid(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        service.valid(id);
        redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
        return REDIRECT + id;
    }

    @RequestMapping(value = "/name/duplicate", method = RequestMethod.GET)
    @ResponseBody
    public boolean nameDuplicate(@RequestParam("name") String name,
                                 @RequestParam(value = "id", required = false) Integer id) {
        if (id == null) {
            Long count = ruleService.countByName(name);
            return count > 0 ? false : true;
        } else {
            Rule coupon = ruleService.findByName(name);
            if (coupon != null)
                return id == coupon.getId() ? true : false;
            return true;
        }
    }
}
