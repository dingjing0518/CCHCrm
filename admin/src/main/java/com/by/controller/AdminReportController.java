package com.by.controller;

import com.by.form.ReportForm;
import com.by.json.LicenseJson;
import com.by.json.PieReportJson;
import com.by.json.ReportJson;
import com.by.service.*;
import com.by.utils.CalendarUtil;
import com.by.utils.excel.ExportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class AdminReportController {
    private final String MEMBER_REPORT = "admin/report/member";
    private final String TRADING_REPORT = "admin/report/trading";
    private final String PARKING_COUPON_REPORT = "admin/report/parkingCoupon";
    private final String GIFT_COUPON_COUPON_REPORT = "admin/report/giftCoupon";
    private final String SHOP_COUPON_COUPON_REPORT = "admin/report/shopCoupon";
    private final String TRADING_ANALYSYS_REPORT = "admin/report/tradingAnalysis";
    private final String STOCK_INTEGRAL_REPORT = "admin/report/stockIntegral";
    private String[] months = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
    @Autowired
    private MemberIncPerDayService service;
    @Autowired
    private TradingIncPerDayService tradingService;
    @Autowired
    private TradingAnalysisService tradingAnalysisService;
    @Autowired
    private ParkingCouponInfoPerDayService parkingCouponService;
    @Autowired
    private GiftCouponInfoPerDayService giftCouponService;
    @Autowired
    private ShopCouponInfoPerDayService shopCouponService;
    @Autowired
    private StockIntegralService stockIntegralService;

    @ModelAttribute("years")
    public List<Integer> categories() {
        return service.findAllValidYear();
    }

    @ModelAttribute("seasons")
    public List<ReportForm> seasons() {
        List<ReportForm> seasonList = new ArrayList<ReportForm>();

        ReportForm season1 = new ReportForm("第一", 1);
        ReportForm season2 = new ReportForm("第二", 2);
        ReportForm season3 = new ReportForm("第三", 3);
        ReportForm season4 = new ReportForm("第四", 4);

        seasonList.add(season1);
        seasonList.add(season2);
        seasonList.add(season3);
        seasonList.add(season4);

        return seasonList;
    }

    @ModelAttribute("months")
    public List<ReportForm> months() {
        List<ReportForm> monthList = new ArrayList<ReportForm>();

        ReportForm month1 = new ReportForm("一", 1);
        ReportForm month2 = new ReportForm("二", 2);
        ReportForm month3 = new ReportForm("三", 3);
        ReportForm month4 = new ReportForm("四", 4);
        ReportForm month5 = new ReportForm("五", 5);
        ReportForm month6 = new ReportForm("六", 6);
        ReportForm month7 = new ReportForm("七", 7);
        ReportForm month8 = new ReportForm("八", 8);
        ReportForm month9 = new ReportForm("九", 9);
        ReportForm month10 = new ReportForm("十", 10);
        ReportForm month11 = new ReportForm("十一", 11);
        ReportForm month12 = new ReportForm("十二", 12);

        monthList.add(month1);
        monthList.add(month2);
        monthList.add(month3);
        monthList.add(month4);
        monthList.add(month5);
        monthList.add(month6);
        monthList.add(month7);
        monthList.add(month8);
        monthList.add(month9);
        monthList.add(month10);
        monthList.add(month11);
        monthList.add(month12);

        return monthList;
    }


    @RequestMapping(value = "/admin/memberReport", method = RequestMethod.GET)
    public String memberReport() {
        return MEMBER_REPORT;
    }
    
   /* 
    @RequestMapping(value = "/admin/memberReport/data", method = RequestMethod.GET)
    @ResponseBody
    public List<MonthMemberReport> memberReportData(@RequestParam(value = "year", required = false) Integer year) {
        Calendar today = Calendar.getInstance();
        int y = getYear(today, year);
        int m = getMonth(today, year);
        List<Object[]> lists = service.findByYearAndMonth(y, m);
        List<MonthMemberReport> results = lists.stream().map(i -> {
            Integer j = ((Integer) i[0]);
            String k = months[j - 1];
            int v = ((Long) i[1]).intValue();
            String time = (String) i[2];
            return new MonthMemberReport(k, v, time);
        }).collect(Collectors.toList());
        return results;
    }*/

    @RequestMapping(value = "/admin/memberReport/data", method = RequestMethod.GET)
    @ResponseBody
    public ReportJson memberReportDataYear(@RequestParam(value = "year", required = false) Integer year, @RequestParam(value = "season", required = false) Integer season, @RequestParam(value = "month", required = false) Integer month) {
        ReportJson json = new ReportJson();

        //只选择年全部，X轴为每年
        if (year == 0 && season == -1 && month == -1) {
            String[] x = new String[2];
            String[] y = new String[2];

            List<Object[]> lists = service.findByYear();

            for (int i = 0; i < lists.size(); i++) {
                Object[] data = lists.get(i);
                x[i] = String.valueOf(data[0]);
                y[i] = String.valueOf(data[1]);
            }

            ReportJson.Title title = json.new Title();
            title.setText("会员报表");
            json.setTitle(title);

            ReportJson.Tooltip tooltip = json.new Tooltip();
            tooltip.setShow("true");
            json.setTooltip(tooltip);

            ReportJson.Legend legend = json.new Legend();
            legend.setData(new String[]{"会员增长"});
            json.setLegend(legend);

            ReportJson.XAxis xAxis = json.new XAxis();
            xAxis.setType("category");
            xAxis.setData(x);
            xAxis.setBoundaryGap(true);
            json.setxAxis(xAxis);

            ReportJson.YAxis yAxis = json.new YAxis();
            yAxis.setName("");
            yAxis.setValue("value");
            json.setyAxis(yAxis);

            ReportJson.Series series = json.new Series();
            series.setName("会员增长");
            series.setType("bar");
            series.setData(y);

            ReportJson.Series[] seriesArray = new ReportJson.Series[1];
            seriesArray[0] = series;
            json.setSeries(seriesArray);

        } else {
            //（季度和月不可以同时查询前端控制）
            //选择某一年，季度选择全部，X轴为4个季度
            if (year > 0) {
                if (season == 0) {
                    List<Object[]> lists = service.findBySeason(year);

                    String[] x = {"第一季度", "第二季度", "第三季度", "第四季度"};
//                    String[] xDig = {"1", "2", "3", "4"}; 
                    String[] y = {"0", "0", "0", "0"};

                    for (int i = 0; i < 4; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("会员报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"会员增长"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series = json.new Series();
                    series.setName("会员增长");
                    series.setType("bar");
                    series.setData(y);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[1];
                    seriesArray[0] = series;
                    json.setSeries(seriesArray);

                } else if (season > 0) {
                    //选择某一年，季度选择某个季度，X轴为3个月
                    List<Object[]> lists = service.findBySeasonAndMonth(year, season);
                    String[] x1 = {"一月", "二月", "三月"};
                    String[] x2 = {"四月", "五月", "六月"};
                    String[] x3 = {"七月", "八月", "九月"};
                    String[] x4 = {"十月", "十一月", "十二月"};
    				
                    /*String[] x1Dig = {"1", "2", "3"}; 
                    String[] x2Dig = {"4", "5", "6"}; 
                    String[] x3Dig = {"7", "8", "9"}; 
                    String[] x4Dig = {"10", "11", "12"}; */
                    String[] y = {"0", "0", "0"};

                    for (int i = 0; i < 3; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);

                            if (((season - 1) * 3 + i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("会员报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"会员增长"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    switch (season) {
                        case 1:
                            xAxis.setData(x1);
                            break;
                        case 2:
                            xAxis.setData(x2);
                            break;
                        case 3:
                            xAxis.setData(x3);
                            break;
                        case 4:
                            xAxis.setData(x4);
                            break;
                        default:
                            break;
                    }
                    xAxis.setBoundaryGap(true);
                    xAxis.setType("category");
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series = json.new Series();
                    series.setName("会员增长");
                    series.setType("bar");
                    series.setData(y);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[1];
                    seriesArray[0] = series;
                    json.setSeries(seriesArray);
                }
                //选择某一年，月选择全部，X轴为12个月
                if (month == 0) {
                    List<Object[]> lists = service.findByMonth(year);

                    String[] x = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
                    String[] xDig = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
                    String[] y = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};

                    for (int i = 0; i < 12; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("会员报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"会员增长"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series = json.new Series();
                    series.setName("会员增长");
                    series.setType("bar");
                    series.setData(y);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[1];
                    seriesArray[0] = series;
                    json.setSeries(seriesArray);

                } else if (month > 0) {
                    //选择某一年，月选择某个月，X轴为当月的某几天
                    List<Object[]> lists = service.findByMonthAndDay(year, month);

                    int dateOfMonth = CalendarUtil.getDaysByYearMonth(year, month);

                    String[] x = new String[dateOfMonth];
                    String[] y = new String[dateOfMonth];
                    for (int i = 0; i < dateOfMonth; i++) {
                        x[i] = String.valueOf(i + 1);
                        y[i] = "0";
                    }

                    for (int i = 0; i < dateOfMonth; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("会员报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"会员增长"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series = json.new Series();
                    series.setName("会员增长");
                    series.setType("bar");
                    series.setData(y);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[1];
                    seriesArray[0] = series;
                    json.setSeries(seriesArray);

                }
            }

        }

        return json;
    }

    @RequestMapping(value = "/admin/tradingReport", method = RequestMethod.GET)
    public String tradingReport() {
        return TRADING_REPORT;
    }

    /*@RequestMapping(value = "/admin/tradingReport/data", method = RequestMethod.GET)
    @ResponseBody
    public List<MonthTradingReport> tradingReportData(@RequestParam(value = "year", required = false) Integer year) {
        Calendar today = Calendar.getInstance();
        int y = getYear(today, year);
        int m = getMonth(today, year);
        List<Object[]> lists = tradingService.findByYearAndMonth(y, m);
        return lists.stream().map(i -> {
            Integer j = ((Integer) i[0]);
            String month = months[j - 1];
            int number = ((Long) i[1]).intValue();
            Double amount = ((Double) i[2]);
            String time = (String) i[3];
            return new MonthTradingReport(month, amount, number, time);
        }).collect(Collectors.toList());
    }*/

    @RequestMapping(value = "/admin/tradingReport/data", method = RequestMethod.GET)
    @ResponseBody
    public ReportJson tradingReportData(@RequestParam(value = "year", required = false) Integer year, @RequestParam(value = "season", required = false) Integer season, @RequestParam(value = "month", required = false) Integer month) {
        ReportJson json = new ReportJson();

        //只选择年全部，X轴为每年
        if (year == 0 && season == -1 && month == -1) {
            String[] x = new String[2];
            String[] y = new String[2];
            String[] y2 = new String[2];

            List<Object[]> lists = tradingService.findByYear();

            for (int i = 0; i < lists.size(); i++) {
                Object[] data = lists.get(i);
                x[i] = String.valueOf(data[0]);
                y[i] = String.valueOf(new BigDecimal(String.valueOf(data[1])).intValue());
                y2[i] = String.valueOf(new BigDecimal(String.valueOf(data[2])).intValue());
            }

            ReportJson.Title title = json.new Title();
            title.setText("交易报表");
            json.setTitle(title);

            ReportJson.Tooltip tooltip = json.new Tooltip();
            tooltip.setShow("true");
            tooltip.setTrigger("axis");
            json.setTooltip(tooltip);

            ReportJson.Legend legend = json.new Legend();
            legend.setData(new String[]{"交易笔数", "交易金额"});
            json.setLegend(legend);

            ReportJson.XAxis xAxis = json.new XAxis();
            xAxis.setType("category");
            xAxis.setData(x);
            xAxis.setBoundaryGap(true);
            json.setxAxis(xAxis);

            ReportJson.YAxis yAxis = json.new YAxis();
            yAxis.setName("");
            yAxis.setValue("value");
            json.setyAxis(yAxis);

            ReportJson.Series series1 = json.new Series();
            series1.setName("交易笔数");
            series1.setType("bar");
            series1.setData(y);

            ReportJson.Series series2 = json.new Series();
            series2.setName("交易金额");
            series2.setType("bar");
            series2.setData(y2);

            ReportJson.Series[] seriesArray = new ReportJson.Series[2];
            seriesArray[0] = series1;
            seriesArray[1] = series2;
            json.setSeries(seriesArray);

        } else {
            //（季度和月不可以同时查询前端控制）
            //选择某一年，季度选择全部，X轴为4个季度
            if (year > 0) {
                if (season == 0) {
                    List<Object[]> lists = tradingService.findBySeason(year);

                    String[] x = {"第一季度", "第二季度", "第三季度", "第四季度"};
//                    String[] xDig = {"1", "2", "3", "4"}; 
                    String[] y = {"0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0"};

                    for (int i = 0; i < 4; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(new BigDecimal(String.valueOf(data[1])).intValue());
                                y2[i] = String.valueOf(new BigDecimal(String.valueOf(data[2])).intValue());
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("交易报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"交易笔数", "交易金额"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    series1.setName("交易笔数");
                    series1.setType("bar");
                    series1.setData(y);

                    ReportJson.Series series2 = json.new Series();
                    series2.setName("交易金额");
                    series2.setType("bar");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (season > 0) {
                    //选择某一年，季度选择某个季度，X轴为3个月
                    List<Object[]> lists = tradingService.findBySeasonAndMonth(year, season);
                    String[] x1 = {"一月", "二月", "三月"};
                    String[] x2 = {"四月", "五月", "六月"};
                    String[] x3 = {"七月", "八月", "九月"};
                    String[] x4 = {"十月", "十一月", "十二月"};
    				
                    /*String[] x1Dig = {"1", "2", "3"}; 
                    String[] x2Dig = {"4", "5", "6"}; 
                    String[] x3Dig = {"7", "8", "9"}; 
                    String[] x4Dig = {"10", "11", "12"}; */
                    String[] y = {"0", "0", "0"};
                    String[] y2 = {"0", "0", "0"};

                    for (int i = 0; i < 3; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);

                            if (((season - 1) * 3 + i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(new BigDecimal(String.valueOf(data[1])).intValue());
                                y2[i] = String.valueOf(new BigDecimal(String.valueOf(data[2])).intValue());
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("交易报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"交易笔数", "交易金额"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    switch (season) {
                        case 1:
                            xAxis.setData(x1);
                            break;
                        case 2:
                            xAxis.setData(x2);
                            break;
                        case 3:
                            xAxis.setData(x3);
                            break;
                        case 4:
                            xAxis.setData(x4);
                            break;
                        default:
                            break;
                    }
                    xAxis.setType("category");
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    series1.setName("交易笔数");
                    series1.setType("bar");
                    series1.setData(y);

                    ReportJson.Series series2 = json.new Series();
                    series2.setName("交易金额");
                    series2.setType("bar");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);
                }
                //选择某一年，月选择全部，X轴为12个月
                if (month == 0) {
                    List<Object[]> lists = tradingService.findByMonth(year);

                    String[] x = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
                    String[] xDig = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
                    String[] y = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};

                    for (int i = 0; i < 12; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(new BigDecimal(String.valueOf(data[1])).intValue());
                                y2[i] = String.valueOf(new BigDecimal(String.valueOf(data[2])).intValue());
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("交易报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"交易笔数", "交易金额"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    series1.setName("交易笔数");
                    series1.setType("bar");
                    series1.setData(y);

                    ReportJson.Series series2 = json.new Series();
                    series2.setName("交易金额");
                    series2.setType("bar");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);
                } else if (month > 0) {
                    //选择某一年，月选择某个月，X轴为当月的某几天
                    List<Object[]> lists = tradingService.findByMonthAndDay(year, month);

                    int dateOfMonth = CalendarUtil.getDaysByYearMonth(year, month);

                    String[] x = new String[dateOfMonth];
                    String[] y = new String[dateOfMonth];
                    String[] y2 = new String[dateOfMonth];
                    for (int i = 0; i < dateOfMonth; i++) {
                        x[i] = String.valueOf(i + 1);
                        y[i] = "0";
                        y2[i] = "0";
                    }

                    for (int i = 0; i < dateOfMonth; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y[i] = String.valueOf(new BigDecimal(String.valueOf(data[1])).intValue());
                                y2[i] = String.valueOf(new BigDecimal(String.valueOf(data[2])).intValue());
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("交易报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setShow("true");
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"交易笔数", "交易金额"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    xAxis.setType("category");
                    xAxis.setData(x);
                    xAxis.setBoundaryGap(true);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setName("");
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    series1.setName("交易笔数");
                    series1.setType("bar");
                    series1.setData(y);

                    ReportJson.Series series2 = json.new Series();
                    series2.setName("交易金额");
                    series2.setType("bar");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
            }

        }

        return json;
    }

    @RequestMapping(value = "/admin/tradingAnalysisReport", method = RequestMethod.GET)
    public String tradingAnalysisReport() {
        return TRADING_ANALYSYS_REPORT;
    }

    @RequestMapping(value = "/admin/tradingAnalysisReport/data", method = RequestMethod.GET)
    @ResponseBody
    public List<PieReportJson> tradingAnalysisReportData(@RequestParam(value = "startTime", required = false) String startTime, @RequestParam(value = "endTime", required = false) String endTime) {
        List<PieReportJson> jsonList = new ArrayList<PieReportJson>();
        PieReportJson json = new PieReportJson();

        List<Object[]> lists = tradingAnalysisService.findByFloor(startTime, endTime);

        PieReportJson.Title title = json.new Title();
        title.setText("销售额");
        json.setTitle(title);

        PieReportJson.Tooltip tooltip = json.new Tooltip();
        tooltip.setShow("true");
        tooltip.setTrigger("item");
        tooltip.setFormatter("{a} <br/>{b} : {c} ({d}%)");
        json.setTooltip(tooltip);

        PieReportJson.Series series1 = json.new Series();
        series1.setName("楼层占比");
        series1.setType("pie");
        series1.setRadius("55%");
        series1.setCenter(new String[]{"50%", "60%"});
        series1.setData(pieDataTransfer(lists));

        PieReportJson.Series[] seriesArray = new PieReportJson.Series[1];
        seriesArray[0] = series1;
        json.setSeries(seriesArray);

        jsonList.add(json);
        //Test 
        List<String> floorList = tradingAnalysisService.findByValidFloor();
        for (int i = 0; i < floorList.size(); i++) {
            String floor = floorList.get(i);

            PieReportJson json2 = new PieReportJson();

            title = json2.new Title();
            title.setText(floor + " 销售额");
            json2.setTitle(title);

            tooltip = json2.new Tooltip();
            tooltip.setShow("true");
            tooltip.setTrigger("item");
            tooltip.setFormatter("{a} <br/>{b} : {c} ({d}%)");
            json2.setTooltip(tooltip);

            series1 = json2.new Series();
            series1.setName("销售额占比");
            series1.setType("pie");
            series1.setRadius("55%");
            series1.setCenter(new String[]{"50%", "60%"});

            List<Object[]> dataList = tradingAnalysisService.findByFloorAndBrand(startTime, endTime, floor);
            series1.setData(pieDataTransfer(dataList));

            seriesArray = new PieReportJson.Series[1];
            seriesArray[0] = series1;
            json2.setSeries(seriesArray);

            jsonList.add(json2);
        }
        return jsonList;
    }

    @RequestMapping(value = "/admin/parkingCouponReport", method = RequestMethod.GET)
    public String parkingCouponReport() {
        return PARKING_COUPON_REPORT;
    }

    @RequestMapping(value = "/admin/parkingCouponReport/data", method = RequestMethod.GET)
    @ResponseBody
    public ReportJson parkingCouponReportDate(@RequestParam(value = "year", required = false) Integer year,
                                              @RequestParam(value = "season", required = false) Integer season,
                                              @RequestParam(value = "month", required = false) Integer month) {
//        Calendar today = Calendar.getInstance();
//        int y = getYear(today, year);
//        int m = getMonth(today, year);
//        return toReports(parkingCouponService.findByYearAndMonth(y, m));
        ReportJson json = new ReportJson();

        // 只选择年全部，X轴为每年
        if (year == 0 && season == -1 && month == -1) {

            List<Object[]> lists = parkingCouponService.findByYear();
            Integer len = lists.size();
            String[] x = new String[len];
            String[] y1 = new String[len];
            String[] y2 = new String[len];

            for (int i = 0; i < lists.size(); i++) {
                Object[] data = lists.get(i);
                x[i] = String.valueOf(data[0]);
                y1[i] = String.valueOf(data[1]);
                y2[i] = String.valueOf(data[2]);
            }

            ReportJson.Title title = json.new Title();
            title.setText("停车券报表");
            json.setTitle(title);

            ReportJson.Tooltip tooltip = json.new Tooltip();
            tooltip.setTrigger("axis");
            json.setTooltip(tooltip);

            ReportJson.Legend legend = json.new Legend();
            legend.setData(new String[]{"兑换", "使用"});
            json.setLegend(legend);

            ReportJson.XAxis xAxis = json.new XAxis();

            xAxis.setType("category");
            xAxis.setBoundaryGap(false);
            xAxis.setData(x);
            json.setxAxis(xAxis);

            ReportJson.YAxis yAxis = json.new YAxis();
            yAxis.setValue("value");
            json.setyAxis(yAxis);

            ReportJson.Series series1 = json.new Series();
            ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
            style1.setNormal("1");
            series1.setAreaStyle(style1);
            series1.setName("兑换");
            series1.setType("line");
            series1.setStack("总量");
            series1.setData(y1);

            ReportJson.Series series2 = json.new Series();
            ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
            style2.setNormal("1");
            series2.setAreaStyle(style2);
            series2.setName("使用");
            series2.setStack("总量");
            series2.setType("line");
            series2.setData(y2);

            ReportJson.Series[] seriesArray = new ReportJson.Series[2];
            seriesArray[0] = series1;
            seriesArray[1] = series2;
            json.setSeries(seriesArray);

        } else {
            // （季度和月不可以同时查询前端控制）
            // 选择某一年，季度选择全部，X轴为4个季度
            if (year > 0) {
                if (season == 0) {

                    List<Object[]> lists = parkingCouponService.findBySeason(year);

                    String[] x = {"第一季度", "第二季度", "第三季度", "第四季度"};
                    // String[] xDig = {"1", "2", "3", "4"};
                    String[] y1 = {"0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0"};
                    for (int i = 0; i < 4; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("停车券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (season > 0) {
                    // 选择某一年，季度选择某个季度，X轴为3个月
                    List<Object[]> lists = parkingCouponService.findBySeasonAndMonth(year, season);
                    String[] x1 = {"一月", "二月", "三月"};
                    String[] x2 = {"四月", "五月", "六月"};
                    String[] x3 = {"七月", "八月", "九月"};
                    String[] x4 = {"十月", "十一月", "十二月"};

					/*
					 * String[] x1Dig = {"1", "2", "3"}; String[] x2Dig = {"4",
					 * "5", "6"}; String[] x3Dig = {"7", "8", "9"}; String[]
					 * x4Dig = {"10", "11", "12"};
					 */
                    String[] y1 = {"0", "0", "0"};
                    String[] y2 = {"0", "0", "0"};

                    for (int i = 0; i < 3; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);

                            if (((season - 1) * 3 + i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }
                    ReportJson.Title title = json.new Title();
                    title.setText("停车券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    switch (season) {
                        case 1:
                            xAxis.setData(x1);
                            break;
                        case 2:
                            xAxis.setData(x2);
                            break;
                        case 3:
                            xAxis.setData(x3);
                            break;
                        case 4:
                            xAxis.setData(x4);
                            break;
                        default:
                            break;
                    }

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
                // 选择某一年，月选择全部，X轴为12个月
                if (month == 0) {
                    List<Object[]> lists = parkingCouponService.findByMonth(year);

                    String[] x = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
                    // String[] xDig = {"1", "2", "3", "4", "5", "6", "7", "8",
                    // "9", "10", "11", "12"};
                    String[] y1 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};

                    for (int i = 0; i < 12; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("停车券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"对换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("对换");
                    series1.setType("line");
                    series1.setStack("总量");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);
                    series2.setStack("总量");

                    ReportJson.Series[] seriesArray = new ReportJson.Series[3];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (month > 0) {
                    // 选择某一年，月选择某个月，X轴为当月的某几天
                    List<Object[]> lists = parkingCouponService.findByMonthAndDay(year, month);

                    int dateOfMonth = CalendarUtil.getDaysByYearMonth(year, month);

                    String[] x = new String[dateOfMonth];
                    String[] y1 = new String[dateOfMonth];
                    String[] y2 = new String[dateOfMonth];

                    for (int i = 0; i < dateOfMonth; i++) {
                        x[i] = String.valueOf(i + 1);
                        y1[i] = "0";
                        y2[i] = "0";
                    }

                    for (int i = 0; i < dateOfMonth; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("停车券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
            }

        }

        return json;
    }

    @RequestMapping(value = "/admin/giftCouponReport", method = RequestMethod.GET)
    public String giftCouponReport() {
        return GIFT_COUPON_COUPON_REPORT;
    }

    @RequestMapping(value = "/admin/giftCouponReport/data", method = RequestMethod.GET)
    @ResponseBody
    public ReportJson giftCouponReportDate(@RequestParam(value = "year", required = false) Integer year,
                                           @RequestParam(value = "season", required = false) Integer season,
                                           @RequestParam(value = "month", required = false) Integer month) {
//        Calendar today = Calendar.getInstance();
//        int y = getYear(today, year);
//        int m = getMonth(today, year);
//        return toReports(giftCouponService.findByYearAndMonth(y, m));
        ReportJson json = new ReportJson();

        // 只选择年全部，X轴为每年
        if (year == 0 && season == -1 && month == -1) {

            List<Object[]> lists = giftCouponService.findByYear();
            Integer len = lists.size();
            String[] x = new String[len];
            String[] y1 = new String[len];
            String[] y2 = new String[len];

            for (int i = 0; i < lists.size(); i++) {
                Object[] data = lists.get(i);
                x[i] = String.valueOf(data[0]);
                y1[i] = String.valueOf(data[1]);
                y2[i] = String.valueOf(data[2]);
            }

            ReportJson.Title title = json.new Title();
            title.setText("礼品券报表");
            json.setTitle(title);

            ReportJson.Tooltip tooltip = json.new Tooltip();
            tooltip.setTrigger("axis");
            json.setTooltip(tooltip);

            ReportJson.Legend legend = json.new Legend();
            legend.setData(new String[]{"兑换", "使用"});
            json.setLegend(legend);

            ReportJson.XAxis xAxis = json.new XAxis();

            xAxis.setType("category");
            xAxis.setBoundaryGap(false);
            xAxis.setData(x);
            json.setxAxis(xAxis);

            ReportJson.YAxis yAxis = json.new YAxis();
            yAxis.setValue("value");
            json.setyAxis(yAxis);

            ReportJson.Series series1 = json.new Series();
            ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
            style1.setNormal("1");
            series1.setAreaStyle(style1);
            series1.setName("兑换");
            series1.setType("line");
            series1.setStack("总量");
            series1.setData(y1);

            ReportJson.Series series2 = json.new Series();
            ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
            style2.setNormal("1");
            series2.setAreaStyle(style2);
            series2.setName("使用");
            series2.setStack("总量");
            series2.setType("line");
            series2.setData(y2);

            ReportJson.Series[] seriesArray = new ReportJson.Series[2];
            seriesArray[0] = series1;
            seriesArray[1] = series2;
            json.setSeries(seriesArray);

        } else {
            // （季度和月不可以同时查询前端控制）
            // 选择某一年，季度选择全部，X轴为4个季度
            if (year > 0) {
                if (season == 0) {

                    List<Object[]> lists = giftCouponService.findBySeason(year);

                    String[] x = {"第一季度", "第二季度", "第三季度", "第四季度"};
                    // String[] xDig = {"1", "2", "3", "4"};
                    String[] y1 = {"0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0"};
                    for (int i = 0; i < 4; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("礼品券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (season > 0) {
                    // 选择某一年，季度选择某个季度，X轴为3个月
                    List<Object[]> lists = giftCouponService.findBySeasonAndMonth(year, season);
                    String[] x1 = {"一月", "二月", "三月"};
                    String[] x2 = {"四月", "五月", "六月"};
                    String[] x3 = {"七月", "八月", "九月"};
                    String[] x4 = {"十月", "十一月", "十二月"};

					/*
					 * String[] x1Dig = {"1", "2", "3"}; String[] x2Dig = {"4",
					 * "5", "6"}; String[] x3Dig = {"7", "8", "9"}; String[]
					 * x4Dig = {"10", "11", "12"};
					 */
                    String[] y1 = {"0", "0", "0"};
                    String[] y2 = {"0", "0", "0"};

                    for (int i = 0; i < 3; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);

                            if (((season - 1) * 3 + i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }
                    ReportJson.Title title = json.new Title();
                    title.setText("礼品券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    switch (season) {
                        case 1:
                            xAxis.setData(x1);
                            break;
                        case 2:
                            xAxis.setData(x2);
                            break;
                        case 3:
                            xAxis.setData(x3);
                            break;
                        case 4:
                            xAxis.setData(x4);
                            break;
                        default:
                            break;
                    }

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
                // 选择某一年，月选择全部，X轴为12个月
                if (month == 0) {
                    List<Object[]> lists = giftCouponService.findByMonth(year);

                    String[] x = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
                    // String[] xDig = {"1", "2", "3", "4", "5", "6", "7", "8",
                    // "9", "10", "11", "12"};
                    String[] y1 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};

                    for (int i = 0; i < 12; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("礼品券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"对换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("对换");
                    series1.setType("line");
                    series1.setStack("总量");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);
                    series2.setStack("总量");

                    ReportJson.Series[] seriesArray = new ReportJson.Series[3];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (month > 0) {
                    // 选择某一年，月选择某个月，X轴为当月的某几天
                    List<Object[]> lists = giftCouponService.findByMonthAndDay(year, month);

                    int dateOfMonth = CalendarUtil.getDaysByYearMonth(year, month);

                    String[] x = new String[dateOfMonth];
                    String[] y1 = new String[dateOfMonth];
                    String[] y2 = new String[dateOfMonth];

                    for (int i = 0; i < dateOfMonth; i++) {
                        x[i] = String.valueOf(i + 1);
                        y1[i] = "0";
                        y2[i] = "0";
                    }

                    for (int i = 0; i < dateOfMonth; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("礼品券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
            }

        }

        return json;

    }

    @RequestMapping(value = "/admin/shopCouponReport", method = RequestMethod.GET)
    public String shopCouponReport() {
        return SHOP_COUPON_COUPON_REPORT;
    }

    @RequestMapping(value = "/admin/shopCouponReport/data", method = RequestMethod.GET)
    @ResponseBody
    public ReportJson shopCouponReportData(@RequestParam(value = "year", required = false) Integer year,
                                           @RequestParam(value = "season", required = false) Integer season,
                                           @RequestParam(value = "month", required = false) Integer month) {
//        Calendar today = Calendar.getInstance();
//        int y = getYear(today, year);
//        int m = getMonth(today, year);
//        return toReports(shopCouponService.findByYearAndMonth(y, m));
        ReportJson json = new ReportJson();

        // 只选择年全部，X轴为每年
        if (year == 0 && season == -1 && month == -1) {

            List<Object[]> lists = shopCouponService.findByYear();
            Integer len = lists.size();
            String[] x = new String[len];
            String[] y1 = new String[len];
            String[] y2 = new String[len];

            for (int i = 0; i < lists.size(); i++) {
                Object[] data = lists.get(i);
                x[i] = String.valueOf(data[0]);
                y1[i] = String.valueOf(data[1]);
                y2[i] = String.valueOf(data[2]);
            }

            ReportJson.Title title = json.new Title();
            title.setText("店铺卡券报表");
            json.setTitle(title);

            ReportJson.Tooltip tooltip = json.new Tooltip();
            tooltip.setTrigger("axis");
            json.setTooltip(tooltip);

            ReportJson.Legend legend = json.new Legend();
            legend.setData(new String[]{"兑换", "使用"});
            json.setLegend(legend);

            ReportJson.XAxis xAxis = json.new XAxis();

            xAxis.setType("category");
            xAxis.setBoundaryGap(false);
            xAxis.setData(x);
            json.setxAxis(xAxis);

            ReportJson.YAxis yAxis = json.new YAxis();
            yAxis.setValue("value");
            json.setyAxis(yAxis);

            ReportJson.Series series1 = json.new Series();
            ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
            style1.setNormal("1");
            series1.setAreaStyle(style1);
            series1.setName("兑换");
            series1.setType("line");
            series1.setStack("总量");
            series1.setData(y1);

            ReportJson.Series series2 = json.new Series();
            ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
            style2.setNormal("1");
            series2.setAreaStyle(style2);
            series2.setName("使用");
            series2.setStack("总量");
            series2.setType("line");
            series2.setData(y2);

            ReportJson.Series[] seriesArray = new ReportJson.Series[2];
            seriesArray[0] = series1;
            seriesArray[1] = series2;
            json.setSeries(seriesArray);

        } else {
            // （季度和月不可以同时查询前端控制）
            // 选择某一年，季度选择全部，X轴为4个季度
            if (year > 0) {
                if (season == 0) {

                    List<Object[]> lists = shopCouponService.findBySeason(year);

                    String[] x = {"第一季度", "第二季度", "第三季度", "第四季度"};
                    // String[] xDig = {"1", "2", "3", "4"};
                    String[] y1 = {"0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0"};
                    for (int i = 0; i < 4; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("店铺卡券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (season > 0) {
                    // 选择某一年，季度选择某个季度，X轴为3个月
                    List<Object[]> lists = shopCouponService.findBySeasonAndMonth(year, season);
                    String[] x1 = {"一月", "二月", "三月"};
                    String[] x2 = {"四月", "五月", "六月"};
                    String[] x3 = {"七月", "八月", "九月"};
                    String[] x4 = {"十月", "十一月", "十二月"};

					/*
					 * String[] x1Dig = {"1", "2", "3"}; String[] x2Dig = {"4",
					 * "5", "6"}; String[] x3Dig = {"7", "8", "9"}; String[]
					 * x4Dig = {"10", "11", "12"};
					 */
                    String[] y1 = {"0", "0", "0"};
                    String[] y2 = {"0", "0", "0"};

                    for (int i = 0; i < 3; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);

                            if (((season - 1) * 3 + i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }
                    ReportJson.Title title = json.new Title();
                    title.setText("店铺卡券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();
                    switch (season) {
                        case 1:
                            xAxis.setData(x1);
                            break;
                        case 2:
                            xAxis.setData(x2);
                            break;
                        case 3:
                            xAxis.setData(x3);
                            break;
                        case 4:
                            xAxis.setData(x4);
                            break;
                        default:
                            break;
                    }

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setStack("总量");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setStack("总量");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
                // 选择某一年，月选择全部，X轴为12个月
                if (month == 0) {
                    List<Object[]> lists = shopCouponService.findByMonth(year);

                    String[] x = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
                    // String[] xDig = {"1", "2", "3", "4", "5", "6", "7", "8",
                    // "9", "10", "11", "12"};
                    String[] y1 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                    String[] y2 = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};

                    for (int i = 0; i < 12; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[1]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("店铺卡券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"对换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("对换");
                    series1.setType("line");
                    series1.setStack("总量");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);
                    series2.setStack("总量");

                    ReportJson.Series[] seriesArray = new ReportJson.Series[3];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                } else if (month > 0) {
                    // 选择某一年，月选择某个月，X轴为当月的某几天
                    List<Object[]> lists = shopCouponService.findByMonthAndDay(year, month);

                    int dateOfMonth = CalendarUtil.getDaysByYearMonth(year, month);

                    String[] x = new String[dateOfMonth];
                    String[] y1 = new String[dateOfMonth];
                    String[] y2 = new String[dateOfMonth];

                    for (int i = 0; i < dateOfMonth; i++) {
                        x[i] = String.valueOf(i + 1);
                        y1[i] = "0";
                        y2[i] = "0";
                    }

                    for (int i = 0; i < dateOfMonth; i++) {
                        Object[] data = null;
                        for (int j = 0; j < lists.size(); j++) {
                            data = lists.get(j);
                            if ((i + 1) == (Integer) data[0]) {
                                y1[i] = String.valueOf(data[1]);
                                y2[i] = String.valueOf(data[2]);
                                break;
                            }
                        }
                    }

                    ReportJson.Title title = json.new Title();
                    title.setText("店铺卡券报表");
                    json.setTitle(title);

                    ReportJson.Tooltip tooltip = json.new Tooltip();
                    tooltip.setTrigger("axis");
                    json.setTooltip(tooltip);

                    ReportJson.Legend legend = json.new Legend();
                    legend.setData(new String[]{"兑换", "使用"});
                    json.setLegend(legend);

                    ReportJson.XAxis xAxis = json.new XAxis();

                    xAxis.setType("category");
                    xAxis.setBoundaryGap(false);
                    xAxis.setData(x);
                    json.setxAxis(xAxis);

                    ReportJson.YAxis yAxis = json.new YAxis();
                    yAxis.setValue("value");
                    json.setyAxis(yAxis);

                    ReportJson.Series series1 = json.new Series();
                    ReportJson.Series.AreaStyle style1 = json.new Series().new AreaStyle();
                    style1.setNormal("1");
                    series1.setAreaStyle(style1);
                    series1.setName("兑换");
                    series1.setType("line");
                    series1.setData(y1);

                    ReportJson.Series series2 = json.new Series();
                    ReportJson.Series.AreaStyle style2 = json.new Series().new AreaStyle();
                    style2.setNormal("1");
                    series2.setAreaStyle(style2);
                    series2.setName("使用");
                    series2.setType("line");
                    series2.setData(y2);

                    ReportJson.Series[] seriesArray = new ReportJson.Series[2];
                    seriesArray[0] = series1;
                    seriesArray[1] = series2;
                    json.setSeries(seriesArray);

                }
            }

        }

        return json;
    }

    @RequestMapping(value = "/admin/stockIntegralReport", method = RequestMethod.GET)
    public String stockIntegralReport() {
        return STOCK_INTEGRAL_REPORT;
    }

    @RequestMapping(value = "/admin/stockIntegralReport/data", method = RequestMethod.GET)
    @ResponseBody
    public PieReportJson stockIntegralReportData() {
        PieReportJson json = new PieReportJson();
        PieReportJson.Title title = json.new Title();
        title.setText("存量积分分布图");
        title.setSubtext("总人数:" + stockIntegralService.findTotal());
        title.setX("center");
        json.setTitle(title);

        ReportJson.Tooltip tooltip = json.new Tooltip();
        tooltip.setTrigger("item");
        tooltip.setFormatter("{a} <br/>{b} : {c} ({d}%)");
        json.setTooltip(tooltip);


        PieReportJson.Series series = json.new Series();
        series.setName("积分占比");
        series.setType("pie");
        series.setRadius("55%");
        series.setCenter(new String[]{"50%", "60%"});

        PieReportJson.PieData pieData = json.new PieData();
        pieData.setName("小于500积分");
        pieData.setValue(stockIntegralService.findBy500());

        PieReportJson.PieData pieData1 = json.new PieData();
        pieData1.setName("500~1000积分");
        pieData1.setValue(stockIntegralService.findBy1000());

        PieReportJson.PieData pieData2 = json.new PieData();
        pieData2.setName("1000~1400积分");
        pieData2.setValue(stockIntegralService.findBy1400());

        PieReportJson.PieData pieData3 = json.new PieData();
        pieData3.setName("1400~1800积分");
        pieData3.setValue(stockIntegralService.findBy1800());

        PieReportJson.PieData pieData4 = json.new PieData();
        pieData4.setName("大于1800积分");
        pieData4.setValue(stockIntegralService.findByOther());
        PieReportJson.PieData[] pieDatas = new PieReportJson.PieData[5];
        pieDatas[0] = pieData;
        pieDatas[1] = pieData1;
        pieDatas[2] = pieData2;
        pieDatas[3] = pieData3;
        pieDatas[4] = pieData4;
        series.setData(pieDatas);
        PieReportJson.Series[] seriesArray = new PieReportJson.Series[1];
        seriesArray[0] = series;
        json.setSeries(seriesArray);
        return json;
    }

    private List<MonthCouponReport> toReports(List<Object[]> lists) {
        return lists.stream().map(i -> {
            MonthCouponReport r = new MonthCouponReport();
            int month = (int) i[0];
            Long exchange = (Long) i[1];
            Long use = (Long) i[2];
            String time = (String) i[3];
            r.setDate(month + "");
            r.setExchangeNumber(exchange.intValue());
            r.setUseNumber(use.intValue());
            r.setTime(time);
            return r;
        }).collect(Collectors.toList());
    }

    public int getYear(Calendar today, Integer year) {
        int currentYear = today.get(Calendar.YEAR);
        if (year == null) {
            return currentYear;
        } else {
            return year;
        }
    }

    public int getMonth(Calendar today, Integer year) {
        int currentYear = today.get(Calendar.YEAR);
        if (year != null && year < currentYear) {
            return 12;
        } else {
            return today.get(Calendar.MONTH) + 1;
        }
    }

    public class MonthTradingReportWithMax {
        private List<MonthTradingReport> lists;
        private long max;

        public List<MonthTradingReport> getLists() {
            return lists;
        }

        public void setLists(List<MonthTradingReport> lists) {
            this.lists = lists;
        }

        public long getMax() {
            return max;
        }

        public void setMax(long max) {
            this.max = max;
        }
    }

    public class MonthTradingReport {
        private String month;
        private double amount;
        private int number;
        private String time;

        public MonthTradingReport(String month, double amount, int number, String time) {
            this.month = month;
            this.amount = amount;
            this.number = number;
            this.time = time;
        }

        public String getMonth() {
            return month;
        }

        public void setMonth(String month) {
            this.month = month;
        }

        public double getAmount() {
            return amount;
        }

        public void setAmount(int amount) {
            this.amount = amount;
        }

        public void setAmount(double amount) {
            this.amount = amount;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }
    }

    public class MonthMemberReport {
        private String key;
        private int value;
        private String time;

        public MonthMemberReport(String k, int v, String time) {
            this.key = k;
            this.value = v;
            this.time = time;
        }

        public String getKey() {
            return key;
        }

        public void setKey(String key) {
            this.key = key;
        }

        public int getValue() {
            return value;
        }

        public void setValue(int value) {
            this.value = value;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }
    }

    public class MonthCouponReport {
        private String date;
        private int exchangeNumber;
        private int useNumber;
        private String time;

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public int getExchangeNumber() {
            return exchangeNumber;
        }

        public void setExchangeNumber(int exchangeNumber) {
            this.exchangeNumber = exchangeNumber;
        }

        public int getUseNumber() {
            return useNumber;
        }

        public void setUseNumber(int useNumber) {
            this.useNumber = useNumber;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }
    }

    private PieReportJson.PieData[] pieDataTransfer(List<Object[]> list) {
        PieReportJson.PieData[] pieData = new PieReportJson.PieData[list.size()];
        for (int i = 0; i < list.size(); i++) {
            Object[] data = list.get(i);
            PieReportJson.PieData pd = new PieReportJson().new PieData();
            pd.setName(String.valueOf(data[0]));
            pd.setValue(String.valueOf(Math.round((double)data[1])));
            pieData[i] = pd;
        }
        return pieData;
    }

    @RequestMapping(value = "/admin/memberExcelReport", method = RequestMethod.GET)
    public void exportBrandSort(HttpServletRequest request,
                                HttpServletResponse response) throws Exception {
        LicenseJson json = new LicenseJson();
        json.setId(1L);
        json.setLicenseName("苏E00001");

        LicenseJson json2 = new LicenseJson();
        json2.setId(2L);
        json2.setLicenseName("苏E00002");

        LicenseJson json3 = new LicenseJson();
        json3.setId(3L);
        json3.setLicenseName("苏E00003");

        List<LicenseJson> licenseList = new ArrayList<LicenseJson>();
        licenseList.add(json);
        licenseList.add(json2);
        licenseList.add(json3);

        ExportUtil<LicenseJson> ex = new ExportUtil<LicenseJson>();
        String[] headers = { "编号", "车牌"};
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        ex.exportExcel(headers, licenseList, out);

        byte[] bytes = out.toByteArray();
        response.setContentType("application/x-msdownload");
        response.setContentLength(bytes.length);
        response.setHeader("Content-Disposition", "attachment;filename="
                + java.net.URLEncoder.encode("档期列表.xls", "UTF-8"));
        response.getOutputStream().write(bytes);

        out.close();
    }
}
