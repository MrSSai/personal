
<#include "../../fragments/common_css.ftl">
<body><br><br><br><br><br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <div class="form-group">
                <label class="col-md-2 control-label">上级菜单</label>
                <div class="col-md-10">
                    <select id="parentId" name="parentId" class="form-control input-sm"></select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">名称</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="名称" type="text" name="name" id="name"
                           data-bv-notempty="true"
                           data-bv-notempty-message="名称 不能为空">
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">样式</label>
                <div class="col-md-10">
                    <button onclick="selectCss()" class="btn btn-primary">选择</button>
                    <input type="hidden"  name="css" id="css" /><i id="cssImg" class="fa"></i>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">链接</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="链接" name="href" id="href"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">类型</label>
                <div class="col-md-10">
                    <select name="type" class="form-control input-sm">
                        <option value="1">菜单</option>
                        <option value="2">按钮</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">权限</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="权限" name="permission" id="permission" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">排序</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="排序" name="sort" id="sort" type="number" value="100"
                           data-bv-notempty="true"
                           data-bv-notempty-message="排序 不能为空">
                </div>
            </div>

            <div class="form-actions">
                <div class="row" align="center">
                    <div class="col-md-12">
                        <button class="btn btn-primary" onclick="location.href='menuList'">返回</button>
                        <button class="btn btn-primary" type="submit" onclick="add()">
                            <i class="fa fa-save"></i> 保存
                        </button>
                    </div>
                </div>
            </div>

        </fieldset>
    </form>
</div>
<#-- 引入公共js -->
<#include "../../fragments/common_js.ftl">
<script type="text/javascript">
    layui.use('layer', function(){
        var layer = layui.layer;
    });


    initParentMenuSelect();

    function add() {
        $('#form').bootstrapValidator();
        var bootstrapValidator = $("#form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if(!bootstrapValidator.isValid()){
            return;
        }

        var formdata = $("#form").serializeObject();

        $.ajax({
            type : 'post',
            url : '/permissions',
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(formdata),
            success : function(data) {
                layer.msg("添加成功", {shift: -1, time: 1000}, function(){
                    location.href = "menuList";
                });
            }
        });
    }

    function selectCss(){
        layer.open({
            type: 2,
            title: "样式",
            area: ['800px', '400px'],
            shadeClose: true,
            content: ['icon.html']
        });
    }
</script>
</body>
</html>