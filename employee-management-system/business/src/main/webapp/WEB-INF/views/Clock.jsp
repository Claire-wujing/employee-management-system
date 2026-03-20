<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>考勤打卡</title>
    <link rel="stylesheet" href="https://www.layuicdn.com/layui/css/layui.css" media="all">
</head>
<style>
    html, body {
        height: 100%;
        text-align: center;
    }

    #time {
        font-size: 16px;
        color: #1e9fff;
        font-weight: bold;
        margin: 10px;
    }

    #signbtn {
        margin: 50px auto;
        width: 140px;
        height: 140px;
        border-radius: 50%;
        box-shadow: 0px 0px 8px #25a4ff;
        font-size: 20px;
    }

    /* 新增打卡成功提示样式 */
    .success-message {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 20px 40px;
        background-color: #e6f7ff;
        border: 2px solid #1e88e5;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        z-index: 9999;
        font-size: 18px;
        color: #333;
        display: none;
    }

    /* 错误消息样式 */
    #error-message {
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        padding: 10px 20px;
        background-color: #fff2f0;
        border: 1px solid #ffccc7;
        border-radius: 4px;
        z-index: 9999;
        color: #f5222d;
        display: none;
    }
</style>
<body>

<% if (request.getAttribute("message") != null) { %>
<div id="error-message"><%= request.getAttribute("message") %></div>
<% } %>

<!-- 新增打卡成功提示框 -->
<div id="successMessage" class="success-message"></div>

<div id="box">
    <div id='time'>米粒企业管理系统</div>
    <button id='signbtn' class="layui-btn layui-btn-normal">签到打卡</button>

    <form id="add" action="${pageContext.request.contextPath}/attendance/addClock" method="post">
        <input type="hidden" id="date" name="date" value="">
        <input type="hidden" id="checkInTime" name="checkInTime" value="">
        <input type="hidden" id="checkOutTime" name="checkOutTime" value="">
        <input type="hidden" id="state" name="state" value="">
    </form>
</div>

<script>
    window.onload = function () {
        var errorMessage = document.getElementById('error-message');
        if (errorMessage) {
            errorMessage.style.display = 'block';
            setTimeout(function() {
                errorMessage.style.display = 'none';
            }, 3000);
        }
    };
</script>

<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="https://www.layuicdn.com/layui/layui.js" charset="utf-8"></script>
<script src="https://cdn.bootcss.com/layer/2.3/layer.js"></script>

<script type="text/javascript">
    // 获取当前日期
    var currentDate = new Date().toISOString().slice(0, 10); // 格式为 YYYY-MM-DD
    var clickCount = 0;

    $("#signbtn").click(function () {
        clickCount++;
        var currentTime = new Date().toLocaleTimeString(); // 获取当前时间

        if(clickCount === 1){
            // 显示上班打卡成功提示
            showSuccessMessage("上班打卡成功！");
            document.getElementById('date').value = currentDate;
            document.getElementById('checkInTime').value = currentTime;
        }
        else if(clickCount === 2){
            // 显示下班打卡成功提示
            showSuccessMessage("下班打卡成功！");
            document.getElementById('checkOutTime').value = currentTime;

            var checkInTime = document.getElementById('checkInTime').value;
            var state = 0;

            // 判断是否迟到或早退
            if (checkInTime > '09:00:00') {
                state = 1; // 迟到
            }
            if (currentTime < '17:00:00') {
                state = 2; // 早退
            }

            document.getElementById('state').value = state;
            document.getElementById('add').submit();
        }
        else if(clickCount >= 3){
            layer.msg("今天已经打过两次卡了");
        }
    });

    // 显示成功消息函数
    function showSuccessMessage(message) {
        var successDiv = document.getElementById('successMessage');
        successDiv.textContent = message;
        successDiv.style.display = 'block';

        // 3秒后自动隐藏
        setTimeout(function() {
            successDiv.style.display = 'none';
        }, 3000);
    }
</script>

<script>
    setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());", 1000);
</script>

</body>
</html>