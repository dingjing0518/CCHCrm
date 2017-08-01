package com.by.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CalendarUtil {
	public static String getToday() {
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.YEAR) + "-" + c.get(Calendar.DAY_OF_YEAR);
	}
	public static Calendar stringToCalendar(String format,String string){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		try {
			Date date = sdf.parse(string);
			calendar.setTime(date);
			return calendar;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}
