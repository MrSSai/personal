package cn.knowsbox.service;

import cn.knowsbox.dto.UserDto;
import cn.knowsbox.model.User;
import com.github.pagehelper.Page;

public interface UserService {

	User saveUser(UserDto userDto);
	
	User updateUser(UserDto userDto);

	String passwordEncoder(String credentials, String salt);

	User getUser(String username);

	void changePassword(String username, String oldPassword, String newPassword);

	User findById(Long id);

	/**
	 * 分页查询
	 * @param pageNo 页号
	 * @param pageSize 每页显示记录数
	 * @return
	 */
	Page<User> findByPage(int pageNo, int pageSize);

}
