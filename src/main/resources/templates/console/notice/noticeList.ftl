<#include "../../fragments/common_css.ftl">
<body>
<section class="wrapper main-wrapper row" style=''>

    <div class="col-lg-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">用户列表</h2>
                <div class="actions panel_actions pull-right">
                    <a class="box_toggle fa fa-chevron-down"></a>
                    <a class="box_setting fa fa-cog" data-toggle="modal" href="#section-settings"></a>
                    <a class="box_close fa fa-times"></a>
                </div>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-xs-12">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Id</th>
                                <th>Title</th>
                                <th>内容</th>
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>更新时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list notices as noti>
                            <tr>
                                <td> ${noti.id}</td>
                                <td> ${noti.title}</td>
                                <td> ${noti.content}</td>
                                <#if noti.status ==0>
                                    <td>草稿</td>
                                <#else>
                                    <td>发布</td>
                                </#if>
                                <td> ${noti.createTime?string('yyyy-MM-dd')}</td>
                                <td> ${noti.updateTime?string('yyyy-MM-dd')}</td>
                            </tr>
                            </#list>
                            </tr>
                            </tbody>
                        </table>

                    </div>
                </div>

        </section>
    </div>

</section>
</body>
<#include "../../fragments/common_js.ftl">
</html>


