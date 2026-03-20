<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑部门</title>
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
            max-width: 500px;
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

        .form-group {
            margin-bottom: 25px;
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
        }

        .form-input {
            width: 100%;
            padding: 14px 20px;
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

        .hidden-input {
            display: none;
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

        .department-info {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            font-size: 0.9rem;
            color: #7f8c8d;
            padding-top: 15px;
            border-top: 1px dashed #d6e9ff;
        }

        .info-item {
            display: flex;
            align-items: center;
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

        @media (max-width: 576px) {
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
                <i class="fas fa-building"></i>
                编辑部门信息
            </h1>
        </div>

        <div class="card-content">
            <form action="${pageContext.request.contextPath}/department/doUpdateDepartment" method="post" onsubmit="return confirmUpdatePosition();">
                <div class="form-group">
                    <label for="departmentName" class="form-label">
                        <i class="fas fa-signature"></i> 部门名称
                    </label>
                    <input type="text" id="departmentName" name="departmentName"
                           value="${department.departmentName}"
                           class="form-input"
                           placeholder="请输入部门名称"
                           required>
                </div>

                <div class="form-group">
                    <label for="departmentCode" class="form-label">
                        <i class="fas fa-code"></i> 部门编码
                    </label>
                    <input type="text" id="departmentCode" name="departmentCode"
                           value="${department.departmentCode}"
                           class="form-input"
                           placeholder="请输入部门编码"
                           required>
                </div>

                <input type="hidden" name="departmentId" value="${department.departmentId}">

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> 更新部门
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="historyBack()">
                        <i class="fas fa-arrow-left"></i> 返回
                    </button>
                </div>

                <div class="department-info">
                    <div class="info-item">
                        <i class="fas fa-calendar-alt"></i>
                        最后更新: <fmt:formatDate value="${department.updateTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-user"></i>
                        操作人: ${department.operator}
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

    function confirmUpdatePosition() {
        var departmentName = document.getElementById('departmentName').value;
        var departmentCode = document.getElementById('departmentCode').value;

        if (departmentName.trim() === '' || departmentCode.trim() === '') {
            alert("部门名称和部门编码不能为空，请重新输入。");
            return false;
        }

        return confirm("确定要更新这个部门信息吗？");
    }

    // 添加输入框动画效果
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.form-input');

        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    });
</script>
</body>
</html>