package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

import com.cberp.control.entity.Log;

public interface LogMapper {
	
	public Map<String, Object> findById(String id);

	/**
	 * 添加操作日志信息
	 * 
	 * @param log
	 */
	public void addLog(Log log);

	/**
	 * @描述： 查询日志记录数
	 * @作者：李彬
	 * @开发日期：2016-11-29
	 * @param params
	 * @return
	 */
	public Long listCountByPage(Map<String, Object> params);

	/**
	 * 
	 * @描述：日志分页查询
	 * @作者：李彬
	 * @开发日期：2016-11-29
	 * @return
	 */
	public List<Map<String, Object>> listByPage(Map<String, Object> params);

}
