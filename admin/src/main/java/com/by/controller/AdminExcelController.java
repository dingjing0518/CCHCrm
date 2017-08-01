package com.by.controller;
import com.by.form.BaseExcelForm;
import com.by.json.ExcelJson;
import com.by.model.Menu;
import com.by.service.ExcelService;
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
 * Created by dingjing on 2017/3/14.
 */
@Controller
@RequestMapping("/admin/excel")
public class AdminExcelController extends BaseController{
    private final Menu subMenu = new Menu(30);
    private final String EXCEL = "admin/excel/excel";
    private static Logger log = LoggerFactory.getLogger(AdminExcelController.class);
    @Autowired
    private ExcelService service;
    @RequestMapping(method = RequestMethod.GET)
    public String excel(BaseExcelForm form, Model uiModel) {
        uiModel.addAttribute("form", form);
        return EXCEL;
    }
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(BaseExcelForm form,HttpServletResponse response) throws IOException {

        List<ExcelJson> excelJsons=service.findAll(form);
        log.error("excelJsons:"+excelJsons.size());
        ExportUtil<ExcelJson> ex = new ExportUtil<ExcelJson>();
        String[] headers = { "会员号", "积分","创建时间"};
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        ex.exportExcel(headers, excelJsons, out);

        byte[] bytes = out.toByteArray();
        response.setContentType("application/x-msdownload");
        response.setContentLength(bytes.length);
        response.setHeader("Content-Disposition", "attachment;filename="
                + java.net.URLEncoder.encode("档期列表.xls", "UTF-8"));
        response.getOutputStream().write(bytes);

        out.close();
    }
    @Override
    public Menu getSubMenu() {
        return subMenu;
    }
}
