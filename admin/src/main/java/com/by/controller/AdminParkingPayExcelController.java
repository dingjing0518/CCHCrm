package com.by.controller;

import com.by.form.BaseExcelForm;
import com.by.json.MemberScoreExcelJson;
import com.by.json.ParkingPayExcelJson;
import com.by.model.Menu;
import com.by.service.MemberScoreExcelService;
import com.by.service.ParkingPayExcelService;
import com.by.utils.excel.ExportUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

/**
 * Created by dingjing on 2017/3/17.
 */
@Controller
@RequestMapping("admin/parkingPayExcel")
public class AdminParkingPayExcelController extends BaseController{
    private final Menu subMenu = new Menu(33);
    private final String EXCEL = "admin/parkingPayExcel/excel";
    private static Logger log = LoggerFactory.getLogger(AdminParkingPayExcelController.class);
    @Autowired
    private ParkingPayExcelService service;
    @RequestMapping(method = RequestMethod.GET)
    public String excel(BaseExcelForm form, Model uiModel) {
        uiModel.addAttribute("form", form);
        return EXCEL;
    }
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(BaseExcelForm form,HttpServletResponse response) throws IOException {

        List<ParkingPayExcelJson> parkingPayExcelJsons=service.findAll(form);
        log.error("parkingPayExcelJsons:"+parkingPayExcelJsons.size());
        ExportUtil<ParkingPayExcelJson> ex = new ExportUtil<ParkingPayExcelJson>();
        String[] headers = { "会员号","车牌","入场时间","支付时间","应付金额","积分抵扣金额","实付金额"};
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        ex.exportExcel("会员停车支付记录",headers, parkingPayExcelJsons, out,"yyyy-MM-dd");

        byte[] bytes = out.toByteArray();
        response.setContentType("application/x-msdownload");
        response.setContentLength(bytes.length);
        response.setHeader("Content-Disposition", "attachment;filename="
                + java.net.URLEncoder.encode("会员停车支付记录.xls", "UTF-8"));
        response.getOutputStream().write(bytes);

        out.close();
    }
    @Override
    public Menu getSubMenu() {
        return subMenu;
    }
}
