package com.by.utils;

import org.apache.log4j.Logger;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

public class DateUtil {
	private static Logger log = Logger.getLogger(DateUtil.class);
    public static final String DATEFORMAT = "yyyy-MM-dd";
    public static final String DATEFORMAT_YYYYMMDD="yyyyMMdd";
    public static final String DATEFORMAT_YYYYMM="yyyyMM";
    public static final String DATEFORMAT_DDMMYYYY="ddMMyyyy";
    public static final String DATEFORMAT_DDMMYY="ddMMyy";
    private static final String timezone = "Asia/Singapore";
    public static final String TIMESTAMPFORMAT = "dd/MM/yyyy HH:mm:ss.SSS";
    public static final String TIMESTAMP12HRFORMAT = "dd/MM/yyyy hh:mm:ss aa"; 
    public static final String Time12HrFormat = "hh:mm aa";
    public static final String Time24HrFormat = "HH:mm";
    public static final String TIME_HHMMSS = "hhmmss";
    public static final String TIME_HHMMSS_24HR = "HHmmss";
    public static final String DATEFORMAT_DB = "yyyy-MM-dd";
    public static final String DATEFORMAT_YM = "yyyy-MM";
    public static final String TIMESTAMPFORMAT_DB = "yyyy-MM-dd-HH.mm.ss.SSS";
    public static final String TIME_HHMM_24HR = "HHmm";// 15:23 -> 1523
    public static final String LETTER_TIMESTAMP_12HR_FORMAT = "dd/MM/yyyy hh:mm aa";
    public static final String REFUND_DATEFORMAT_PDF = "dd.MM.yy";
    public static final String DATE_TIME_FORMAT = "yyyy-MM-dd hh:mm:ss";
    public static final String DATE_TIME_24HR_FORMAT = "yyyy-MM-dd HH:mm:ss";
    
    /** The date pattern in this format 'ddMMyyyy  HHmm' */
    public static final String DATETIME_FORMAT = "ddMMyyyy  HHmm";
    public static final String DISPLAY_TIMESTAMP_12HR_FORMAT = "dd MMM yyyy hh:mm:ss aa";
    public static final String DISPLAY_DATE_FORMAT = "dd MMM yyyy";
    public static final String TIMESTAMP_INTERFACE_FORMAT = "yyyyMMddhhmmss";
    public static final String TIMESTAMP_INTERFACE_24HR_FORMAT = "yyyyMMddHHmm";
    public static final String DISPLAY_ALL_DATE_FORMAT = "dd MMMM yyyy";

//	 Dates constants

    /** "JAN" to represent January */
    public static final String MTH_JAN = "Jan";

    /** "FEB" to represent February */
    public static final String MTH_FEB = "Feb";

    /** "MAR" to represent March */
    public static final String MTH_MAR = "Mar";

    /** "APR" to represent April */
    public static final String MTH_APR = "Apr";

    /** "MAY" to represent May */
    public static final String MTH_MAY = "May";

    /** "JUNE" to represent June */
    public static final String MTH_JUN = "Jun";

    /** "JUL" to represent July */
    public static final String MTH_JUL = "Jul";

    /** "AUG" to represent August */
    public static final String MTH_AUG = "Aug";

    /** "SEP" to represent September */
    public static final String MTH_SEP = "Sep";

    /** "OCT" to represent October */
    public static final String MTH_OCT = "Oct";

    /** "NOV" to represent November */
    public static final String MTH_NOV = "Nov";

    /** "DEC" to represent December */
    public static final String MTH_DEC = "Dec";
    
   

    /**
     * Returns a date object from input string indicating year, month and day
     *
     * @param year Year Indicator
     * @param month Month indicator, 1=jan 2=feb ...
     * @param day Date indicator eg: any day from 1...31.
     *
     * @return date java.util.Date object in millisecond.
     *
     * @since 23/02/2010
     */
    public static Date getDate(int year, int month, int day)
    {
    	Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, day, 0, 0, 0);
        return cal.getTime();
    }

    /**
     * Compares the 2 dates: Returns true if the 2 dates are equal.
     *
     * @param date1 Date to compare
     * @param date2 Date to compare
     *
     * @return true if <code>date1</code> equals to <code>date2</code>.
     *
     * @since 23/02/2010
     */
    public static boolean isDateEqual(Date date1, Date date2)
    {
    	if ((date1 == null) || (date2 == null))
        {
            return false;
        }

        return resetTime(date1).compareTo(resetTime(date2)) == 0;
    }

    /**
     * This method will determine if the date is the last day of the month
     *
     * @param date date
     *
     * @return returns true if the date falls on the last day of the month else
     *         returns false
     */
    public static final boolean isEndOfTheMonth(Date date)
    {
    	Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        if (cal.get(Calendar.DATE) == maxDay)
        {
            return true;
        }

        return false;
    }

    /**
     * This method will determine if the date is the last day of the year
     *
     * @param date date
     *
     * @return returns true if the date falls on the last day of the year else
     *         returns false
     */
    public static final boolean isEndOfTheYear(Date date)
    {
    	Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        if ((cal.get(Calendar.MONTH) == 11) && (cal.get(Calendar.DATE) == 31))
        {
            return true;
        }

        return false;
    }

    /**
     * This method will return the last day of the months
     *
     * @param date date
     *
     * @return returns the last day of the month
     */
    public static final int getLastDayOfTheMonth(Date date)
    {
    	Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
    }
    
    /**
     * This method will return the last day of the months
     *
     * @param date date
     *
     * @return returns the last day of the month
     */
    public static final Date getLastDateOfTheMonth(Date date)
    {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.MONTH, 1);
    	cal.set(Calendar.DAY_OF_MONTH, 1);
    	cal.add(Calendar.DAY_OF_MONTH, -1);    	
    	return cal.getTime();
    }
    
    
    /**
     * This method will return the first day of the month
     * @param date
     * @return
     */
    public static final Date getFirstDateOfTheMonth(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.set(Calendar.DAY_OF_MONTH, 1);
    	return cal.getTime();
    }

    /**
     * Compares the 2 dates: Returns true if the start date is before the end
     * date.
     *
     * @param startDate Starting date of a particular time period.
     * @param endDate Ending date of a particular time period.
     *
     * @return true if the <code>startDate</code> is before
     *         <code>endDate</code>.
     *
     * @since 23/02/2010
     */
    public static boolean isStartBeforeEndDate(Date startDate, Date endDate)
    {
    	if ((startDate == null) || (endDate == null))
        {
            return false;
        }

        return resetTime(startDate).compareTo(resetTime(endDate)) < 0;
    }

    /**
     * This method will determine if the date occurs on the beginning of the
     * month
     *
     * @param date date
     *
     * @return returns true if date is on the beginning of the month else
     *         returns false
     */
    public static final boolean isStartOfTheMonth(Date date)
    {
    	Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        if (cal.get(Calendar.DATE) == 1)
        {
            return true;
        }

        return false;
    }

    /**
	* This method will return
	* month
	*
	* @param date date
	*
	* @return returns month in int
	*
	*/
    public static final int getMonth(Date date)
    {
    	Calendar cal = Calendar.getInstance();
	    cal.setTime(date);

	    return cal.get(Calendar.MONTH) ;
    }

    /**
	* This method will return
	* year
	*
	* @param date date
	*
	* @return returns year in int
	*
	*/
    public static final int getYear(Date date)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.YEAR) ;
    }

    /**
	* This method will return
	* day
	*
	* @param date date
	*
	* @return returns day in int
	*
	*/
    public static final int getDay(Date date)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.DAY_OF_MONTH) ;
    }

    /**
	* This method will return
	* hour
	*
	* @param date date
	*
	* @return returns hour in int
	*
	*/
    public static final int getHour(Date date)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.HOUR) ;
    }
    
    /**
	* This method will return
	* MINUTE
	*
	* @param date date
	*
	* @return returns MINUTE in int
	*
	*/
    public static final int getMinute(Date date)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.MINUTE) ;
    }
    
    /**
	* This method will return
	* AMPM
	*
	* @param date date
	*
	* @return returns AMPM in int
	*
	*/
    public static final int getAMPM(Date date)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.AM_PM) ;
    }
    
    /**
	 * This method will return the day of week.
	 * @param date
	 * @return
	 */
	public static final int getDayOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.DAY_OF_WEEK);
	}

    /**
     * This method will determine if the date occurs at the beginning of the
     * year
     *
     * @param date date
     *
     * @return returns true if the date occurs on the beginning of the year
     *         else returns false
     */
    public static final boolean isStartOfTheYear(Date date)
    {
    	Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        if ((cal.get(Calendar.MONTH) == 1) && (cal.get(Calendar.DATE) == 1))
        {
            return true;
        }

        return false;
    }

    /**
     * Returns the corresponding 3 letter string value of the month specified by numeric month value
     *
     * @param month The numeric value of the specified month
     *
     * @return the corresponding 3 letter string value of the month specified by numeric month value
     */
    public static String getStrMth(int month)
    {
    	if (month == 1)
        {
            return MTH_JAN;
        }
        else if (month == 2)
        {
            return MTH_FEB;
        }
        else if (month == 3)
        {
            return MTH_MAR;
        }
        else if (month == 4)
        {
            return MTH_APR;
        }
        else if (month == 5)
        {
            return MTH_MAY;
        }
        else if (month == 6)
        {
            return MTH_JUN;
        }
        else if (month == 7)
        {
            return MTH_JUL;
        }
        else if (month == 8)
        {
            return MTH_AUG;
        }
        else if (month == 9)
        {
            return MTH_SEP;
        }
        else if (month == 10)
        {
            return MTH_OCT;
        }
        else if (month == 11)
        {
            return MTH_NOV;
        }
        else if (month == 12)
        {
            return MTH_DEC;
        }
        else
        {
            return "";
        }
    	
    }

    /**
     * Returns the current SQL date.
     *
     * @return Date
     */
    public static java.sql.Date getSystemDate()
    {
    	Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        java.sql.Date sysDate = new java.sql.Date(cal.getTime().getTime());

        return sysDate;

    }

    /**
     * Returns the current timestamp.
     *
     * @return Timestamp
     */
    public static Timestamp getSystemTimestamp()
    {
    	return new Timestamp(System.currentTimeMillis());

    }

    /**
     * This method convert the date to string
     *
     * @param date date
     * @param strFormat the string format
     *
     * @return date as string format
     */
    public static String getDate(Date date, String strFormat)
    {
    	return DateUtil.parseDate(date, strFormat);

    }

    /**
     * Returns true if the String is a valid date.
     *
     * @param strDate The date in format ddmmyyyy.
     *
     * @return True, if it is a valid date. False, otherwise.
     */
    public static boolean isValidDate(String strDate)
    {
    	return DateUtil.toDate(strDate, "ddMMyyyy") != null;

    }

    /**
	 * Returns true if the String is a valid date by specifying the date format to be verified.
	 *
	 * @param strDate The date.
	 * @param dateStrFormat The date format of the specified strDate
	 *
	 * @return True, if it is a valid date. False, otherwise.
	 */
    public static boolean isValidDate(String strDate, String dateStrFormat)
    {
    	return DateUtil.toDate(strDate, dateStrFormat) != null;

    }

    /**
	 * Add year, month or day to a date
	 * To subtract the specified number of Days to the specified Date object, juz use a negative number
     * Example: DateUtil.addDaysToDate(date, -5) ==  subtracting 5 days from the specified date.
     * The same applies to month and year.
     *
	 * @param type (int).  Indicates the input num value is in year, month, or
	 *        days. Valid values are Calendar.YEAR, Calendar.MONTH,
	 *        Calendar.DATE
	 * @param date (java.sql.Date).
	 * @param num (int).  The value to be added to the input date.
	 *
	 * @return java.sql.Date.
	 */
    public static final Date addDate(int type, Date date, int num)
    {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		cal.add(type, num);

		return new Date(cal.getTime().getTime());

    }

    /**
     * Adds the specified number of Days to the specified Date object
     * To subtract the specified number of Days to the specified Date object, juz use a negative number
     * Example: DateUtil.addDaysToDate(date, -5) ==  subtracting 5 days from the specified date.
     *
     * @param date Date to be add
     * @param numDays Number of days to add
     *
     * @return date  Added Date
     */
    public static Date addDaysToDate(Date date, int numDays)
    {
    	if (date == null)
        {
            return null;
        }

        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DATE, numDays);

        return c.getTime();

    }
    
    /**
     * Adds the specified number of Hours to the specified Date object
     * To subtract the specified number of Hours to the specified Timestamp object, juz use a negative number
     *
     * @param date Timestamp to be add
     * @param hours Number of hours to add
     *
     * @return Timestamp  Added Timestamp
     */
    
    public static Timestamp addHoursToTimestamp(Timestamp timestamp, int hours)
    {
    	if (timestamp == null)
        {
            return null;
        }

        Calendar c = Calendar.getInstance();
        c.setTime(timestamp);
        c.add(Calendar.HOUR, hours);

        return new Timestamp(c.getTimeInMillis());
        
    }
    
    /**
     * Adds the specified number of Days to the specified Date object
     * To subtract the specified number of Days to the specified Date object, juz use a negative number
     * Example: DateUtil.addDaysToDate(date, -5) ==  subtracting 5 days from the specified date.
     *
     * @param date Timestamp to be add
     * @param numDays Number of days to add
     *
     * @return date  Added Date
     */
    
    public static Timestamp addDaysToTimestamp(Timestamp timestamp, int numDays)
    {
    	if (timestamp == null)
        {
            return null;
        }

        Calendar c = Calendar.getInstance();
        c.setTime(timestamp);
        c.add(Calendar.DATE, numDays);

        return new Timestamp(c.getTimeInMillis());
        
    }

    /**
	 * Adds the specified number of Months to the specified Date object
	 *
	 * @param date Date to be add
	 * @param numMonths Number of months to add
	 *
	 * @return date  Added Date
	 */
    public static Date addMonthsToDate(Date date, int numMonths)
    {
    	if (date == null)
		{
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, numMonths);
		return c.getTime();

    }
    
    /**
	 * Adds the specified number of Months to the specified Time object
	 *
	 * @param date Date to be add
	 * @param numMonths Number of months to add
	 *
	 * @return date  Added Date
	 */
    public static Timestamp addMonthsToTime(Timestamp timestamp, int numMonths)
    {
    	if (timestamp == null)
		{
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(timestamp);
		c.add(Calendar.MONTH, numMonths);
		
		return new Timestamp(c.getTimeInMillis());

    }

    /**
	 * Adds the specified number of Years to the specified Date object
	 *
	 * @param date Date to be add
	 * @param numYears Number of years to add
	 *
	 * @return date  Added Date
	 */
    public static Date addYearsToDate(Date date, int numYears)
    {
    	if (date == null)
		{
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.YEAR, numYears);
		return c.getTime();

    }
    
    /**
	 * Adds the specified number of Years to the specified Time object
	 *
	 * @param date Date to be add
	 * @param numYears Number of years to add
	 *
	 * @return date  Added Date
	 */
    public static Timestamp addYearsToTime(Timestamp timestamp, int numYears)
    {
    	if (timestamp == null)
		{
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(timestamp);
		c.add(Calendar.YEAR, numYears);
		
		return new Timestamp(c.getTimeInMillis());

    }

    /**
     * The method will compares 2 dates (excluding the HH MM SS)
     *
     * @param date1 1st date parameter
     * @param date2 2nd date parameter
     *
     * @return returns -1 if 1st date parameter is earlier than 2nd date
     *         parameter retuns 0 if both dates parameter is the same day
     *         retuns 1 if 1st date parameter is later than 2nd date parameter
     */
    public static int compareDates(Date date1, Date date2)
    {
    	if ((date1 == null) && (date2 == null))
        {
            return 0;
        }

        if (date1 == null)
        {
            return -1;
        }

        if (date2 == null)
        {
            return 1;
        }

        String strFormat = "yyyyMMdd";
        SimpleDateFormat dateFormat = new SimpleDateFormat(strFormat);

        int intDate1 = Integer.parseInt(dateFormat.format(date1));
        int intDate2 = Integer.parseInt(dateFormat.format(date2));

        if (intDate1 == intDate2)
        {
            return 0;
        }

        if (intDate1 > intDate2)
        {
            return 1;
        }

        return -1;

    }

    /**
     * The method is used to compare datetime (including the HH MM SS)
     *
     * @param date1 1st datetime parameter
     * @param date2 2nd datetime parameter
     *
     * @return returns -1 if 1st parameter is earlier than 2nd parameter 
	 * 			retuns 0 if both parameters are on the same day and same time
     *         retuns 1 if 1st parameter is later than 2nd parameter
     */   
    public static int compareDateTime(Date date1, Date date2)
    {
    	if ((date1 == null) && (date2 == null))
        {
            return 0;
        }

        if (date1 == null)
        {
            return -1;
        }

        if (date2 == null)
        {
            return 1;
        }

        long intDate1 = date1.getTime();
        long intDate2 = date2.getTime();

        if (intDate1 == intDate2)
        {
            return 0;
        }

        if (intDate1 > intDate2)
        {
            return 1;
        }

        return -1;

    }
    /**
     * Parses Date object to formatted string
     *
     * @param date date to be converted
     * @param formatStr Date/Time pattern. Example: ddMMyyyy or HHmmss or any
     *        other patterns
     *
     * @return String in required format  Format  : dd = Day MM = Month yyyy =
     *         Year HH = Hour mm = Minute ss = Second All format same as
     *         SimpleDateFormat. Null is returned if the date object is null.
     *
     * @since 23/02/2010
     */
    public static String parseDate(Date date, String formatStr)
    {
    	SimpleDateFormat dateFormat = new SimpleDateFormat(formatStr);

        if (date == null)
        {
            return null;
        }
        else
        {
            return dateFormat.format(date);
        }

    }

    /**
     * Parses Date object to date-time formatted string
     *
     * @param date THe date to be converted
     *
     * @return String in required format. Null is returned if the date object
     *         is null. (All format same as SimpleDateFormat)
     *
     * @since 23/02/2010
     */
    public static String parseDate(Date date)
    {
    	return parseDate(date, DATETIME_FORMAT);
    }

    /**
     * Converts the specified date-time string to Date object based on the
     * specified date-time format. <CODE>null</CODE> is returned if the
     * specified date is invalid.
     *
     * @param strDateTime The date string in this format 'ddMMyyyy  HHmm'.
     * @param dateTimeFormat The date pattern in this format 'ddMMyyyy  HHmm'
     *
     * @return the Date representation.  Returns null if the date object or the
     *         strDateTime or the dateTimeFormat is null.
     */
    public static Date toDate(String strDateTime, String dateTimeFormat)
    {
    	if ((strDateTime == null) || (strDateTime.length() == 0) ||
                (dateTimeFormat == null) || (dateTimeFormat.length() == 0))
        {
            return null;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat(dateTimeFormat);
        Date date = dateFormat.parse(strDateTime, new ParsePosition(0));

        if (date == null)
        {
            return null;
        }

        String dateStr = parseDate(date, dateTimeFormat);

        if (!strDateTime.equals(dateStr))
        {
            return null;
        }

        return date;

    }

    /**
     * Converts the specified date-time string to Date object based on the
     * specified date-time format. <CODE>null</CODE> is returned if the
     * specified date is invalid.
     *
     * @param strDateTime The date string in this format 'ddMMyyyy  HHmm'.
     *
     * @return the Date representation.  Returns null if the date object or the
     *         strDateTime or the dateTimeFormat is null.
     */
    public static Date toDate(String strDateTime)
    {
    	return toDate(strDateTime, DATETIME_FORMAT);

    }

    /**
     * Converts the specified date-time string to SQL Date object based on the
     * specified date-time format. <CODE>null</CODE> is returned if the
     * specified date is invalid.
     *
     * @param strDateTime The date string in this format 'ddMMyyyy  HHmm'.
     * @param dateTimeFormat The date pattern in this format 'ddMMyyyy  HHmm'
     *
     * @return the SQL Date representation.  Returns null if the date object or
     *         the strDateTime or the dateTimeFormat is null.
     */
    public static java.sql.Date toSQLDate(String strDateTime,
        String dateTimeFormat)
    {
    	Date date = toDate(strDateTime, dateTimeFormat);

        if (date == null)
        {
            return null;
        }

        return new java.sql.Date(date.getTime());

    }

    /**
     * Converts the Date object to SQL Date object.
     *
     * @param date The date to be converted.
     *
     * @return the SQL Date representation.
     */
    public static java.sql.Date toSQLDate(Date date)
    {
    	if (date == null)
        {
            return null;
        }

        return new java.sql.Date(date.getTime());

    }

    /**
     * Converts the specified date-time string to SQL Date object based on the
     * specified date-time format. <CODE>null</CODE> is returned if the
     * specified date is invalid.
     *
     * @param strDateTime The date string in this format 'ddMMyyyy  HHmm'.
     *
     * @return the SQL Date representation.  Returns null if the date object or
     *         the strDateTime or the dateTimeFormat is null.
     */
    public static java.sql.Date toSQLDate(String strDateTime)
    {
    	return toSQLDate(strDateTime, DATETIME_FORMAT);

    }

    /**
     * Converts the specified date-time string to Timestamp.
     *
     * @param dateTimeStr The String object in this ddMMyyyy  HHmm format
     *
     * @return Timestamp object. Returns null if dateTimeStr is null Format
     *         used is meant for Oracle dbs only
     */
    public static Timestamp toTimestamp(String dateTimeStr)
    {
    	return toTimestamp(toDate(dateTimeStr));

    }
    
    /**
     * Converts the specified date-time string to Timestamp.
     *
     * @param dateTimeStr The String object in this ddMMyyyy  HHmm format
     * @param dateTimeFormat The date pattern in this format 'ddMMyyyy  HHmm'
     *
     * @return Timestamp object. Returns null if dateTimeStr is null Format
     *         used is meant for Oracle dbs only
     */
    public static Timestamp toTimestamp(String dateTimeStr,
        String dateTimeFormat)
    {
    	return toTimestamp(toDate(dateTimeStr, dateTimeFormat));

    }

    /**
     * Converts the specified Calendar to Timestamp.
     *
     * @param date The Date object.
     *
     * @return Timestamp object.  Returns null if date object is null Format
     *         used is meant for Oracle dbs only
     */
    public static Timestamp toTimestamp(Date date)
    {
    	if (date == null)
        {
            return null;
        }

        return new Timestamp(date.getTime());

    }

    /**
	 * Converts the specified Calendar to Timestamp.
	 *
	 * @param timeStamp The TimeStamp object.
	 *
	 * @return Date object.  Returns null if timestamp object is null Format
	 *         used is meant for Oracle dbs only
	 */
    public static Date toDate(Timestamp timeStamp)
    {
    	if (timeStamp == null)
		{
			return null;
		}

		return new Date(timeStamp.getTime());

    }

    /**
	 * Author : Lee
	 * Convert the date string to the input format
	 *
	 * @param dateIn 		  date (String) that need to do conversion
	 * @param formatIn        format of the input date (String)
	 * @param formatOut       format of the out date (String)
	 * @return date (String)    converted date in String
	 */
    public static String dateConverter(String dateIn, String formatIn, String formatOut) {
    	
    	try{ 
			if( "now" .equals( dateIn )) 
			{
				return (new SimpleDateFormat(formatOut).format(new Date()));
			}
			else
			{
				return (new SimpleDateFormat(formatOut)).format(
						(new SimpleDateFormat(formatIn)).parse(
								dateIn, new ParsePosition(0)));
			}
		}
		catch(Exception e){
			return "";
		}

    }
    
    
    
    /**
     * Resets time fields of date to 00:00
     *
     * @param date Date to be reset the time to zero
     *
     * @return date  Converted Date
     */
    public static Date resetTime(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        return cal.getTime();
    }
    
    
    /**
     * get start time fields of date to 
     *
     * @param date Date to be reset the time start of day
     *
     * @return Timestamp  Converted Date
     */
    public static Timestamp getDateEnd(Date date)
    {
    	Calendar cal = getDateEndCalendar(date);
        return  new Timestamp(cal.getTimeInMillis());
    }

    public static Calendar getDateEndCalendar(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        return cal;
    }
    /**
     * get end time fields of date to
     *
     * @param date Date to be reset the time end of day
     *
     * @return Timestamp  Converted Date
     */
    public static Timestamp getDateStart(Date date)
    {
    	Calendar cal = getDateStartCalendar(date);
        return  new Timestamp(cal.getTimeInMillis());
    }

    public static Calendar getDateStartCalendar(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return  cal;
    }

    /**
     * Gets an integer string representation of the specified month.
     *
     * @param mthMMM Month of three letter string.  For example, "JAN",
     *        "FEB",..
     *
     * @return a string number equivalent of the specified month string.  If
     *         the specified month is unknown, zero string is returned that is
     *         "00".
     *
     * @since 27/03/2000
     */
    public static String toMMFormat(String mthMMM)
    {
        if (mthMMM.equalsIgnoreCase(MTH_JAN))
        {
            return "01";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_FEB))
        {
            return "02";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_MAR))
        {
            return "03";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_APR))
        {
            return "04";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_MAY))
        {
            return "05";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_JUN))
        {
            return "06";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_JUL))
        {
            return "07";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_AUG))
        {
            return "08";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_SEP))
        {
            return "09";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_OCT))
        {
            return "10";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_NOV))
        {
            return "11";
        }
        else if (mthMMM.equalsIgnoreCase(MTH_DEC))
        {
            return "12";
        }

        return null;
    }

    /**
     * Gets a specified month string as JAN, FEB..
     *
     * @param mthMM The month as 2 digits For example, "01", "02",..
     *
     * @return a specified month string.  If the specified month is unknown,
     *         empty string ("") is returned.
     *
     * @since 23/02/2010
     */
    public static String toMMMFormat(String mthMM)
    {
        if ("01".equals(mthMM))
        {
            return MTH_JAN;
        }
        else if ("02".equals(mthMM))
        {
            return MTH_FEB;
        }
        else if ("03".equals(mthMM))
        {
            return MTH_MAR;
        }
        else if ("04".equals(mthMM))
        {
            return MTH_APR;
        }
        else if ("05".equals(mthMM))
        {
            return MTH_MAY;
        }
        else if ("06".equals(mthMM))
        {
            return MTH_JUN;
        }
        else if ("07".equals(mthMM))
        {
            return MTH_JUL;
        }
        else if ("08".equals(mthMM))
        {
            return MTH_AUG;
        }
        else if ("09".equals(mthMM))
        {
            return MTH_SEP;
        }
        else if ("10".equals(mthMM))
        {
            return MTH_OCT;
        }
        else if ("11".equals(mthMM))
        {
            return MTH_NOV;
        }
        else if ("12".equals(mthMM))
        {
            return MTH_DEC;
        }

        return null;
    }

    /**
     * This method invoked to get previous day for the specified date.
     * @param date
     * @return
     */
    public static Date getPrevDay(Date date){
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.DAY_OF_MONTH, -1);
    	return cal.getTime();
    }
    public static Date getNextDay(Date date){
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.DAY_OF_MONTH, 1);
    	return cal.getTime();
    }
    /**
     * This method invoked to get date of previous month for the specified date.
     * @param date
     * @return
     */
    public static Date getPrevMonth(Date date){
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.MONTH, -1);
    	return cal.getTime();
    }
    public static Date getNextMonth(Date date){
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.MONTH, 1);
    	return cal.getTime();
    }

    /**
     * This method invoked to format a date.
     * @param date
     * @return
     */
    public static String format(Date date){
    	if(date == null) {
    		return null;
    	}

    	SimpleDateFormat sdf = new SimpleDateFormat(DATEFORMAT);
    	return sdf.format(date);
    }
    /**
     * This method invoked to format a date to the specified format.
     * @param date
     * @param dateFormat
     * @return
     */
    public static String format(Date date, String dateFormat){
    	if(date == null) {
    		return null;
    	}

    	SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
    	return sdf.format(date);
    }

    public static Date parse(String date, String format) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setLenient(false);
        TimeZone tz = TimeZone.getTimeZone( timezone );
        sdf.setTimeZone(tz);
        return sdf.parse( date );
    }

    public static java.sql.Date parseSQLDate(String date, String format) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setLenient(false);
        TimeZone tz = TimeZone.getTimeZone( timezone );
        sdf.setTimeZone(tz);
        return toSQLDate(sdf.parse( date ));
    }

    public static Timestamp parseTimestamp(java.sql.Date sqlDate, Time sqlTime){
    	if(sqlDate == null || sqlTime == null) {
    		return null;
    	}

    	Calendar calDt = Calendar.getInstance();
		calDt.setTimeInMillis(sqlDate.getTime());

		Calendar calTS = Calendar.getInstance();
		calTS.setTimeInMillis(sqlTime.getTime());
		calTS.set(Calendar.YEAR, calDt.get(Calendar.YEAR));
		calTS.set(Calendar.MONTH, calDt.get(Calendar.MONTH));
		calTS.set(Calendar.DATE, calDt.get(Calendar.DATE));

    	return new Timestamp(calTS.getTimeInMillis());
    }

    /**
     * This method invoked to compute Between Day Number.
     * @param Date fromDate
     * @param Date toDate
     * @return int
     */
    public static int getBetweenDayNumber(Date fromDate, Date toDate) {
    	if(fromDate == null || toDate == null) {
    		return 0;
    	}
		long dayNumber = 0;
		long DAY = 24L * 60L * 60L * 1000L;
		dayNumber = (fromDate.getTime() - toDate.getTime()) / DAY;
		return (int) dayNumber;
	}

    /**
     * This method invoked to compute Between Month Number.
     * @param Date fromDate
     * @param Date toDate
     * @return int
     */
    public static int getBetweenMonthNumber(Date fromDate, Date toDate) {
    	if(fromDate == null || toDate == null) {
    		return 0;
    	}
		int monthNumber = 0;
		monthNumber = (getYear(toDate) - getYear(fromDate)) * 12 + getMonth(toDate) - getMonth(fromDate);
		if(fromDate.before(addMonthsToDate(toDate,-monthNumber))){
			monthNumber = monthNumber + 1;
		}
		return monthNumber;
	}

    /**
     * this method used to format string to date
     * @param dateTypeStr - the input String must be YYYYMMDD
     * @return
     */
    public static Date formateStrAsDate(String dateTypeStr){
    	Date returnDate = null;
    	try{
	    	if(dateTypeStr.length() != 8){
	    		returnDate = getSystemDate();
	    	}else{
	    		int strLength = dateTypeStr.length();
	    		String inputStr = dateTypeStr.substring(strLength -2, strLength) + "/"+dateTypeStr.substring(strLength-4, strLength-2)+"/"+dateTypeStr.substring(0, strLength-4);
	    		returnDate = DateUtil.parse(inputStr, DateUtil.DATEFORMAT);
	    	}
    	}catch(Exception e){
    		log.error(e);
    	}
    	return returnDate;
    }

    public static java.sql.Date formateStrAsSQLDate(String dateTypeStr){
    	Date returnDate = null;
    	try{
	    	if(dateTypeStr.length() != 8){
	    		returnDate = getSystemDate();
	    	}else{
	    		int strLength = dateTypeStr.length();
	    		String inputStr = dateTypeStr.substring(strLength -2, strLength) + "/"+dateTypeStr.substring(strLength-4, strLength-2)+"/"+dateTypeStr.substring(0, strLength-4);
	    		returnDate = DateUtil.parse(inputStr, DateUtil.DATEFORMAT);
	    	}
    	}catch(Exception e){
    		log.error(e);
    	}
    	return toSQLDate(returnDate);
    }

    /**
     * this method used to format String to Time
     * @param timeStr - the input String must be HHMMSS or HHMM
     * @return
     * @throws Exception
     */
    public static Time formatStrAsTime(String timeStr)throws Exception{
    	DateFormat df1 = new SimpleDateFormat("hh:mm:ss");
		Time returnTime=null;
		if(timeStr != null && !timeStr.equals("")){
			if(timeStr.length() ==4){
				String formatedStr = timeStr.substring(0, 2) + ":"+timeStr.substring(2,4) + ":00";
				returnTime = new Time(df1.parse(formatedStr).getTime());
			}else if(timeStr.length() ==6){
				String formatedStr = timeStr.substring(0, 2) + ":"+timeStr.substring(2,4) + ":" +timeStr.substring(4,6);
				returnTime = new Time(df1.parse(formatedStr).getTime());
			}else if (timeStr.length() == 5){
				df1 = new SimpleDateFormat("HH:mm:ss");
				String formatedStr = timeStr + ":00";
				returnTime = new Time(df1.parse(formatedStr).getTime());
			}else{
				returnTime =   new Time(DateUtil.getSystemTimestamp().getTime());
			}
		}else{
			returnTime =   new Time(DateUtil.getSystemTimestamp().getTime());
		}
		return returnTime;
    }
    
    /**
     * This method is used to add working days.
     * 
     * @param date
     * @param workingDays
     * @param holidayList
     * @return
     * @throws Exception
     */
    public static Date addWorkingDays(Date date, int workingDays, List<Date> holidayList) throws Exception{
    	int i = 0;
    	Date workingDate = date;
    	
    	while (i < workingDays){
    		workingDate = addDaysToDate(workingDate, 1);
    		if (!holidayList.contains(workingDate) && !isSaturday(workingDate) && !isSunday(workingDate)){
    			i++;
    		}
    	}
    	return workingDate;
    }
    
    /**
     * This method is used to check if the date is Saturday.
     * 
     * @param date
     * @return
     */
    public static boolean isSaturday(Date date) {
    	if (date == null)
    	    return false;

    	if (getDayOfWeek(date) == Calendar.SATURDAY)
    	    return true;
    	else
    	    return false;
    }
    
    /**
     * This method is used to check if the date is Sunday.
     * 
     * @param date
     * @return
     */
    public static boolean isSunday(Date date) {
    	if (date == null)
    	    return false;

    	if (getDayOfWeek(date) == Calendar.SUNDAY)
    	    return true;
    	else
    	    return false;
    }
    
    /**Method use for get current Shift Id by Current Time (left eq)
     * 				if time in 00:00:00 ~ 08:00:00 return "1"
     * 				if time in 08:00:00 ~ 16:00:00 return "2"
     * 				if time in 16:00:00 ~ 00:00:00 return "3"
     * @return String
     */
    public static String getCurrentShiftId(){
	Long shiftTime = DateUtil.getSystemTimestamp().getTime();
	StringBuffer DateStr = new StringBuffer();
	StringBuffer DateStr1 = new StringBuffer();
	StringBuffer DateStr2= new StringBuffer();
	StringBuffer DateStr3 = new StringBuffer();
	DateStr.append(DateUtil.format(DateUtil.getSystemDate(),"yyyy-MM-dd")).append(" ");
	DateStr1.append(DateStr).append("00:00:00");
	DateStr2.append(DateStr).append("08:00:00");
	DateStr3.append(DateStr).append("16:00:00");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	try {
		long time1 = sdf.parse(DateStr1.toString()).getTime();
		long time2 = sdf.parse(DateStr2.toString()).getTime();
		long time3 = sdf.parse(DateStr3.toString()).getTime();
		
		if(shiftTime >=time1 && shiftTime< time2){
			return "1";
		}else if(shiftTime >=time2 && shiftTime< time3){
			return "2";
		}else {
			return "3";
		}
	} catch (ParseException e) {
		e.printStackTrace();
	}
		return null;
    }
    
	/**
	 * @param date, date string to be parsed
	 * @param format, format for the specified date
	 * @param isBeginOfDay
	 * @return
	 */
	public static Timestamp getTimestampFrmDteStr(String date, String format, boolean isBeginOfDay) {
		date = DateUtil.format(DateUtil.toDate(date, format), DateUtil.DATEFORMAT_DB);
		if(isBeginOfDay) {
			date =  date + " " + "00:00:00.000000000";
		}
		else {
			date =  date + " " + "23:59:59.999999999";
		}
		
		return Timestamp.valueOf(date);
	}
	
	/**
	 * 取十位当前时间戳
	 * @return
	 */
	public static int getTimestamp10(){
		long stamp=DateUtil.getSystemTimestamp().getTime();
		return (int)Math.ceil(stamp/1000);
	}
	
	public static int getTimestamp10(Timestamp time) {
		long stamp = time.getTime();
		return (int)Math.ceil(stamp/1000);
	}
	
	public static int getTimestamp10(String date, String pattern) {
		try {
			long stamp = DateUtil.parse(date, pattern).getTime();
			return (int) Math.ceil(stamp/1000);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getTimestamp10();
	}
	
	/**
	 * 补全java的时间戳
	 * @return
	 */
	public static long setTimestamp13(int stamp){
		return (long)stamp*1000;
	}
	
	/**
	 * 10位时间戳转timestamp
	 * @param stamp
	 * @return
	 */
	public static Timestamp toTimestamp(int stamp){
		return new Timestamp(setTimestamp13(stamp));
	}
	
	public static Date parseDate10(int stamp){
		return toDate(DateUtil.toTimestamp(stamp));
	}
	
	public static String parseDate10(int stamp,String format){
		return DateUtil.parseDate(DateUtil.parseDate10(stamp),format);
	}
    
	/**
	 * 10位时间戳转timestamp
	 * @param stamp
	 * @return
	 */
	public static void main(String[] args) {
		int time=DateUtil.getTimestamp10();
		long _time=setTimestamp13(time);
		Date d=parseDate10(1367546982);
		
		System.out.println(parseDate(d,"yyyy-MM-dd HH:mm:ss"));

	}
}
