package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

public interface MainMapper {

	/**
	 * @描述 此方法可查询： 
	 * 1.今日注册司机数、今日已充值笔数、今日充值总笔数、今日充值总金额（所有机构）
	 * 2.所有注册司机数、所有已充值笔数、所有充值总笔数、所有充值总金额（所有机构）
	 * 3.可根据帐号名称，查询此帐号所在机构下的今日注册司机数、今日已充值笔数、今日充值总笔数、今日充值总金额
	 * 4.可根据帐号名称，查询此帐号所在机构下的所有注册司机数、所有已充值笔数、所有充值总笔数、所有充值总金额
	 * @说明：1、2仅供管理员查看，3、4给机构人员查看
	 * @param flag:-1，查询所有，否则查询今日
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Map<String, Object>> todayData(Map<String, Object> params);
}
