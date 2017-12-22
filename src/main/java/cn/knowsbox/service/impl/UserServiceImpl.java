package cn.knowsbox.service.impl;

import java.util.List;
import java.util.UUID;

import cn.knowsbox.constants.UserConstants;
import cn.knowsbox.dao.UserDao;
import cn.knowsbox.dto.UserDto;
import cn.knowsbox.model.User;
import cn.knowsbox.service.UserService;
import cn.knowsbox.utils.UserUtil;
import cn.knowsbox.utils.RedisUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import io.swagger.annotations.ApiOperation;
import lombok.extern.log4j.Log4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j(topic = "adminLogger")
@Log4j
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private static final String TOKEN_PREFIX = "Users:";

    @Autowired
    private RedisUtil redisUtil;

    @Override
    @Transactional
    @ApiOperation(value = "保存用户，并将用户信息写入到 redis 缓存中")
    public User saveUser(UserDto userDto) {
        User user = userDto;
        user.setSalt(DigestUtils
                .md5Hex(UUID.randomUUID().toString() + System.currentTimeMillis() + UUID.randomUUID().toString()));
        user.setPassword(passwordEncoder(user.getPassword(), user.getSalt()));
        user.setStatus(User.Status.VALID);
        userDao.save(user);

        String key = TOKEN_PREFIX + user.getId();
        redisUtil.set(key, user);
        saveUserRoles(user.getId(), userDto.getRoleIds());
        log.debug("新增用户{" + user.getUsername() + "}");
        return user;
    }


    private void saveUserRoles(Long userId, List<Long> roleIds) {
        if (roleIds != null) {
            userDao.deleteUserRole(userId);
            if (!CollectionUtils.isEmpty(roleIds)) {
                userDao.saveUserRoles(userId, roleIds);
            }
        }
    }

    @Override
// 用户密码加密
    public String passwordEncoder(String credentials, String salt) {
//																用户密码/盐字节/经哈希迭代
        Object object = new SimpleHash("MD5", credentials, salt, UserConstants.HASH_ITERATIONS);
        return object.toString();
    }

    @Override
    public User getUser(String username) {
        return userDao.getUser(username);
    }


    @Override
    @ApiOperation(value = "更改用户密码")
    public void changePassword(String username, String oldPassword, String newPassword) {
        User u = userDao.getUser(username);
        if (u == null) {
            throw new IllegalArgumentException("用户不存在");
        }

        if (!u.getPassword().equals(passwordEncoder(oldPassword, u.getSalt()))) {
            throw new IllegalArgumentException("密码错误");
        }

        userDao.changePassword(u.getId(), passwordEncoder(newPassword, u.getSalt()));

//        log.debug("修改{}的密码", username);
    }

    @Override
    @Transactional
    @ApiOperation(value = "更新用户信息")
    public User updateUser(UserDto userDto) {
        userDao.update(userDto);
        saveUserRoles(userDto.getId(), userDto.getRoleIds());
        updateUserSession(userDto.getId());

        return userDto;
    }

    @ApiOperation(value = "更新用户Session")
    private void updateUserSession(Long id) {
        User current = UserUtil.getCurrentUser();
        if (current.getId().equals(id)) {
            User user = userDao.getById(id);
            UserUtil.setUserSession(user);
        }
    }

    @ApiOperation(value = "根据id查找用户")
    @Override
    public User findById(Long id) {
        String key = TOKEN_PREFIX + id;
        int expireTime = 100;
//		如果 redis 缓存中不存在 key 所对应的缓存，则将该用户信息写入到 redis 中
//		否则直接从 redis 缓存中直接调取 key 所对应的用户信息
        if (!redisUtil.exists(key)) {
            System.err.println("根据id=" + id + "获取用户对象，从数据库中获取");
//			将当前用户信息存储到redis，key = 用户id，value = User对象
            redisUtil.set(key, this.userDao.getById(id), Long.parseLong(String.valueOf(expireTime)));
            return this.userDao.getById(id);
        } else
            return (User) redisUtil.get(key);
    }


    @Override
    @ApiOperation(value = "分页显示用户列表")
    public Page<User> findByPage(int pageNo, int pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        return userDao.findByPage();
    }
}
