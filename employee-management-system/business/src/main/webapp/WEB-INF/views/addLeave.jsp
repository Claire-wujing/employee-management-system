<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>请假申请</title>
    <style>
        /* CSS变量 */
        :root {
            --first-color: #1E88E5;
            --second-color: #42A5F5;
            --form-bg-color: #E3F2FD; /* 表单浅蓝色背景 */
            --white-color: #FFF;
            --border-color: #1565C0; /* 深蓝色边框 */
            --page-bg-color: #f5f5f5; /* 页面背景色 */
            --error-color: #ff4444;
        }

        body {
            margin: 0;
            padding: 2rem;
            min-height: 100vh;
            background-color: var(--page-bg-color);
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-container {
            background-color: var(--form-bg-color);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 600px;
            padding: 30px;
            border: 2px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .form-title {
            color: var(--border-color);
            text-align: center;
            margin-bottom: 25px;
            font-size: 24px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--border-color);
            font-weight: 600;
        }

        .input-group input,
        .input-group select,
        .input-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--border-color);
            border-radius: 5px;
            font-size: 16px;
            background-color: var(--white-color);
            transition: border-color 0.3s;
        }

        .input-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .input-group input:focus,
        .input-group select:focus,
        .input-group textarea:focus {
            outline: none;
            border-color: var(--first-color);
        }

        .date-group {
            display: flex;
            gap: 15px;
        }

        .date-group .input-group {
            flex: 1;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit {
            background-color: var(--first-color);
            color: var(--white-color);
        }

        .btn-submit:hover {
            background-color: var(--border-color);
        }

        .btn-back {
            background-color: var(--white-color);
            color: var(--border-color);
            border: 2px solid var(--border-color);
            text-decoration: none;
            text-align: center;
            line-height: 20px;
        }

        .btn-back:hover {
            background-color: #e0e0e0;
        }

        .error-message {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2 class="form-title">请假申请</h2>
    <form action="${pageContext.request.contextPath}/leave/doAddLeave" method="post" onsubmit="return validateForm()">
        <input type="hidden" id="employeeId" name="employeeId" value="${employee.employeeId}">

        <div class="input-group">
            <label for="leaveType">请假类型</label>
            <select id="leaveType" name="leaveType" required>
                <option value="">---请选择---</option>
                <option value="0">病假</option>
                <option value="1">事假</option>
                <option value="2">年假</option>
            </select>
            <div class="error-message" id="typeError"></div>
        </div>

        <div class="date-group">
            <div class="input-group">
                <label for="startDate">请假开始时间</label>
                <input type="datetime-local" id="startDate" name="startDate" required>
                <div class="error-message" id="startError"></div>
            </div>

            <div class="input-group">
                <label for="endDate">请假结束时间</label>
                <input type="datetime-local" id="endDate" name="endDate" required>
                <div class="error-message" id="endError"></div>
            </div>
        </div>

        <div class="input-group">
            <label for="reason">请假事由</label>
            <textarea id="reason" name="reason" rows="6"></textarea>
            <div class="error-message" id="reasonError"></div>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">提交申请</button>
            <a href="${pageContext.request.contextPath}/leave/employeeLeave" class="btn btn-back">返回请假列表</a>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        let isValid = true;

        // 验证请假类型
        const leaveType = document.getElementById('leaveType').value;
        if (leaveType === '') {
            document.getElementById('typeError').textContent = '请选择请假类型';
            document.getElementById('typeError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('typeError').style.display = 'none';
        }

        // 验证开始时间
        const startDate = document.getElementById('startDate').value;
        if (startDate === '') {
            document.getElementById('startError').textContent = '请选择开始时间';
            document.getElementById('startError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('startError').style.display = 'none';
        }

        // 验证结束时间
        const endDate = document.getElementById('endDate').value;
        if (endDate === '') {
            document.getElementById('endError').textContent = '请选择结束时间';
            document.getElementById('endError').style.display = 'block';
            isValid = false;
        } else if (new Date(endDate) <= new Date(startDate)) {
            document.getElementById('endError').textContent = '结束时间必须晚于开始时间';
            document.getElementById('endError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('endError').style.display = 'none';
        }

        // 验证请假事由
        const reason = document.getElementById('reason').value.trim();
        if (reason === '') {
            document.getElementById('reasonError').textContent = '请输入请假事由';
            document.getElementById('reasonError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('reasonError').style.display = 'none';
        }

        return isValid;
    }
</script>
</body>
</html>