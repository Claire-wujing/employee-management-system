<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑岗位</title>
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

        .status-badge {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            margin-left: 10px;
        }

        .status-normal {
            background-color: rgba(46, 204, 113, 0.2);
            color: #27ae60;
        }

        .status-abnormal {
            background-color: rgba(231, 76, 60, 0.2);
            color: #c0392b;
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

        .position-id {
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
                <i class="fas fa-user-tag"></i>
                编辑岗位信息
            </h1>
        </div>

        <div class="card-content">
            <form action="${pageContext.request.contextPath}/position/doUpdatePosition" method="post" onsubmit="return confirmUpdatePosition()">
                <input type="hidden" name="positionId" value="${position.positionId}">

                <div class="form-group">
                    <label for="positionName" class="form-label">
                        <i class="fas fa-signature"></i> 岗位名称
                    </label>
                    <i class="fas fa-signature input-icon"></i>
                    <input type="text" id="positionName" name="positionName"
                           value="${position.positionName}"
                           class="form-input"
                           placeholder="请输入岗位名称"
                           required>
                </div>

                <div class="form-group">
                    <label for="code" class="form-label">
                        <i class="fas fa-code"></i> 岗位编码
                    </label>
                    <i class="fas fa-code input-icon"></i>
                    <input type="text" id="code" name="code"
                           value="${position.code}"
                           class="form-input"
                           placeholder="请输入岗位编码"
                           required>
                </div>

                <div class="form-group">
                    <label for="status" class="form-label">
                        <i class="fas fa-toggle-on"></i> 完成状态
                    </label>
                    <i class="fas fa-toggle-on input-icon"></i>
                    <select id="status" name="status" class="form-select" required>
                        <option value="0" ${position.status == 0 ? 'selected' : ''}>
                            异常
                            <c:if test="${position.status == 0}">
                                <span class="status-badge status-abnormal">当前状态</span>
                            </c:if>
                        </option>
                        <option value="1" ${position.status == 1 ? 'selected' : ''}>
                            正常
                            <c:if test="${position.status == 1}">
                                <span class="status-badge status-normal">当前状态</span>
                            </c:if>
                        </option>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-sync-alt"></i> 更新岗位
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="historyBack()">
                        <i class="fas fa-arrow-left"></i> 返回
                    </button>
                </div>

                <div class="position-id">
                    <div class="info-item">
                        <i class="fas fa-fingerprint"></i>
                        岗位ID: ${position.positionId}
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
        var positionName = document.getElementById('positionName').value;
        var positionCode = document.getElementById('code').value;

        if (positionName.trim() === '' || positionCode.trim() === '') {
            alert("岗位名称和岗位编码不能为空，请重新输入。");
            return false;
        }

        return confirm("确定要更新这个岗位吗？");
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
    });
</script>
</body>
</html>