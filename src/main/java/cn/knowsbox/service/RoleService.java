package cn.knowsbox.service;

import cn.knowsbox.dto.RoleDto;
import cn.knowsbox.model.Role;
import com.github.pagehelper.Page;

public interface RoleService {

	Role saveRole(RoleDto roleDto);

	void deleteRole(Long id);

	Role find(Long id);

	/**
	 * 分页查询
	 * @param pageNo 页号
	 * @param pageSize 每页显示记录数
	 * @return
	 */
	Page<Role> findByPage(int pageNo, int pageSize);
}
