package cn.knowsbox.service.impl;

import java.util.List;

import cn.knowsbox.dao.RoleDao;
import cn.knowsbox.dto.RoleDto;
import cn.knowsbox.service.RoleService;
import cn.knowsbox.utils.LogSout;
import cn.knowsbox.utils.RedisUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import cn.knowsbox.model.Role;

import lombok.extern.slf4j.Slf4j;

@Slf4j(topic = "adminLogger")
@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roleDao;
	@Autowired
	private static final String TOKEN_PREFIX = "Roles:";
	@Autowired
	private RedisUtil redisUtil;

	@Override
	@ApiOperation(value = "保存角色")
	@Transactional
	public Role saveRole(RoleDto roleDto) {
		Role role = roleDto;
		if (role.getId() != null) {// 修改
			Role r = roleDao.getRole(role.getName());
//			写入 redis 缓存
			redisUtil.set(TOKEN_PREFIX + role.getId(), role);
			if (r != null && r.getId() != role.getId()) {
				throw new IllegalArgumentException(role.getName() + "已存在");
			}
			roleDao.update(role);
		} else {// 新增
			Role r = roleDao.getRole(role.getName());
			if (r != null) {
				throw new IllegalArgumentException(role.getName() + "已存在");
			}
			log.debug("新增角色{}", role.getName());
		}
		saveRolePermission(role.getId(), roleDto.getPermissionIds());
		return this.roleDao.getById(role.getId());
	}

	private void saveRolePermission(Long roleId, List<Long> permissionIds) {
		roleDao.deleteRolePermission(roleId);
		permissionIds.remove(0L);
		if (!CollectionUtils.isEmpty(permissionIds)) {
			roleDao.saveRolePermission(roleId, permissionIds);
		}
	}

	@ApiOperation(value = "根据id删除角色")
	@Override
	@Transactional
	public void deleteRole(Long id) {
		roleDao.deleteRolePermission(id);
		roleDao.delete(id);
//		删除 redis 缓存中的角色信息
		redisUtil.remove(TOKEN_PREFIX + id);
		log.debug("删除角色id:{},并且 redis 缓存中已清除", id);
	}

	@ApiOperation(value = "通过id获取角色对象")
	public Role find(Long id){
//		如果 redis 缓存中不存在 key 所对应的缓存，则将该角色信息写入到 redis 中
//		否则直接从 redis 缓存中直接调取 key 所对应的角色信息
		if (!redisUtil.exists(TOKEN_PREFIX + id)) {
			log.debug("根据{}获取角色对象，从数据中获取", id);
			redisUtil.set(TOKEN_PREFIX + id, this.roleDao.getById(id));
			return this.roleDao.getById(id);
		} else {
			LogSout.logout("redis缓存中已有id=" + id + "角色对象的信息，直接从缓存中读取");
			return (Role) redisUtil.get(TOKEN_PREFIX + id);
		}
	}

	@ApiOperation(value = "分页显示角色")
	@Override
	public Page<Role> findByPage(int pageNo, int pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		return roleDao.findByPage();
	}
}
