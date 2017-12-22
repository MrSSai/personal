package cn.knowsbox.dao;

import java.util.List;
import java.util.Map;

import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import cn.knowsbox.model.User;



@Mapper
public interface UserDao {

//	可以使用@Query来定义一些查询语句
	@Options(useGeneratedKeys = true, keyProperty = "id", useCache = true)  // 设置是否使用JDBC的getGenereatedKeys()方法获取主键并赋值到keyProperty设置的对象的属性中
	@Insert("insert into sys_user(username, password, nickname, mobile, phone, email, birthday, gender, createTime, updateTime) values(#{username}, #{password}, #{nickname}, #{mobile}, #{phone}, #{email}, now(), #{gender}, now(), now())")
	int save(User user);

	@Select("select * from sys_user t where t.recordstatus = 1 and t.id = #{id}")
	User getById(@Param("id")Long id);

	@Select("select * from sys_user t where t.recordstatus = 1 and t.username = #{username}")
	User getUser(String username);

	@Update("update sys_user t set t.password = #{password} where t.id = #{id}")
	int changePassword(@Param("id") Long id, @Param("password") String password);

	Integer count(@Param("params") Map<String, Object> params);

	List<User> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset,
			@Param("limit") Integer limit);

	@Delete("delete from sys_role_user where userId = #{userId}")
	int deleteUserRole(Long userId);

	int saveUserRoles(@Param("userId") Long userId, @Param("roleIds") List<Long> roleIds);

	int update(User user);

	/**
	 * 分页查询数据
	 * @return
	 */
	Page<User> findByPage();
}
