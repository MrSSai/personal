<#include "../../fragments/common_css.ftl">
<body>
</br>
</br>
</br>
</br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <input type="hidden" id="id" name="id">
            <div class="form-group">
                <label class="col-md-2 control-label">用户名</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="用户名" type="text" name="username" id="username" readonly="readonly">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">昵称</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="昵称" type="text" name="nickname" id="nickname">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">手机号</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="手机号" type="text" maxlength="11" name="mobile" id="mobile">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">电话</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="电话" type="text" maxlength="20" name="phone" id="phone">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">邮箱</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="邮箱" type="text" maxlength="50" name="email" id="email">
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
                    <select class="form-control input-sm" name="gender" id="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">状态</label>
                <div class="col-md-10" style="width: 100px">
                    <select class="form-control input-sm" name="status" id="status">
                        <option value="1">正常</option>
                        <option value="2">锁定</option>
                        <option value="0">无效</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">角色</label>
                <div class="checkbox" id="roles">
                </div>
            </div>

            <div class="form-actions">
                <div class="row" align="center">
                    <div class="col-md-12">
                        <button class="btn btn-primary" onclick="location.href='/console/user/list.ftl'">返回</button>
                        <button class="btn btn-primary" type="submit" onclick="update()">
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
    layui.use(['layer','laydate'], function(){
        var layer = layui.layer;
        var laydate = layui.laydate;
        laydate.render({
            elem: '#birthday'
        });
    });

    initRoles();

    initData();

    function initData(){
        var id = getUrlParam("id");
        if(id != ""){
            $.ajax({
                type : 'get',
                url : '/console/user/'+id,
                async : false,
                success : function(data) {
                    $("#id").val(data.id);
                    $("#username").val(data.username);
                    $("#nickname").val(data.nickname);
                    $("#mobile").val(data.mobile);
                    $("#phone").val(data.phone);
                    $("#email").val(data.email);
                    $("#birthday").val(data.birthday);
                    $("#gender").val(data.gender);
                    $("#status").val(data.status);
                }
            });

            initRoleDatas(id);
        }
    }

    $('#form').bootstrapValidator();

    function update() {
        var bootstrapValidator = $("#form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if(!bootstrapValidator.isValid()){
            return;
        }

        var formdata = $("#form").serializeObject();
        formdata.roleIds = getCheckedRoleIds();

        $.ajax({
            type : 'put',
            url : '/console/user',
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(formdata),
            success : function(data) {
                layer.msg("修改成功", {shift: -1, time: 1000}, function(){
                    location.href = "/console/user/list.ftl";
                });
            }
        });
    }

</script>
</body>
</html>