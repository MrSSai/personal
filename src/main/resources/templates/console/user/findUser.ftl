<html>
<head></head>
<body>
<form>
    <p>
        <label for="username">角色ID<br/>
            <input type="text" name="rolename" id="rolename" class="input" value="" size="20"/></label>
    </p>
    <p class="submit">
        <input type="button" name="btn-submit" id="btn-submit" class="btn btn-accent btn-block" value="登录"/>
    </p>
</form>
</body>
<script>
    $(function () {
        $("#btn-submit").click(function () {
            find($(this));
        })
    })

    function find(obj) {
        $(obj).attr("disabled", true);

        var rolename = $.trim($('#rolename').val());
        if (rolename == "") {
            $("#info").html('用户名或者密码不能为空');
            $(obj).attr("disabled", false);
        } else {
            $.ajax({
                type: 'post',
                url: '/console/user/{id}',
                data: {username: rolename},
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
</html>