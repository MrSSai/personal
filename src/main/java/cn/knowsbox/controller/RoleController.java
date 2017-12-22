package cn.knowsbox.controller;

import java.util.List;

import cn.knowsbox.dto.RoleDto;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.knowsbox.annotation.LogAnnotation;
import cn.knowsbox.dao.RoleDao;
import cn.knowsbox.model.Role;
import cn.knowsbox.service.RoleService;

import io.swagger.annotations.ApiOperation;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 角色相关接口
 * 
 * @author turkey
 *
 */
@RestController
@RequestMapping("/roles")
public class RoleController {

	@Autowired
	private RoleService roleService;
	@Autowired
	private RoleDao roleDao;

	@LogAnnotation
	@PostMapping
	@ApiOperation(value = "保存角色")
	@RequiresPermissions("sys:role:add")
	public void saveRole(@RequestBody RoleDto roleDto) {
		roleService.saveRole(roleDto);
	}


	@GetMapping("/{id}")
	@ApiOperation(value = "根据id获取角色")
	@RequiresPermissions("sys:role:query")
	public Role get(@PathVariable Long id) {
		return roleService.find(id);
	}

	@GetMapping("/list")
	@ApiOperation("获取role角色")
	@RequiresPermissions("sys:role:query")
	public ModelAndView roleList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("console/role/roleList");
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		Integer pageNo = Integer.parseInt(pageNum);
		Page<Role> roles = roleService.findByPage(pageNo, 2);
		PageInfo<Role>  pageInfo = new PageInfo<>(roles);
		mv.addObject("page",pageInfo);
		return mv;
	}

	@GetMapping(params = "userId")
	@ApiOperation(value = "根据用户id获取拥有的角色")
	@RequiresPermissions(value = { "sys:user:query", "sys:role:query" }, logical = Logical.OR)
	public List<Role> roles(Long userId) {
		return roleDao.listByUserId(userId);
	}

	@LogAnnotation
	@RequestMapping("/delete/{id}")
	@ApiOperation(value = "删除角色")
	@RequiresPermissions(value = { "sys:role:del" })
	public void delete(@PathVariable Long id) {
		roleService.deleteRole(id);
	}

}
