<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>首页</title>
    <link href="../../fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="../../plugins/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css"/>

    <link href="../../css/viewer.css" rel="stylesheet" type="text/css"/>
    <link href="../../css/nav.css" rel="stylesheet" type="text/css">
    <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css">
</head>
<body class=" ">

<div class='page-topbar'>
    <div class='logo-area'>
    </div>
    <div class='quick-area'>
        <div class='pull-left'>
            <ul class="info-menu left-links list-inline list-unstyled">
                <li class="sidebar-toggle-wrap">
                    <a href="#" data-toggle="sidebar" class="sidebar_toggle">
                        <i class="fa fa-bars"></i>
                    </a>
                </li>
            </ul>
        </div>
        <div class='pull-right'>
            <ul class="info-menu right-links list-inline list-unstyled">
                <li class="profile">
                    <a href="#" data-toggle="dropdown" class="toggle">
                        <img src="../../img/avatars/profile.jpg" alt="user-image" class="img-circle img-inline">
                        <span>${user.nickname}<i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul class="dropdown-menu profile animated fadeIn">
                        <li>
                            <a href="#settings">
                                <i class="fa fa-wrench"></i>
                                设置
                            </a>
                        </li>
                        <li>
                            <a href="#profile">
                                <i class="fa fa-user"></i>
                                我的保存
                            </a>
                        </li>
                        <li>
                            <a href="#help">
                                <i class="fa fa-info"></i>
                                帮助
                            </a>
                        </li>
                        <li class="last">
                            <a href="/logout">
                                <i class="fa fa-lock"></i>
                                退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

</div>

<div class="page-container row-fluid container-fluid">
    <div class="page-sidebar fixedscroll">
        <div class="page-sidebar-wrapper" id="main-menu-wrapper">
            <div class="profile-info row">
                <div class="profile-image col-xs-4">
                    <a href="ui-profile.html">
                        <img alt="" src="../../img/avatars/profile.jpg" class="img-responsive img-circle">
                    </a>
                </div>
                <div class="profile-details col-xs-8">

                    <h3>
                        <a href="ui-profile.html">Shane Taylor</a>
                        <span class="profile-status online"></span>
                    </h3>
                    <p class="profile-title">Web Developer</p>
                </div>
            </div>



            <ul class='wraplist'>
                <li class='menusection'>Main</li>
                <li class="nav-item">
                    <a href="#">
                        <i class="fa fa-group (alias)"></i>
                        <span class="title">用户管理</span></a>
                    <ul id="menu-showhide1">
                        <li id="user-add">
                            <a href="#">
                                <i class="fa fa-user-plus"></i>
                                <span class="title">添加用户</span>
                            </a>
                        </li>
                        <li id="user-list">
                            <a href="#">
                                <i class="fa fa-user-o"></i>
                                <span class="title">用户列表</span>
                            </a>
                        </li>
                        <li id="user-update">
                            <a href="#">
                                <i class="fa fa-user-circle"></i>
                                <span class="title">更新用户</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#">
                        <i class="fa fa-wrench"></i>
                        <span class="title">工作管理</span></a>
                    <ul id="menu-showhide2">
                        <li id="job-add">
                            <a href="#">
                                <i class="fa fa-deviantart"></i>
                                <span class="title">添加工作</span>
                            </a>
                        </li>
                        <li id="job-list">
                            <a href="#">
                                <i class="fa fa-files-o"></i>
                                <span class="title">工作列表</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#">
                        <i class="fa fa-file-photo-o"></i>
                        <span class="title">菜单管理</span></a>
                    <ul id="menu-showhide3">

                        <li id="menu-add">
                            <a href="#">
                                <i class="fa fa-plus-square-o"></i>
                                <span class="title">添加菜单</span>
                            </a>
                        </li>

                        <li id="menu-list">
                            <a href="#">
                                <i class="fa fa-file-text-o"></i>
                                <span class="title">菜单列表</span>
                            </a>
                        </li>

                        <li id="menu-update">
                            <a href="#">
                                <i class="fa fa-cogs"></i>
                                <span class="title">更新菜单</span>
                            </a>
                        </li>


                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#">
                        <i class="fa fa-male"></i>
                        <span class="title">角色管理</span></a>
                    <ul id="menu-showhide4">
                        <li id="role-add">
                            <a href="#">
                                <i class="fa fa-slack"></i>
                                <span class="title">添加角色</span>
                            </a>
                        </li>
                        <li id="role-list">
                            <a href="#">
                                <i class="fa fa-users"></i>
                                <span class="title">角色列表</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#">
                        <i class="fa fa-bookmark-o"></i>
                        <span class="title">公告管理</span></a>
                    <ul id="menu-showhide5">
                        <li id="notice-add">
                            <a href="#">
                                <i class="fa fa-plus-square"></i>
                                <span class="title">添加公告</span>
                            </a>
                        </li>
                        <li id="notice-list">
                            <a href="#">
                                <i class="fa fa-book"></i>
                                <span class="title">公告列表</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <section id="main-content" class=" ">
        <iframe src="/console/user/list" style="width:100%;height: 800px;" frameborder="0" id="mainiframe"
                class="appiframe"></iframe>
    </section>

</div>

<!-- General section box modal start -->
<div class="modal" id="section-settings" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog animated bounceInDown">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Section Settings</h4>
            </div>
            <div class="modal-body">

                Body goes here...

            </div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                <button class="btn btn-success" type="button">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- modal end -->
</body>
<script src="../../js/libs/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="../../js/libs/jquery.easing.min.js" type="text/javascript"></script>
<script src="../../plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<script src="../../plugins/pace/pace.min.js" type="text/javascript"></script>
<script src="../../plugins/perfect-scrollbar/perfect-scrollbar.min1.js" type="text/javascript"></script>
<script src="../../js/libs/viewportchecker.js" type="text/javascript"></script>
<script src="../../plugins/icheck/icheck.min.js" type="text/javascript"></script>
<script src="../../js/viewer.js" type="text/javascript"></script>
<script src="../../js/nav.js" type="text/javascript"></script>
<script src="../../js/pure-main.js" type="text/javascript"></script>
</html>
