<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>登录</title>
</head>
<body class=" login_page">
<#include "./fragments/common_css.ftl">
<div class="container-fluid">
    <div class="login-wrapper row">
        <div id="login"
             class="login loginpage col-lg-offset-4 col-md-offset-3 col-sm-offset-3 col-xs-offset-0 col-xs-12 col-sm-6 col-lg-4">
            <h1><a href="#" title="Login Page" tabindex="-1">Artviewer</a></h1>
            <form>
                <p>
                    <label for="username">登录名<br/>
                        <input type="text" name="username" id="username" class="input" value="" size="20"/></label>
                </p>
                <p>
                    <label for="password">密码<br/>
                        <input type="password" name="password" id="password" class="input" value="" size="20"/></label>
                </p>
                <p class="forgetmenot">
                    <label class="icheck-label form-label" for="rememberme">
                        <input name="rememberme" type="checkbox" id="rememberme" value="forever"
                               class="icheck-minimal-aero" checked/>
                        记住我</label>
                </p>
                <p class="submit">
                    <input type="button" name="btn-submit" id="btn-submit" class="btn btn-accent btn-block" value="登录"/>
                </p>
            </form>
            <p id="nav">
            </p>
        </div>
    </div>
</div>
<!--使用公有js-->
<#include "./fragments/common_js.ftl">


<script>
    $(function () {
        $("#btn-submit").click(function () {
            login($(this));
        })
    })

    function login(obj) {
        $(obj).attr("disabled", true);

        var username = $.trim($('#username').val());
        var password = $.trim($('#password').val());
        if (username == "" || password == "") {
            $("#info").html('用户名或者密码不能为空');
            alert('用户名或者密码不能为空');
            $(obj).attr("disabled", false);
        } else {
            $.ajax({
                type: 'post',
                url: '/dologin',
                data: {username: username, password: password},
                success: function () {
                    location.href = '/index';
                },
                error: function (xhr, textStatus, errorThrown) {
                    var msg = xhr.responseText;
                    var response = JSON.parse(msg);
                    $("#info").html(response.message);
                    $(obj).attr("disabled", false);
                }
            });
        }
    }
</script>

</body>
</html>



