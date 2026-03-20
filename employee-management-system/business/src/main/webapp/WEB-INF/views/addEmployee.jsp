<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加员工</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        /* CSS变量 */
        :root {
            --first-color: #78aee1;
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
            width: 400px;
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
            position: relative;
        }

        .input-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--border-color);
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 2px solid var(--border-color);
            border-radius: 5px;
            font-size: 16px;
            background-color: var(--white-color);
            transition: border-color 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus {
            outline: none;
            border-color: var(--first-color);
        }

        .input-group select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: url('data:image/svg+xml;utf8,<svg fill="%231565C0" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>') no-repeat right 12px center;
            background-size: 15px;
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
    <h2 class="form-title">添加员工</h2>
    <form action="${pageContext.request.contextPath}/employee/addEmployee" method="post" onsubmit="return validateForm()">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" id="employeeName" name="employeeName" placeholder="员工姓名" required>
            <div class="error-message" id="nameError"></div>
        </div>

        <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="text" id="phone" name="phone" placeholder="电话">
            <div class="error-message" id="phoneError"></div>
        </div>

        <div class="input-group">
            <i class="fas fa-building"></i>
            <select id="department" name="departmentId" required>
                <option value="">请选择部门</option>
                <c:forEach items="${departmentList}" var="department">
                    <option value="${department.departmentId}">${department.departmentName}</option>
                </c:forEach>
            </select>
            <div class="error-message" id="deptError"></div>
        </div>

        <div class="input-group">
            <i class="fas fa-calendar-alt"></i>
            <input type="date" id="hireDate" name="hireDate" required>
            <div class="error-message" id="dateError"></div>
        </div>

        <div class="input-group">
            <i class="fas fa-briefcase"></i>
            <select id="position" name="positionId" required>
                <option value="">请选择岗位</option>
                <c:forEach items="${positionList}" var="position">
                    <option value="${position.positionId}">${position.positionName}</option>
                </c:forEach>
            </select>
            <div class="error-message" id="positionError"></div>
        </div>

        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" id="email" name="email" placeholder="邮箱" required>
            <div class="error-message" id="emailError"></div>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">添加员工</button>
            <button type="button" class="btn btn-back" onclick="historyBack()">返回</button>
        </div>
    </form>
</div>

<script>
    function historyBack() {
        window.history.back();
    }

    function validateForm() {
        let isValid = true;

        // 验证员工姓名
        const name = document.getElementById('employeeName').value.trim();
        if (name === '') {
            document.getElementById('nameError').textContent = '请输入员工姓名';
            document.getElementById('nameError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('nameError').style.display = 'none';
        }

        // 验证部门选择
        const department = document.getElementById('department').value;
        if (department === '') {
            document.getElementById('deptError').textContent = '请选择部门';
            document.getElementById('deptError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('deptError').style.display = 'none';
        }

        // 验证入职日期
        const hireDate = document.getElementById('hireDate').value;
        if (hireDate === '') {
            document.getElementById('dateError').textContent = '请选择入职日期';
            document.getElementById('dateError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('dateError').style.display = 'none';
        }

        // 验证岗位选择
        const position = document.getElementById('position').value;
        if (position === '') {
            document.getElementById('positionError').textContent = '请选择岗位';
            document.getElementById('positionError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('positionError').style.display = 'none';
        }

        // 验证邮箱格式
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email === '') {
            document.getElementById('emailError').textContent = '请输入邮箱';
            document.getElementById('emailError').style.display = 'block';
            isValid = false;
        } else if (!emailRegex.test(email)) {
            document.getElementById('emailError').textContent = '请输入有效的邮箱地址';
            document.getElementById('emailError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('emailError').style.display = 'none';
        }

        return isValid;
    }
</script>
</body>
</html>