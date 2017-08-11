package com.cberp.commons.utils;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cberp.commons.utils.constants.IConstants;


/**
 * 获取时间的公用工具类
 * @author jinshajiang
 *
 */
public class DateUtil {
	public final static DateFormat YYYYMMDDHHMMSS = new SimpleDateFormat("yyyyMMddHHmmss");
	public final static DateFormat YYYY_MM_DD_MM_HH_SS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public final static DateFormat YYYY_MM_DD_MM_HH = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public final static DateFormat YYYY_MM_DD = new SimpleDateFormat("yyyy-MM-dd");
	public final static DateFormat YYYY_MM = new SimpleDateFormat("yyyy-MM");
	public final static SimpleDateFormat MM_HH = new SimpleDateFormat("HH:mm");
	/**
	 * 时间转换为yyyy-MM-dd HH:mm:ss格式的字符串
	 * @param date
	 * @return
	 */
	public static String dateToString(Date date){
		return YYYY_MM_DD_MM_HH_SS.format(date);
	}
	
	/**
	 * 时间转换为yyyy-MM-dd HH:mm格式的字符串
	 * @param date
	 * @return
	 */
	public static String dateToStringYMdHm(Date date){
		return YYYY_MM_DD_MM_HH.format(date);
	}
	
	/**
	 * @param timeRange 月数
	 * 获取当前时间指定时间段之后的时间
	 */
	public static String getMonthLaterTime(String timeRange){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH , Integer.valueOf(timeRange));
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_24);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * 获取系统当前时间，精确到秒
	 * @return
	 */
	public static String getCurrentTimeForYMDHms(){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_24);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * 获取系统当前时间，精确到毫秒
	 * @return
	 */
	public static String getCurrentTimeForYMDHmsms(){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMDHmsms);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * @param timeRange 月数
	 * 获取当前时间指定时间段之后的时间,指定格式为yyyy-mm-dd HH:mm:ss
	 */
	public static String getMonthLaterTime2(String timeRange){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR , -1);
		calendar.add(Calendar.MONTH , Integer.valueOf(timeRange));
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMDHms);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * @param timeRange 月数
	 * 获取当前时间指定时间段之前的时间
	 */
	public static String getMonthbeforTime(String timeRange){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH , -Integer.valueOf(timeRange));
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMD);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * @param timeRange 天数
	 * 获取当前时间指定时间段前的时间
	 */
	public static String getDayLaterTime(String dayRange){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR , -(Integer.valueOf(dayRange)-1));
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMD);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * @param timeRange 天数
	 * 获取当前时间指定时间段后的时间
	 */
	public static String getDayBeforeTime(String dayRange){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR , (Integer.valueOf(dayRange)));
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMD);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * @param timeRange 天数
	 * 获取系统当前时间 返回YYYY-mm-dd格式
	 */
	public static String getCurrentTime(){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMD);
		return formatter.format(calendar.getTime());
	}
	
	/**
	 * 将日期装换为固定格式的String
	 * @param date
	 * @param format
	 * @return
	 */
	public static String formatDateToString(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	
	/**
	 * 将科学计数法转成普通float形式
	 * @param data
	 * @return
	 */
	public static String dataFormat(Object data){
		BigDecimal num = new BigDecimal(String.valueOf(data));
        DecimalFormat df = new DecimalFormat("0.00");
        String res = df.format(num);
		return res;
	}
	
	public static String dataFormat(double a,double b){
		BigDecimal num1 = new BigDecimal(a);
		BigDecimal num2 = new BigDecimal(b);
		DecimalFormat df = new DecimalFormat("0.00");
        String res = df.format(num1.add(num2));
		return res;
	}
	
	/**
	 * 将科学计数法转成普通float形式,保留四位小数
	 * @param data
	 * @return
	 */
	public static String dataFormat_four(Object data){
		BigDecimal num = new BigDecimal(String.valueOf(data));
        DecimalFormat df = new DecimalFormat("0.0000");
        String res = df.format(num);
		return res;
	}
	
	/**
	 * 将字符串小数点后面2位以上的字符舍去（没有小数点的直接加上小数点并补上00）
	 * @param srcData
	 * @return
	 */
	public static String dataFormatStr(String srcData) {
		
		BigDecimal bigDecimal = new BigDecimal(srcData);
		srcData = bigDecimal.toPlainString();
		
		if (!srcData.contains(".")) 
		{
			srcData = srcData + ".00";
		}
		else
		{
			String[] srcDatas = srcData.split("\\.");
			String head = srcDatas[0];
			String tail = srcDatas[1];
			if(tail.length() >=2)
			{
				tail = tail.substring(0, 2);
			}
			else
			{
				tail = tail + "0";
			}
			srcData =  head + "." + tail;
		}
		return srcData;
	}
	
	/**
	 * 获取当前时间和参数中时间的微秒差
	 * @param dateString
	 * @return
	 * @throws ParseException
	 */
	public static long  minusDate(String dateString) throws ParseException
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = df.parse(dateString);
		Date now = new Date();
		return(now.getTime() - date.getTime());
	}
	
	/**
	 * 获取两时间微秒差
	 * @param dateString
	 * @return
	 * @throws ParseException
	 */
	public static long  minusBetweenDate(String startTime,String endTime) throws ParseException
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date endDate = df.parse(endTime);
		Date startDate = df.parse(startTime);
		return(endDate.getTime() - startDate.getTime());
	}
	
	/**
	 * 将Timestamp格式的时间转成yyyy-mm-dd格式字符串
	 * @param str
	 * @return
	 */
	public static String TimestampToString(Timestamp str){
		SimpleDateFormat formatter = new SimpleDateFormat(IConstants.DATE_FORMAT_YMD);
		return formatter.format(str.getTime());
	}
	/**
	 * 
	 * @param object 转换类型
	 * @param init 转换出错object为null 默认返回该值 
	 * @return int
	 */
	public static int parseInt(Object object,int init){
			try {
				if(object!=null){
					return Integer.parseInt((String)object);
				}else{
					return init;
				}
			} catch (Exception e) {
				return init;
			}
	}
	
	/**
	 * 获取两个时间之间相差的秒数
	 * @param startDate
	 * 				开始时间(减数) long型的毫秒数
	 * @param endDate
	 * 				结束时间(被减数)
	 * @return
	 */
	public static long SecondsBetween(Long startDate, Date endDate)
	{
		Long end = endDate.getTime();
		return (end-startDate)/1000;
	}
}

