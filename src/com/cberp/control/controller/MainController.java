package com.cberp.control.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cberp.control.entity.Organization;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.OrganizationMapper;
import com.cberp.control.mapper.UserMapper;

@Controller
public class MainController {

	@Resource
	private UserMapper userMapper;

//	@Resource
//	private RechargeMapper rechargeMapper;
//
//	@Resource
//	private MainMapper mainMapper;
	
	@Resource
	private OrganizationMapper organizationMapper;

	@RequestMapping("/control/main")
	public String main(Model model, HttpSession session) {

		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);

		return "control/index_new";
	}

	/**
	 * 查询今日数据，最近充值记录（默认取最近10笔）
	 * 
	 * @return
	 */
	@RequestMapping("/control/today/{id}")
	public String todayData(@PathVariable
	String id, Model model) {

		User u = this.userMapper.findById(id);
		Organization o = this.organizationMapper.findById(u.getOrganization_id());

		Map<String, Object> params = new HashMap<String, Object>();
		if (!"admin".equals(u.getAccount())) {
			params.put("account", u.getAccount());
		}
		params.put("start", 0);
		params.put("length", 10);

		List<Map<String, Object>> allList = null;//this.mainMapper.todayData(params);

		// 查询今日注册司机数、今日充值笔数、今日已充值笔数
		params.put("today", new DateTime().toString("yyyy-MM-dd"));
		List<Map<String, Object>> todayList = null;//this.mainMapper.todayData(params);

		List<Map<String, Object>> datas = null;//this.rechargeMapper.listByPage(params);
		model.addAttribute("datas", datas).addAttribute("allList", allList).addAttribute("todayList", todayList).addAttribute("o", o);

		return "control/etc/today-data";
	}
}
