
<#include "../../fragments/common_css.ftl">
<section class="wrapper main-wrapper row">
    <div class="col-lg-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">工作列表</h2>
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
                                <th>登录名</th>
                                <th>姓名</th>
                                <th>生日</th>
                                <th>邮箱</th>
                                <th>性别</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#if page.list??>
                                <#list page.list as item>
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.jobName}</td>
                                    <td>${item.description}</td>
                                    <td>${(item.status == 1)?string("正常","取消")}</td>
                                    <td>${(item.createTime?string('yyyy-MM-dd'))!}</td>
                                    <td>${(item.updateTime?string('yyyy-mm-dd'))!}</td>
                                </tr>
                                </#list>
                            <#else>
                            <p>   抱歉!暂时无数据 </p>
                            </#if>
                            </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
                <#-- 分页效果 -->
                <div class="row">
                    <div class="col-xs-6">
                        <div class="message">
                            共<i class="blue">${page.total}</i>条记录，总页数：${page.pages}  当前显示第 <i
                                class="blue">${page.pageNum}/${page.pages}</i> 页
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="dataTables_paginate paging_bootstrap">
                            <ul class="pagination">
                            <#if !page.isFirstPage >
                                <li><a href="javascript:queryAll(${page.firstPage}, ${page.pageSize});">首页</a></li>
                                <li><a href="javascript:queryAll(${page.prePage}, ${page.pageSize});">上一页</a></li>
                            </#if>
                            <#if !page.isLastPage>
                                <li><a href="javascript:queryAll(${page.nextPage}, ${page.pageSize});">下一页</a></li>
                                <li><a href="javascript:queryAll(${page.lastPage}, ${page.pageSize});">尾页</a></li>
                            </#if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </section>
    </div>
<#include "../../fragments/common_js.js">
</section>
<script type="text/javascript">
    window.load = starts(page);
</script>
</body>
</html>
