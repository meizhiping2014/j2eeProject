package com.cberp.commons.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;

/**
 * 数据处理工具类
 * 
 * @author zy
 * 
 */
public class DataUtils {

	/**
	 * 格式化数字为2位(全舍)
	 * 
	 * @param data
	 */
	public static String dataFormatTwoDown(Object data) {
		if (null == data || StringUtils.isBlank(data.toString())) {
			return "0.00";
		} else {
			BigDecimal bigDecimal = new BigDecimal(String.valueOf(data));
			bigDecimal = bigDecimal.setScale(2, RoundingMode.DOWN);
			DecimalFormat df = new DecimalFormat("0.00");
			return df.format(bigDecimal);
		}
	}

	/**
	 * 格式化数字为2位(4舌5入)
	 * 
	 * @param data
	 */
	public static String dataFormatHalfUp(Object data) {
		if (null == data || StringUtils.isBlank(data.toString())) {
			return "0.00";
		} else {
			BigDecimal bigDecimal = new BigDecimal(String.valueOf(data));
			bigDecimal = bigDecimal.setScale(2, RoundingMode.HALF_UP);
			DecimalFormat df = new DecimalFormat("0.00");
			return df.format(bigDecimal);
		}
	}

	/**
	 * 将float转成String，去掉小数点取整，转成int
	 * 
	 * @param args
	 */
	public static int floatToInt(float source) {
		return new BigDecimal(source).setScale(0, BigDecimal.ROUND_DOWN).intValue();
	}

	/**
	 * 把数字格式化成千分位的形式，保留2位小数
	 * 
	 * @param data
	 *            要格式化的数字
	 * @return
	 */
	public static String dataFormat(Object data) {
		if (null == data || StringUtils.isBlank(data.toString())) {
			return "0.00";
		} else {
			BigDecimal bigDecimal = new BigDecimal(String.valueOf(data));
			bigDecimal = bigDecimal.setScale(2, RoundingMode.DOWN);
			DecimalFormat df = new DecimalFormat("#,##0.00");
			return df.format(bigDecimal);
		}
	}

	/**
	 * 两个数值之差
	 * 
	 * @param a
	 * @param b
	 * @return
	 */
	public static BigDecimal dataFormatSubtract(double a, double b) {

		BigDecimal num1 = new BigDecimal(a);
		BigDecimal num2 = new BigDecimal(b);
		return num1.subtract(num2);
	}

	/**
	 * 
	 * 字符串带*号，保留最后一位
	 * 
	 * @param objName
	 * @return
	 */
	public static String hiddenName(Object objName) {
		if (objName != null) {
			String name = String.valueOf(objName);
			if (StringUtils.isNotBlank(name)) {
				String hiddenName = "";
				for (int i = 1; i < name.length(); i++) {
					hiddenName = hiddenName + "*";
				}
				hiddenName = hiddenName + name.charAt(name.length() - 1);
				return hiddenName;
			} else {
				return null;
			}
		}
		return null;
	}

	/**
	 * 截取字符串替换为指定字符串，如：*号处理
	 * 
	 * @param context
	 *            完整字符串
	 * @param start
	 *            开始位置
	 * @param end
	 *            结束位置
	 * @param value
	 *            替换的字符串
	 * @return
	 */
	public static String getReplaceStr(String context, int start, int end, String value) {
		if (StringUtils.isBlank(context)) {
			return "";
		}

		// 最终替换成的字符串
		StringBuffer temp = new StringBuffer();
		for (int i = 0; i < end - start; i++) {

			temp.append(value);
		}

		// 将指定截取出来的字符串替换为自定义的字符串
		String replaceStr = context.replace(context.substring(start, end), temp.toString());

		return replaceStr;
	}

	/**
	 * 将double、float、Bigdecimal类型数字保留2位小数，小数位3到6位为9999时向上截取，其他舍去
	 * 
	 * @param double、float、Bigdecimal类型的数字
	 * @return
	 * @throws RuntimeException
	 *             异常
	 */
	public static BigDecimal formatJD(Object data) throws RuntimeException {

		String result = "";
		if (data == null) {
			return null;
		}

		if (data instanceof Double || data instanceof Float) {
			BigDecimal a = new BigDecimal(data.toString());
			result = a.toPlainString();
		} else if (data instanceof BigDecimal) {
			result = ((BigDecimal) data).toPlainString();
		} else {
			throw new RuntimeException("只支持double、float、Bigdecimal类型");
		}

		BigDecimal formatResult = new BigDecimal(result);

		if (result.indexOf(".") > 0) {
			String number = result.substring(result.indexOf(".") + 1);
			if (number.length() < 4) {
				return formatResult.setScale(2, BigDecimal.ROUND_DOWN);
			} else if (number.substring(2, 4).equals("99")) {
				return formatResult.setScale(2, BigDecimal.ROUND_HALF_UP);
			} else {
				return formatResult.setScale(2, BigDecimal.ROUND_DOWN);
			}
		} else {
			return formatResult.setScale(2, BigDecimal.ROUND_DOWN);
		}
	}

	/**
	 * 验证密码
	 * 
	 * @param s
	 * @return
	 */
	public static boolean validatePassword(String s) {
		return (containsUpperCase(s) || containsLowerCase(s)) && containsNumber(s) && s.length() >= 8 && s.length() <= 11;
	}

	/**
	 * 验证字符串是否包括大写字母
	 * 
	 * @param s
	 * @return
	 */
	public static boolean containsUpperCase(String s) {
		return s.matches(".*?[A-Z]+.*?");
	}

	/**
	 * 验证字符串是否包括小写字母
	 * 
	 * @param s
	 * @return
	 */
	public static boolean containsLowerCase(String s) {
		return s.matches(".*?[a-z]+.*?");
	}

	/**
	 * 验证字符串是否包括数字
	 * 
	 * @param s
	 * @return
	 */
	public static boolean containsNumber(String s) {
		return s.matches(".*?[\\d]+.*?");
	}

	/**
	 * 验证是否包含特殊字符
	 * 
	 * @param s
	 * @return
	 */
	public static boolean containsSpecialcharacter(String s) {
		return s.matches(".*?[^a-zA-Z\\d]+.*?");
	}

	/**
	 * 根据传入n值，返回如：0000001格式的串
	 * 
	 * @param n
	 * @return
	 */
	public static String getNumber(long n) {
		String result = "";
		String nf = String.valueOf(n);
		int len = nf.length();
		if ((7 - len) > 0) {
			for (int i = 0; i < (7 - len); i++) {
				result += "0";
			}
		}
		result = result + nf;
		return result;
	}
    
    /**
     * 解析对象
     * @return
     */
    public static <T> T parseObject(Object obj, Class<T> clazz){
        if(obj == null){
            return null;
        }else{
            return JSON.parseObject(JSON.toJSONString(obj), clazz);
        }
    }

	public static void main(String[] args) {
		System.out.println(getNumber(584121));
	}

}
