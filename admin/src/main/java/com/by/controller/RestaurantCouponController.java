package com.by.controller;

import com.by.exception.NotFoundException;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.RestaurantCouponJson;
import com.by.model.Menu;
import com.by.model.RestaurantCoupon;
import com.by.service.RestaurantCouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * Created by yvan on 2017/1/5.
 */
@Controller
@RequestMapping("/admin/restaurant/coupon")
public class RestaurantCouponController extends BaseController {

    @Autowired
    RestaurantCouponService restaurantCouponService;

    @Autowired
    private MessageSource messageSource;

    private final Menu subMenu = new Menu(31);

    //列表
    @RequestMapping(method = RequestMethod.GET)
    public String list(@RequestParam(required = false, value = "name") String name,
                       Model uiModel,
                       @PageableDefault(page = INIT_PAGE, size = PAGE_SIZE) Pageable pageable) {
        Page<RestaurantCoupon> restaurantCoupons = restaurantCouponService.findAll(name, pageable);
        uiModel.addAttribute("lists", restaurantCoupons);
        uiModel.addAttribute("last", computeLastPage(restaurantCoupons.getTotalPages()));
        uiModel.addAttribute("name", name);
        return "admin/restaurantcoupon/list";
    }

    //分页
    @RequestMapping(value = "/json", method = RequestMethod.GET)
    @ResponseBody
    public Status list(@RequestParam(required = false, value = "name") String name,
                       @PageableDefault(page = INIT_PAGE, size = PAGE_SIZE, sort = "name", direction = Sort.Direction.ASC) Pageable pageable) {
        Page<RestaurantCouponJson> pages = restaurantCouponService.findAllJson(name, pageable);
        return new Success<>(pages);
    }

    //详情
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String view(Model uiModel, @PathVariable("id") Long id) {
        RestaurantCoupon restaurantCoupon = restaurantCouponService.findOne(id);
        if (restaurantCoupon == null)
            throw new NotFoundException();
        uiModel.addAttribute("restaurantCoupon", restaurantCoupon);
        return "admin/restaurantcoupon/edit";
    }

    // 修改店铺信息
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public String edit(@Valid @ModelAttribute("restaurantCoupon") RestaurantCoupon restaurantCoupon, Model uiModel,
                       @PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        restaurantCoupon.setId(id);
        restaurantCouponService.update(restaurantCoupon);
        redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
        return "redirect:/admin/restaurant/coupon/" + id;
    }

    // 新增店铺页面
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String form(Model uiModel) {
        RestaurantCoupon restaurantCoupon = new RestaurantCoupon();
        uiModel.addAttribute("restaurantCoupon", restaurantCoupon);
        return "admin/restaurantcoupon/create";
    }

    // 增加一个店铺
    @RequestMapping(params = "form", method = RequestMethod.POST)
    public String add(@Valid @ModelAttribute("shop") RestaurantCoupon restaurantCoupon, BindingResult result, Model uiModel,
                      RedirectAttributes redirectAttributes) {
        RestaurantCoupon s = restaurantCouponService.save(restaurantCoupon);
        redirectAttributes.addFlashAttribute("message", successMessage(messageSource));
        return "redirect:/admin/restaurant/coupon/" + s.getId();
    }

    @RequestMapping(value = "/name/duplicate", method = RequestMethod.GET)
    @ResponseBody
    public boolean nameDuplicate(@RequestParam("name") String name,
                                 @RequestParam(value = "id", required = false) Long id) {
        if (id == null) {
            Long count = restaurantCouponService.countByName(name);
            return count > 0 ? false : true;
        } else {
            RestaurantCoupon restaurantCoupon = restaurantCouponService.findByName(name);
            if (restaurantCoupon != null)
                return restaurantCoupon.getId() == id ? true : false;
            return true;
        }
    }

    @RequestMapping(value = "/phone/duplicate", method = RequestMethod.GET)
    @ResponseBody
    public boolean phoneDuplicate(@RequestParam("phone") String phone,
                                 @RequestParam(value = "id", required = false) Long id) {
        if (id == null) {
            Long count = restaurantCouponService.countByPhone(phone);
            return count > 0 ? false : true;
        } else {
            RestaurantCoupon restaurantCoupon = restaurantCouponService.findByPhone(phone);
            if (restaurantCoupon != null)
                return restaurantCoupon.getId() == id ? true : false;
            return true;
        }
    }

    @Override
    public Menu getSubMenu() {
        return subMenu;
    }
}
