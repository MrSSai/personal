<link rel="stylesheet" type="text/css" media="screen" href="../../css/bootstrap-select.min.css">
<#include "../../fragments/common_css.ftl">
<body><br><br><br><br>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" onsubmit="return false" id="form">
        <fieldset>
            <div class="form-group">
                <label class="col-md-2 control-label">job名</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="job名" type="text" maxlength="60" name="jobName"
                           data-bv-notempty="true"
                           data-bv-notempty-message="job名 不能为空">
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">cron表达式</label>
                <div class="col-md-10 form-inline">
                    <input class="form-control" placeholder="cron表达式" type="text" name="cron" id="cron"
                           data-bv-notempty="true"
                           data-bv-notempty-message="cron表达式 不能为空"><button class="btn btn-primary" onclick="checkCron()">检查</button>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">job描述</label>
                <div class="col-md-10">
                    <input class="form-control" placeholder="job描述" type="text" maxlength="200" name="description">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">springBeanName</label>
                <div class="col-md-10 form-inline">
                    <select class="selectpicker show-tick form-control" data-live-search="true" name="springBeanName" id="springBeanName" onchange="showMethods()"></select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">方法名<span style="color: red">（目前仅支持无参方法）</span></label>
                <div class="col-md-10 form-inline">
                    <select class="form-control" name="methodName" id="methodName"
                            data-bv-notempty="true"
                            data-bv-notempty-message="方法名 不能为空"></select>
                </div>
            </div>

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
<#include "../../fragments/common_js.ftl">
<script type="text/javascript" src="../../js/jq.js"></script>
<script type="text/javascript" src="../../js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="../../js/bootstrap/bootstrap-select.min.js"></script>
<script type="text/javascript" src="../../js/my/job.js"></script>
<script type="text/javascript">
    layui.use(['layer'], function(){
        var layer = layui.layer;
    });

    initBeanNames();
    showMethods();

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
            url : '/jobs/addJob',
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(formdata),
            success : function(data) {
                layer.msg("添加成功", {shift: -1, time: 1000}, function(){
                    location.href = "/console/job/jobList.ftl";
                });
            }
        });
    }

</script>
</body>
</html>