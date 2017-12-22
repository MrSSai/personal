<link rel="stylesheet" href="../../css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="../../css/ztree/demo.css" type="text/css">
<#include "../../fragments/common_css.ftl">
<body><br><br><br><br><br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <input type="hidden" id="id" name="id">
            <div class="form-group">
                <label class="col-md-2 control-label">角色</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="角色" type="text" name="name" id="name"
                           data-bv-notempty="true"
                           data-bv-notempty-message="角色 不能为空">
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">描述</label>
                <div class="col-md-10">
                    <textarea class="form-control" placeholder="描述" name="description"  id="description"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">权限</label>
                <div class="col-md-10">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>

            <div class="form-actions">
                <div class="row" align="center">
                    <div class="col-md-12">
                        <button class="btn btn-primary" onclick="location.href='/console/role/roleList1.ftl'">返回</button>
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
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" src="../../js/libs/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="../../js/my/ztree-menu.js"></script>

<script type="text/javascript">
    layui.use('layer', function(){
        var layer = layui.layer;
    });

    $.fn.zTree.init($("#treeDemo"), getSettting(), getMenuTree());
    initData();

    function initData(){
        var id = getUrlParam("id");
        if(id != ""){
            $.ajax({
                type : 'get',
                url : '/roles/'+id,
                async : false,
                success : function(data) {
                    $("#id").val(data.id);
                    $("#name").val(data.name);
                    $("#description").val(data.description);
                }
            });

            initMenuDatas(id);
        }
    }


    $('#form').bootstrapValidator();

    function add() {
        var bootstrapValidator = $("#form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if(!bootstrapValidator.isValid()){
            return;
        }

        var formdata = $("#form").serializeObject();
        formdata.permissionIds = getCheckedMenuIds();

        $.ajax({
            type : 'post',
            url : '/roles',
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(formdata),
            success : function(data) {
                layer.msg("成功", {shift: -1, time: 1000}, function(){
                    location.href = "/console/role/roleList1.ftl";
                });
            }
        });
    }

</script>
</body>
</html>