package cn.knowsbox.controller;


import cn.knowsbox.utils.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import cn.knowsbox.annotation.LogAnnotation;
import cn.knowsbox.model.User;
import io.swagger.annotations.ApiOperation;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * 登录/登出
 *
 * @author turkey
 */
@RestController
public class LoginController {

    @Autowired
    private static final String TOKEN_PREFIX = "tokens:";
    @Autowired
    private RedisUtil redisUtil;       // redis 存储
    @Autowired
    private EncrypteUtil encrypteUtil;  // MD5 加密
    @Autowired
    private IpUtil ipUtil;  // 获取用户ip地址

    @LogAnnotation
    @ApiOperation(value = "web端登陆")
    @PostMapping("/sys/login")
    public void login(String username, String password) {
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
        SecurityUtils.getSubject().login(usernamePasswordToken);
    }

    @ApiOperation(value = "用户登录")
    @PostMapping("/dologin")
    public void dologin(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
        SecurityUtils.getSubject().login(usernamePasswordToken);
        String key = TOKEN_PREFIX + UUID.randomUUID().toString();  // uuid生成 key
//      request.getRemoteAddr() 在反向代理服务器中达不到预期效果
        String ipadress = ipUtil.getIpAddr(request);
        if (!redisUtil.exists(key)) {
            redisUtil.set(key, encrypteUtil.getMD5(usernamePasswordToken.toString()) + "//" + ipadress, 3600L);  // 用户token时效：1h
            request.getSession().setAttribute("key", key);
        }

    }

    @ApiOperation(value = "用户登出")
    @GetMapping("/logout")
    public void logout(HttpServletRequest request, User user) {
//		从 session 中获取当前用户 key
        String key = request.getSession().getAttribute("key").toString();
        if (!redisUtil.exists(key)) {
            LogSout.logout("redis中没有该用户的token");
        } else
            redisUtil.remove(key);
    }
}
