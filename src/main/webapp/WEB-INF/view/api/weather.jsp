<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${pageContext.request.contextPath}/css/api/weather.css" rel="stylesheet">
<div class="wrapper shadow">
    <div class="top">
        <div id="todayDesc">
            <img id="big" src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
        </div>
        <p id="deg" class="text deg"></p>
        <div class="text-city">
            <span class="">输入城市：</span>
            <input type="text" id="city" value="">
            <span id="degTips"></span>
        </div>
    </div>
    <div class="bot">
        <ul>
            <li>
                <h1 id="forecast0"></h1>
                <img id="forecastimg0"
                     src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
                <p id="forecastdeg0"></p>
            </li>
            <li>
                <h1 id="forecast1"></h1>
                <img id="forecastimg1"
                     src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
                <p id="forecastdeg1"></p>
            </li>
            <li>
                <h1 id="forecast2"></h1>
                <img id="forecastimg2"
                     src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
                <p id="forecastdeg2"></p>
            </li>
            <li>
                <h1 id="forecast3"></h1>
                <img id="forecastimg3"
                     src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
                <p id="forecastdeg3"></p>
            </li>
            <li>
                <h1 id="forecast4"></h1>
                <img id="forecastimg4"
                     src="http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg" alt="">
                <p id="forecastdeg4"></p>
            </li>
        </ul>
    </div>
</div>
</body>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
<script>
    var selectedCity = "";
    var unit = "c";
    $(function () {
        $("#city").val("NO CITY FOUND");
        selectedCity = remote_ip_info["city"];
        getWeather();
    })

    $('#city').keypress(function () {
        if (event.which == 13) {
            selectedCity = $('#city').val();
            getWeather();
            $('#city').blur();
        }
    });

    function getWeather(){
        $.ajax({
            async: false,
            type: "POST",
            url: "${pageContext.request.contextPath}/api/weather",
            data: {
                city: selectedCity
            },
            dataType: "JSON",
            success: function (result) {
                if (result.status == 200) {
                    $('#city').val(selectedCity);
                    $('#degTips').text(result.data.wendu + " °" + unit.toUpperCase());
                    setImage(result.data.forecast[0].type, $("#big")[0]);
                    for (var i = 0; i <= 4; i++) {
                        var fc = result.data.forecast[i];
                        $('#forecast' + i).html(fc.date);
                        setImage(fc.type, $("#forecastimg" + i)[0]);
                        $("#forecastimg" + i).attr("title", "天气:" + fc.type + ",风向:" + fc.fengxiang + ",风力:" + fc.fengli);
                        $('#forecastdeg' + i).html(fc.low + " ~ " + fc.high);
                    }
                } else {
                    $('#big').attr("src", "http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg");
                    $('#city').val("No city found");
                    $('#degTips').text("");
                    for (var i = 0; i <= 4; i++) {
                        $('#forecast' + i).html("");
                        $("#forecastimg" + i).attr("src", "http://www.hubwiz.com/course/55a60445a164dd0d75929fbd/images/icons/Compass.svg");
                        $('#forecastdeg' + i).html("");
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    $('#city').focus(function (event) {
        placeholder = $("#city").val();
        $("#city").val("");
        $('#city').css("border-bottom", "1px solid #F5F8FC");
    });

    $('#city').blur(function (event) {
        if ($("#city").val() == "") {
            $("#city").val(placeholder);
        }
    });

    function setImage(type, image) {
        image.src = "${pageContext.request.contextPath}/images/weather/";
        switch (type) {
            case '晴':
                image.src += 'qing.svg';
                break;
            case '多云':
                image.src += 'duoyun.svg';
                break;
            case '阵雨':
                image.src += 'baofengyu.svg';
                break;
            case '雷阵雨':
                image.src += 'baofengyu.svg';
                break;
            case '阴':
                image.src += 'yin.svg';
                break;
            case '小雨':
                image.src += 'yu.svg';
                break;
            case '小到中雨':
                image.src += 'yu.svg';
                break;
            case '中雨':
                image.src += 'yu.svg';
                break;
            case '中到大雨':
                image.src += 'baofengyu.svg';
                break;
        }
    }
</script>
</html>
