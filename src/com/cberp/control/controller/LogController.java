package com.cberp.control.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
import com.cberp.control.mapper.LogMapper;

/**
 * 系统日志记录Controller
 * @author libin
 *
 */
@Controller
public class LogController {

	@Resource
	private LogMapper logMapper;

	@RequestMapping(value = "/control/log/query", method = RequestMethod.GET)
	public String queryLog(Model model) {

		String nowDate = new DateTime().toString("yyyy-MM-dd");
		model.addAttribute("nowDate", nowDate);

		return "control/log/log-list";
	}

	@RequestMapping(value = "/control/log/query", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String queryLog(String startDate, String endDate, String searchVal, int start, int length, int draw) {

		String nowDate = new DateTime().toString("yyyy-MM-dd");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("length", length);
		params.put("searchVal", searchVal.trim());
		params.put("startDate", (StringUtils.isNotEmpty(startDate) ? startDate : nowDate));
		params.put("endDate", (StringUtils.isNotEmpty(endDate)) ? endDate : nowDate);

		// 查询总记录数
		Long totalCount = this.logMapper.listCountByPage(params);
		// 分页查询用户记录
		List<Map<String, Object>> users = this.logMapper.listByPage(params);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", users);
		map.put("recordsTotal", totalCount);
		map.put("recordsFiltered", totalCount);
		map.put("draw", draw);

		return JSONObject.toJSONString(map);
	}

	@RequestMapping(value = "/control/log/query/{id}", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logDetail(@PathVariable
	String id) {

		Map<String, Object> map = this.logMapper.findById(id);
		return JSONObject.toJSONString(map);
	}
}
