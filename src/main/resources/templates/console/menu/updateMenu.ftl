<!-- 引入公共CSS -->
    <#include "../../fragments/common_css.ftl">
    <link rel="stylesheet" type="text/css" media="screen" href="../../css/font-awesome/css/font-awesome.css">
<body><br><br><br><br><br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <input type="hidden" id="id" name="id">
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
                    <select name="type" class="form-control input-sm" id="type">
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
                    <input class="form-control" placeholder="排序" name="sort" id="sort" type="number"
                           data-bv-notempty="true"
                           data-bv-notempty-message="排序 不能为空">
                </div>
            </div>

            <div class="form-actions">
                <div class="row" align="center">
                    <div class="col-md-12">
                        <button class="btn btn-primary" onclick="location.href='list'">返回</button>
                        <button class="btn btn-primary" type="submit" onclick="update()">
                            <i class="fa fa-save"></i> 保存
                        </button>
                    </div>
                </div>
            </div>

        </fieldset>
    </form>
</div>

<#include "../../fragments/common_js.ftl">
<script type="text/javascript">
    layui.use('layer', function(){
        var layer = layui.layer;
    });

    initParentMenuSelect();
    initData();

    function initData(){
        var id = getUrlParam("id");
        if(id != ""){
            $.ajax({
                type : 'get',
                url : '/permissions/'+id,
                async : false,
                success : function(data) {
                    $("#id").val(data.id);
                    $("#parentId").val(data.parentId);
                    $("#name").val(data.name);
                    var css = data.css;
                    $("#css").val(css);
                    $("#href").val(data.href);
                    $("#type").val(data.type);
                    $("#permission").val(data.permission);
                    $("#sort").val(data.sort);

                    if(css != ""){
                        $("#cssImg").addClass("fa");
                        $("#cssImg").addClass(css);
                    }
                }
            });

        }
    }

    function selectCss(){
        layer.open({
            type: 2,
            title: "样式",
            area: ['800px', '400px'],
            shadeClose: true,
            content: ['icon']
        });
    }

    function update() {
        $('#form').bootstrapValidator();
        var bootstrapValidator = $("#form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if(!bootstrapValidator.isValid()){
            return;
        }

        var formdata = $("#form").serializeObject();

        $.ajax({
            type : 'put',
            url : '/permissions/',
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(formdata),
            success : function(data) {
                layer.msg("修改成功", {shift: -1, time: 1000}, function(){
                    location.href = "list";
                });
            }
        });
    }

</script>
</body>
</html>