<#include "../../fragments/common_css.ftl">
<body>
</br>
</br>
</br>
</br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <div class="form-group">
                <label class="col-md-2 control-label">用户名</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="用户名" type="text" name="username"
                           data-bv-notempty="true"
                           data-bv-notempty-message="用户名 不能为空">
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">密码</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="密码" type="password" value="88888888" name="password"
                           data-bv-notempty="true"
                           data-bv-notempty-message="密码 不能为空">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">昵称</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="昵称" type="text" name="nickname">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">手机号</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="手机号" type="text" maxlength="11" name="mobile">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">电话</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="电话" type="text" maxlength="20" name="phone">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">邮箱</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="邮箱" type="text" maxlength="50" name="email">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">生日</label>
                <div class="col-xs-2">
                    <input type="text" class="form-control" placeholder="生日" id="birthday" name='birthday'>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">性别</label>
                <div class="col-md-10" style="width: 100px">
                    <select class="form-control input-sm" name="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
            </div>
            <#--<div class="form-group">-->
                <#--<label class="col-md-2 control-label">角色</label>-->
                <#--<div class="col-md-10" style="width: 100px">-->
                    <#--<select class="form-control input-sm" name="gender">-->
                        <#--<option value="1">普通用户</option>-->
                        <#--<option value="1">管理员</option>-->
                    <#--</select>-->
                <#--</div>-->
            <#--</div>-->

            <div class="form-actions">
                <div class="row" align="center">
                    <div class="col-md-12">
                        <button class="btn btn-primary" onclick="location.href='/console/user/list.ftl'">返回</button>
                        <button class="btn btn-primary" type="submit" onclick="add()">
                            <i class="fa fa-save"></i> 保存
                        </button>
                    </div>
                </div>
            </div>

        </fieldset>
    </form>
</div>
<script type="text/javascript" src="../../js/libs/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="../../js/jq.js"></script>
<script type="text/javascript" src="../../js/plugin/bootstrapvalidator/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript" src="../../js/my/roles/role.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript">
    <#-- 生日弹出日历 -->
    layui.use(['layer','laydate'], function(){
        var layer = layui.layer;
        var laydate = layui.laydate;
        laydate.render({
            elem: '#birthday'
        });
    });

    initRoles();
//  表单验证
    $('#form').bootstrapValidator();

    function add() {
        var bootstrapValidator = $("#form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if(!bootstrapValidator.isValid()){
            return;
        }

//      利用Jquery插件，将form转换成用于ajax参数的Javascript Object
        var formdata = $("#form").serializeObject();
        formdata.roleIds = getCheckedRoleIds();

        $.ajax({
            type : 'post',
            url : '/console/user/add',
            contentType: "application/json; charset=utf-8",
//          stringify 用于从一个对象解析出字符串
            data : JSON.stringify(formdata),
            success : function(data) {
//              layer.msg 设置图标问题
//              第一个参数：提示
//              第二个参数：自动关闭时间
//              第三个参数：图标类型
//              第四个参数：msg关闭后执行的回调
                layer.msg("添加成功", {shift: -1, time: 1000}, function(){
                    location.href = "/console/user/list.ftl";
                });
            }
        });
    }

</script>
</body>
</html>