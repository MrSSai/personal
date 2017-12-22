<#include "../../fragments/common_css.ftl">
<body>
<!-- START CONTENT -->
<section class="wrapper main-wrapper row" style=''>
    <div class="col-lg-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">角色列表</h2>
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
                                <th>描述</th>
                                <th>创建时间</th>
                                <th>更新时间</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#if page.list??>
                                    <#list page.list as item>
                                    <tr scope="row">
                                        <td>${item.id}</td>
                                        <td>${item.name}</td>
                                        <td>${item.descrtption}</td>
                                        <td>${(item.createTime?string('yyyy-MM-dd'))!'无数据'}</td>
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
                                 <@cast.page pageNo=page.pageNum totalPage=page.pages totalRecord=page.total callFunName="/roles/list?pageNum="/>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>
<#include "../../fragments/common_js.ftl">
