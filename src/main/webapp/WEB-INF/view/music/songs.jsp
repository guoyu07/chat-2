<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<style>
    .table th, .table td {
        text-align: center;
        height:38px;
    }
</style>
<table class="table table-hover" id="musicTable">
    <thead>
        <tr>
            <td colspan="7">
                <form action="/music/listSongs" method="get">
                    <input type="text" value="${queryName}" name="q" id="queryName" placeholder="歌曲/专辑/歌手"/>
                    &nbsp;<input type="checkbox" name="songs" id="songs" onclick="showColor(this);" ${songs == null ? '' : 'checked'} />歌曲
                    &nbsp;<input type="checkbox" name="album" id="album" onclick="showColor(this);" ${album == null ? '' : 'checked'} />专辑
                    &nbsp;<input type="checkbox" name="singers" id="singers" onclick="showColor(this);" ${singers == null ? '' : 'checked'} />歌手
                    &nbsp; <button class="default" type="submit">搜索</button>
                </form>
            </td>
        </tr>
        <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="" id="music" style="display: none;"></iframe>
    </thead>
    <tbody>
        <tr>
            <td><input type="checkbox"/></td>
            <td>歌名</td>
            <td>MV地址</td>
            <td>时长</td>
            <td>所属专辑</td>
            <td>歌手</td>
            <td>播放</td>
        </tr>
        <c:forEach items="${songsPage.list}" var="s" varStatus="status">
            <tr class="${status.index % 2 == 0 ? 'alter' : '' }">
                <td><input type="checkbox" value="${s.id}"/></td>
                <td>
                    <a href="${s.url}" target="_blank">
                        <span class="songsSpan1">
                        <c:if test="${fn:contains(s.name,queryName)}">
                            ${fn:substring(s.name,0 ,fn:indexOf(s.name,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.name,fn:indexOf(s.name,queryName) + fn:length(queryName) , fn:length(s.name) )}
                        </c:if>
                        <c:if test="${not fn:contains(s.name,queryName )}">
                            ${s.name}
                        </c:if>
                        </span>
                        <span class="songsSpan2" style="display: none;">
                                ${s.name}
                        </span>
                        ${s.alias == '[]' ? '' : s.alias}
                    </a>
                </td>
                <td><a href="${s.mvurl}" target="_blank">${s.mvurl}</a></td>
                <td>${s.duration}</td>
                <td>
                    <a href="${s.albumurl}" target="_blank">
                        <span class="albumSpan1">
                        <c:if test="${fn:contains(s.albumname,queryName)}">
                            ${fn:substring(s.albumname,0 ,fn:indexOf(s.albumname,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.albumname,fn:indexOf(s.albumname,queryName) + fn:length(queryName) , fn:length(s.albumname) )}
                        </c:if>
                        <c:if test="${not fn:contains(s.albumname,queryName )}">
                            ${s.albumname}
                        </c:if>
                        </span>
                        <span class="albumSpan2" style="display: none;">
                                ${s.albumname}
                        </span>
                    </a>
                </td>
                <td>
                    <a href="${s.homepage}" target="_blank">
                        <span class="singersSpan1">
                        <c:if test="${fn:contains(s.sname,queryName)}">
                            ${fn:substring(s.sname,0 ,fn:indexOf(s.sname,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.sname,fn:indexOf(s.sname,queryName) + fn:length(queryName) , fn:length(s.sname) )}
                        </c:if>
                        <c:if test="${not fn:contains(s.sname,queryName )}">
                            ${s.sname}
                        </c:if>
                         </span>
                        <span class="singersSpan1" style="display: none;">
                                ${s.sname}
                        </span>
                    </a>
                </td>
                <td><a href="javascript:;" onclick="playMusic('${s.url}');"><img src="${pageContext.request.contextPath}/images/play.jpg" width="30px" height="30px"/></a>
                <a href="#">查看二维码</a>
                    <a href="#">下载二维码</a>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="7">
                <div class="container">
                    <ul class="pager">
                        <li><a href="javascript:;" onclick="jump('1${empty queryName ? "" : "&q="}${queryName}')">首页</a></li>
                        <li> <a href="javascript:;" onclick="jump('${songsPage.pageNumber > 1 ? songsPage.pageNumber - 1 : 1}${empty queryName ? "" : "&q="}${queryName}')">上一页</a></li>
                        <li><a href="#">${songsPage.pageNumber}</a></li>
                        <li><a href="javascript:;" onclick="jump('${songsPage.pageNumber + 1 > songsPage.totalPage ? songsPage.totalPage : songsPage.pageNumber + 1}${empty queryName ? "" : "&q="}${queryName}')">下一页</a></li>
                        <li> <a href="javascript:;" onclick="jump('${(songsPage.totalPage == '' || songsPage.totalPage == null) ? 1 : songsPage.totalPage}${empty queryName ? '' : '&q='}${queryName}')">末页</a></li>
                        <span style="color: crimson; padding-left: 50px;">共 ${(songsPage.totalPage == '' || songsPage.totalPage == null) ? 1 : songsPage.totalPage} 页 , 共 ${(songsPage.totalRow == "" || songsPage.totalRow == null) ? 0 : songsPage.totalRow} 条数据</span>
                    </ul>
                </div>
            </td>
        </tr>
    </tbody>
</table>
</body>
</html>
<script type="text/javascript">
    $(function () {
        var queryName = $('#queryName').val();
        if(queryName != null && queryName != ''){
            var array = ['songs','album','singers'];
            for(var i = 0; i  < array.length; i++){
                var id = $('#'+array[i]).attr('id');
                var checked = $('#'+array[i]).is(':checked');
                if (checked)
                    $('.' + id + 'Span1').show().next().hide();
                else
                    $('.' + id + 'Span1').hide().next().show();
            }
        }
    })

    function playMusic(data) {
        var id = data.substr(data.lastIndexOf('=') + 1, data.length);
        var prefix = '//music.163.com/outchain/player?type=2&id=';
        var suffix = '&auto=1&height=66';
        var url = prefix + id + suffix;
        $('#music').attr('src', url);
    }

    function jump(url) {
        var songs = $('#songs').attr('checked');
        var album = $('#album').attr('checked');
        var singers = $('#singers').attr('checked');
        var baseUrl = "/music/listSongs?p=" + url;
        if (songs == 'checked') baseUrl += '&songs=on';
        if (album == 'checked') baseUrl += '&album=on';
        if (singers == 'checked') baseUrl += '&singers=on';
        location.href = baseUrl;
    }

    function showColor(condition) {
        var id = $(condition).attr('id');
        var checked = $(condition).is(':checked');
        if (checked)
            $('.' + id + 'Span1').show().next().hide();
        else
            $('.' + id + 'Span1').hide().next().show();
    }
</script>