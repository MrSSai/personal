<#--pageNo当前的页码，totalPage总页数，totalRecord总记录数，callFunName回调方法名-->
<#macro page pageNo totalPage callFunName totalRecord>
共<i class="blue">${totalRecord}</i>条记录，总页数：${totalPage}  当前显示第 <i
        class="blue">${pageNo}/${totalPage}</i> 页
        </div>
    </div>
    <div class="col-xs-6">
    <div class="dataTables_paginate paging_bootstrap">
    <ul class="pagination">
    <script>
        console.log(${pageNo});
    </script>
    <#if pageNo!=1>
        <li><a href="javascript:queryAll('${callFunName+1}')">首页</a></li>
        <li><a href="javascript:queryAll('${callFunName+(pageNo-1)}')">上一页</a></li>
    </#if>
    <#if pageNo!=totalPage>
        <li><a href="javascript:queryAll('${callFunName+(pageNo+1)}')">下一页</a></li>
        <li><a href="javascript:queryAll('${callFunName+totalPage}')">尾页</a></li>
    </#if>
</#macro>


