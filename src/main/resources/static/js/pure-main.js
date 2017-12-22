// 主菜单页面 菜单栏切换效果
$(document).ready(function(){
    su.whole.comFn.initHtml();
});

/**侧边菜单栏  **/
var su = su || {};
su.whole = su.whole || {};
su.whole.comFn= {
    initHtml:function(){
        switchIfm1();  // 用户相关
        switchIfm2();  // 工作相关
        switchIfm3();  // 菜单相关
        switchIfm4();  // 角色相关
        switchIfm5();  // 公告相关
    }
}

//切换窗口
function switchIfm1(){
    $("#menu-showhide1").find("li").click(function(){
        var ifsrc="";
        var thisid=$(this).attr("id");
        switch (thisid){
            case "user-list" : ifsrc="/console/user/list"; break;
            case "user-update" : ifsrc="updateUser"; break;
            case "user-add" : ifsrc="addUser"; break;
        }
        $("#mainiframe").attr("src",ifsrc);
    });
}
function switchIfm2(){
    $("#menu-showhide2").find("li").click(function(){
        var ifsrc="";
        var thisid=$(this).attr("id");
        switch (thisid){
            case "job-add" : ifsrc="addJob"; break;
            case "job-list" : ifsrc="/jobs/list"; break;
        }
        $("#mainiframe").attr("src",ifsrc);
    });
}
function switchIfm3(){
    $("#menu-showhide3").find("li").click(function(){
        var ifsrc="";
        var thisid=$(this).attr("id");
        switch (thisid){
            case "menu-list" : ifsrc="/permissions/list"; break;
            case "menu-add" : ifsrc="addMenu"; break;
            case "menu-update" : ifsrc="updateMenu"; break;
        }
        $("#mainiframe").attr("src",ifsrc);
    });
}
function switchIfm4(){
    $("#menu-showhide4").find("li").click(function(){
        var ifsrc="";
        var thisid=$(this).attr("id");
        switch (thisid){
            case "role-list" : ifsrc="/roles/list"; break;
            case "role-add" : ifsrc="addRole"; break;
        }
        $("#mainiframe").attr("src",ifsrc);
    });
}

function switchIfm5(){
    $("#menu-showhide5").find("li").click(function(){
        var ifsrc="";
        var thisid=$(this).attr("id");
        switch (thisid){
            case "notice-add" : ifsrc="addNotice"; break;
            case "notice-list" : ifsrc="/notices/all"; break;
        }
        $("#mainiframe").attr("src",ifsrc);
    });
}
