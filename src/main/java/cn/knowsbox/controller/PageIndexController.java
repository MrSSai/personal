package cn.knowsbox.controller;


import cn.knowsbox.utils.UserUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;

/**
 * 页面索引
 *
 */

@RestController
@RequestMapping("/")
public class PageIndexController {

    @ApiOperation(value = "首页")
    @GetMapping("/index")
    public ModelAndView index(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("user", UserUtil.getCurrentUser());
        return mv;
    }

    @ApiOperation(value = "登录界面")
    @GetMapping("/login")
    public ModelAndView signin(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("login");
        return mv;
    }

    @ApiOperation(value = "添加用户")
    @GetMapping("/addUser")
    public  ModelAndView addU(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/console/user/addUser");
        return mv;
    }

    @ApiOperation(value = " 添加公告")
    @GetMapping("/addNotice")
    public ModelAndView addN(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/console/notice/addNotice");
        return mv;
    }

    @ApiOperation(value = "更新用户")
    @GetMapping("/updateUser")
    public ModelAndView update(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/console/user/updateUser");
        return mv;
    }

    @ApiOperation(value = "添加工作")
    @GetMapping("addJob")
    public ModelAndView add(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/console/job/addJob");
        return mv;
    }

    @ApiOperation(value = "添加角色")
    @GetMapping("addRole")
    public ModelAndView addRole(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/console/role/addRole");
        return mv;
    }

    @ApiOperation(value = "添加菜单")
    @GetMapping("/addMenu")
    public ModelAndView addMenu(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("console/menu/addMenu");
        return mv;
    }

    @ApiOperation(value = "更新菜单")
    @GetMapping("/updateMenu")
    public ModelAndView updateMenu(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("console/menu/updateMenu");
        return mv;
    }

}
