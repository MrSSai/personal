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
                                    <td>${(item.updateTime?string('yyyy-MM-dd'))!}</td>
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
                <div class="row">
                    <div class="col-xs-6">
                        <div class="message">
                                <#import "../../fragments/common_page1.ftl" as cast/>
                                <@cast.page pageNo=page.pageNum totalPage=page.pages totalRecord=page.total callFunName="/jobs/list?pageNum="/>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>
<#include "../../fragments/common_js.ftl">

