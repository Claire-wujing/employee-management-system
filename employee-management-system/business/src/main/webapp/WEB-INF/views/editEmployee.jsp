<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑员工</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3498db;
            --primary-light: #5dade2;
            --primary-dark: #2874a6;
            --light-blue: #e8f4fd;
            --blue-bg: #e3f2ff;
            --white: #ffffff;
            --dark: #2c3e50;
            --success: #2ecc71;
            --warning: #f39c12;
            --error: #e74c3c;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #e3f2ff, #d1e7ff);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--dark);
        }

        .container {
            max-width: 600px;
            width: 100%;
            margin: 0 auto;
        }

        .edit-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
            position: relative;
            border: 2px solid var(--primary-light);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .card-header::before {
            content: "";
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }

        .card-header::after {
            content: "";
            position: absolute;
            bottom: -80px;
            left: -30px;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.07);
            border-radius: 50%;
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .card-content {
            padding: 30px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            flex: 1;
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-label i {
            font-size: 1.2rem;
            min-width: 25px;
        }

        .form-input {
            width: 100%;
            padding: 14px 20px 14px 45px;
            border: 2px solid #d6e9ff;
            border-radius: 12px;
            font-size: 1.1rem;
            transition: var(--transition);
            background: var(--light-blue);
            color: var(--dark);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 42px;
            color: var(--primary);
            font-size: 1.2rem;
        }

        .form-select {
            width: 100%;
            padding: 14px 20px 14px 45px;
            border: 2px solid #d6e9ff;
            border-radius: 12px;
            font-size: 1.1rem;
            transition: var(--transition);
            background: var(--light-blue);
            color: var(--dark);
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%233498db" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 15px;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .status-toggle {
            display: flex;
            align-items: center;
            gap: 15px;
            background: var(--light-blue);
            border-radius: 12px;
            padding: 14px 20px;
            border: 2px solid #d6e9ff;
        }

        .toggle-label {
            font-weight: 600;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 30px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--success);
        }

        input:focus + .slider {
            box-shadow: 0 0 1px var(--success);
        }

        input:checked + .slider:before {
            transform: translateX(30px);
        }

        .status-text {
            font-weight: 600;
            margin-left: 10px;
            min-width: 40px;
        }

        .status-active {
            color: var(--success);
        }

        .status-inactive {
            color: var(--error);
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn i {
            font-size: 1.2rem;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--primary-light));
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(41, 128, 185, 0.4);
        }

        .btn-secondary {
            background: #f8f9fa;
            color: var(--primary-dark);
            border: 2px solid #d6e9ff;
        }

        .btn-secondary:hover {
            background: #edf7ff;
            transform: translateY(-3px);
        }

        .employee-id {
            text-align: center;
            margin-top: 15px;
            font-size: 0.9rem;
            color: #7f8c8d;
            padding-top: 15px;
            border-top: 1px dashed #d6e9ff;
        }

        .info-item {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 15px;
            }

            .card-header {
                padding: 25px 20px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .card-content {
                padding: 25px 20px;
            }

            .button-group {
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="edit-card">
        <div class="card-header">
            <h1>
                <i class="fas fa-user-edit"></i>
                编辑员工信息
            </h1>
        </div>

        <div class="card-content">
            <form action="${pageContext.request.contextPath}/employee/doUpdateEmployee" method="post" onsubmit="return validateForm()">
                <input type="hidden" id="employeeId" name="employeeId" value="${employee.employeeId}">

                <div class="form-row">
                    <div class="form-group">
                        <label for="employeeName" class="form-label">
                            <i class="fas fa-user"></i> 员工姓名
                        </label>
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="employeeName" name="employeeName"
                               value="${employee.employeeName}"
                               class="form-input"
                               placeholder="请输入员工姓名"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">
                            <i class="fas fa-phone"></i> 联系电话
                        </label>
                        <i class="fas fa-phone input-icon"></i>
                        <input type="text" id="phone" name="phone"
                               value="${employee.phone}"
                               class="form-input"
                               placeholder="请输入联系电话">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="department" class="form-label">
                            <i class="fas fa-building"></i> 所属部门
                        </label>
                        <i class="fas fa-building input-icon"></i>
                        <select id="department" name="departmentId" class="form-select" required>
                            <option value="">请选择部门</option>
                            <c:forEach items="${departmentList}" var="department">
                                <option value="${department.departmentId}" ${employee.departmentId == department.departmentId ? 'selected' : ''}>
                                        ${department.departmentName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="position" class="form-label">
                            <i class="fas fa-briefcase"></i> 工作岗位
                        </label>
                        <i class="fas fa-briefcase input-icon"></i>
                        <select id="position" name="positionId" class="form-select" required>
                            <option value="">请选择岗位</option>
                            <c:forEach items="${positionList}" var="position">
                                <option value="${position.positionId}" ${employee.positionId == position.positionId ? 'selected' : ''}>
                                        ${position.positionName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="hireDate" class="form-label">
                            <i class="fas fa-calendar-alt"></i> 入职日期
                        </label>
                        <i class="fas fa-calendar-alt input-icon"></i>
                        <input type="date" id="hireDate" name="hireDate"
                               value="<fmt:formatDate value='${employee.hireDate}' pattern='yyyy-MM-dd'/>"
                               class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i> 电子邮箱
                        </label>
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email"
                               value="${employee.email}"
                               class="form-input"
                               placeholder="请输入电子邮箱"
                               required>
                    </div>
                </div>

                <!-- 状态栏 -->
                <div class="form-row">
                    <div class="form-group">
                        <div class="status-toggle">
                            <label class="toggle-label">
                                <i class="fas fa-toggle-on"></i> 员工状态
                            </label>
                            <label class="toggle-switch">
                                <input type="checkbox" id="status" name="status" ${employee.status == 1 ? 'checked' : ''} value="1">
                                <span class="slider"></span>
                            </label>
                            <span id="statusText" class="status-text ${employee.status == 1 ? 'status-active' : 'status-inactive'}">
                                ${employee.status == 1 ? '正常' : '停用'}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> 更新员工信息
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="historyBack()">
                        <i class="fas fa-arrow-left"></i> 返回
                    </button>
                </div>

                <div class="employee-id">
                    <div class="info-item">
                        <i class="fas fa-id-card"></i>
                        员工ID: ${employee.employeeId}
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function historyBack() {
        window.history.back();
    }

    function validateForm() {
        var employeeName = document.getElementById('employeeName').value;
        var email = document.getElementById('email').value;

        if (employeeName.trim() === '') {
            alert("员工姓名不能为空，请重新输入。");
            return false;
        }

        if (email.trim() === '') {
            alert("电子邮箱不能为空，请重新输入。");
            return false;
        }

        return confirm("确定要更新该员工信息吗？");
    }

    // 添加输入框动画效果
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.form-input, .form-select');

        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // 状态切换功能
        const statusToggle = document.getElementById('status');
        const statusText = document.getElementById('statusText');

        statusToggle.addEventListener('change', function() {
            if (this.checked) {
                statusText.textContent = '正常';
                statusText.className = 'status-text status-active';
            } else {
                statusText.textContent = '停用';
                statusText.className = 'status-text status-inactive';
            }
        });
    });
</script>
</body>
</html>