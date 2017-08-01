package com.by.controller;

import com.by.form.BaseExcelForm;
import com.by.json.MemberExcelJson;
import com.by.json.MemberScoreExcelJson;
import com.by.model.Menu;
import com.by.service.MemberExcelService;
import com.by.service.MemberScoreExcelService;
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
 * Created by dingjing on 2017/3/16.
 */
@Controller
@RequestMapping("admin/memberScoreExcel")
public class AdminMemberScoreExcelController extends BaseController{
    private final Menu subMenu = new Menu(32);
    private final String EXCEL = "admin/memberScoreExcel/excel";
    private static Logger log = LoggerFactory.getLogger(AdminMemberScoreExcelController.class);
    @Autowired
    private MemberScoreExcelService service;
    @RequestMapping(method = RequestMethod.GET)
    public String excel(BaseExcelForm form, Model uiModel) {
        uiModel.addAttribute("form", form);
        return EXCEL;
    }
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(BaseExcelForm form,HttpServletResponse response) throws IOException {

        List<MemberScoreExcelJson> memberScoreExcelJsons=service.findAll(form);
        log.error("memberScoreExcelJsons:"+memberScoreExcelJsons.size());
        ExportUtil<MemberScoreExcelJson> ex = new ExportUtil<MemberScoreExcelJson>();
        String[] headers = { "会员号","业态","交易店铺","交易时间","交易金额","小票号","获得积分","操作人"};
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        ex.exportExcel("会员消费积分报表",headers, memberScoreExcelJsons, out,"yyyy-MM-dd");

        byte[] bytes = out.toByteArray();
        response.setContentType("application/x-msdownload");
        response.setContentLength(bytes.length);
        response.setHeader("Content-Disposition", "attachment;filename="
                + java.net.URLEncoder.encode("会员消费积分报表.xls", "UTF-8"));
        response.getOutputStream().write(bytes);

        out.close();
    }
    @Override
    public Menu getSubMenu() {
        return null;
    }
}
