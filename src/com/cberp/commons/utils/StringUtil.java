package com.cberp.commons.utils;

import java.math.BigDecimal;

public class StringUtil {

	//只保存两位小数 不进位
	public static String getTwoNumberFormart(String moneystr) {
		int index_ = moneystr.indexOf(".");
		if (index_ >= 0) {
			int lengthstr = moneystr.substring(index_ + 1).length();
			if (lengthstr >= 3) {
				return moneystr.substring(0, index_) + "." + moneystr.substring(index_ + 1, index_ + 3);
			} else {
				return moneystr;
			}
		} else {
			return moneystr;
		}
	}
	
	public static void main(String[] args) {
		String amount = getTwoNumberFormart("1000.55");
		BigDecimal moneyDecimal = new BigDecimal(amount);
		System.out.println(String.valueOf(moneyDecimal.multiply(BigDecimal.valueOf(100)).setScale(0)));
	}
}
