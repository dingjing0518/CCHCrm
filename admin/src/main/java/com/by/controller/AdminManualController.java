package com.by.controller;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.utils.WechatTemplateMsgUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.by.form.ManualForm;
import com.by.model.Member;
import com.by.model.Menu;
import com.by.model.Message;
import com.by.model.RejectedGoods;
import com.by.model.Shop;
import com.by.model.Trading;
import com.by.security.UserContext;
import com.by.service.MemberService;
import com.by.service.RejectedGoodsService;
import com.by.service.ShopService;
import com.by.service.TradingService;
import com.by.typeEnum.ScoreHistoryEnum;

@Controller
@RequestMapping(value = "/admin/manual")
public class AdminManualController extends BaseController {
	private final String ADD_FORM = "admin/manual/add/create";
	private final String MINUS_FORM = "admin/manual/minus/create";
	private final String ADD_FORM_REDIRECT = "redirect:/admin/manual/add";
	private final String MINUS_FORM_REDIRECT = "redirect:/admin/manual/minus";
	@Autowired
	private TradingService tradingServcie;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RejectedGoodsService rejectedGoodsService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private UserContext userContext;
	@Value("${reason.manual.add.success}")
	private String ADD_SUCCESS;
	@Value("${reason.manual.add.fail}")
	private String ADD_FAIL_REASON;
	@Value("${reason.manual.minus.fail}")
	private String MINUS_FAIL_REASON;
	@Value("${reason.manual.minus.success}")
	private String MINUS_SUCCESS_REASON;
	private static Logger log = LoggerFactory.getLogger(AdminManualController.class);
	private final Menu subMenu = new Menu(6);

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addForm(Model uiModel) {
		uiModel.addAttribute("form", new ManualForm());
		return ADD_FORM;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addScore(ManualForm form, RedirectAttributes redirectAttributes) {
		// trading set score
		try {
			Trading trading = tradingServcie.manualAddScore(form, userContext.getCurrentUser().getName());

			if(trading.getScore() > 0) {
				//发送积分变动模板消息
				WechatTemplateMsgUtil.Verification verification = new WechatTemplateMsgUtil.Verification();
				verification.setMobile(form.getMobile());
				verification.setScore(trading.getScore());
				WechatTemplateMsgUtil.sendScoreMsg(verification, "m");
			}

//			Member member = memberService.findByName(form.getMobile());
			redirectAttributes.addFlashAttribute("message", new Message("bg-success", ADD_SUCCESS));
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("message", new Message("bg-danger", e.getMessage()));
			log.error(e.getMessage() + "," + form.getAmount() + "," + form.getMobile());
		}
		return ADD_FORM_REDIRECT;
	}

	@RequestMapping(value = "/minus", method = RequestMethod.GET)
	public String minusForm(Model uiModel) {
		uiModel.addAttribute("form", new ManualForm());
		return MINUS_FORM;
	}
	
	@RequestMapping(value = "/minus", method = RequestMethod.POST)
	public String minusScore(ManualForm form, RedirectAttributes redirectAttributes) {
		Member member = memberService.findByName(form.getMobile());
		Trading t = tradingServcie.findByCode(form.getFlowCode());
		if (member != null) {
			int score;
			if (t != null && t.getScore() != null) {
				score = t.getScore();
			} else {
				Shop shop = shopService.findByName(form.getShopName());
				//店铺名不存在，返回错误消息
				if(shop == null) {
					redirectAttributes.addFlashAttribute("message",
							new Message("bg-danger", "店铺不存在，退货失败！"));
					return MINUS_FORM_REDIRECT;
				}
				score = tradingServcie.tradeToScore(member, shop, form.getAmount());
			}
			try {
				member = memberService.minusScoreAll(member, score, "退货", ScoreHistoryEnum.ADMIN, form.getRemark(), form.getFlowCode(), userContext.getCurrentUser().getName());
				RejectedGoods goods = new RejectedGoods();
				goods.setAmount(form.getAmount());
				goods.setCreatedBy(userContext.getCurrentUser().getName());
				goods.setMobile(form.getMobile());
				goods.setShopName(form.getShopName());
				rejectedGoodsService.save(goods);
				redirectAttributes.addFlashAttribute("message",
						new Message("bg-success", "退货成功，用户积分：" + member.getScore() + ""));
			} catch (Exception e) {
				redirectAttributes.addFlashAttribute("message", new Message("bg-danger", MINUS_FAIL_REASON));
				log.error(e.getMessage() + "," + form.getAmount() + "," + form.getMobile());
			}
		}
		return MINUS_FORM_REDIRECT;
	}

	@Override
	public Menu getSubMenu() {
		return subMenu;
	}
}
