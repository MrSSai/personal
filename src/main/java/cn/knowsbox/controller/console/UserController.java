package cn.knowsbox.controller.console;

import cn.knowsbox.dto.UserDto;
import cn.knowsbox.annotation.LogAnnotation;
import cn.knowsbox.model.User;
import cn.knowsbox.service.UserService;
import cn.knowsbox.utils.LogSout;
import cn.knowsbox.utils.PageInfo;
import cn.knowsbox.utils.UserUtil;
import com.github.pagehelper.Page;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 用户相关操作
 * @description
 *
 */
@Slf4j(topic = "consoleLogger")
@RestController
@CacheConfig(cacheNames = "userCache")
@RequestMapping("/console/user")
public class UserController {
    @Autowired
    private UserService userService;

    @LogAnnotation
    @PostMapping("/add")
    @ApiOperation(value = "保存用户")
    @RequiresPermissions("sys:user:add")
//    @RequestBody 该注解常用来处理Content-Type
    public User saveUser(@RequestBody UserDto userDto) {
        User u = userService.getUser(userDto.getUsername());
        if (u != null) {
            throw new IllegalArgumentException(userDto.getUsername() + "已存在");
        }
        return userService.saveUser(userDto);
    }

    @LogAnnotation
    @PutMapping
    @ApiOperation(value = "修改用户")
    @RequiresPermissions("sys:user:add")
    public User updateUser(@RequestBody UserDto userDto) {
        return userService.updateUser(userDto);
    }

    @LogAnnotation
    @PutMapping(params = "avatar")
    @ApiOperation(value = "修改头像")
    public void updateAvatar(String avatar) {
        User user = UserUtil.getCurrentUser();
        UserDto userDto = new UserDto();
        BeanUtils.copyProperties(user, userDto);
        userDto.setAvatar(avatar);
        userService.updateUser(userDto);
        log.debug("{}修改了头像", user.getUsername());
    }

    @LogAnnotation
    @PutMapping("/{username}")
    @ApiOperation(value = "修改密码")
    @RequiresPermissions("sys:user:password")
    public void changePassword(@PathVariable String username, String oldPassword, String newPassword) {
        userService.changePassword(username, oldPassword, newPassword);
    }


    @GetMapping("/list")
    @ApiOperation(value = "用户列表")
    @RequiresPermissions("sys:user:query")
    public ModelAndView listUsers(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("console/user/list");
        String pageNum = request.getParameter("pageNum");
        if(pageNum == null){
            pageNum = "1";
        }
        Integer pageNo = Integer.parseInt(pageNum);
        Page<User> users = userService.findByPage(pageNo, 3);
        PageInfo<User> pageInfo = new PageInfo<>(users);
        mv.addObject("page", pageInfo);
        return mv;
    }

    @ApiOperation(value = "当前登录用户")
    @GetMapping("/current")
    public User currentUser() {
        return UserUtil.getCurrentUser();
    }

    @ApiOperation(value = "根据用户id获取用户")
    @GetMapping("/{id}")
    @RequiresPermissions("sys:user:query")
    public User user(@PathVariable Long id) {
        return userService.findById(id);
    }
}
