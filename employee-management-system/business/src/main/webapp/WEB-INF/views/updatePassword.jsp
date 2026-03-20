<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>更改密码</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #3498db;
            --primary-light: #5dade2;
            --primary-dark: #2874a6;
            --success: #2ecc71;
            --danger: #e74c3c;
            --light-bg: #f5f9fc;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        body {
            background: linear-gradient(135deg, var(--primary-light), var(--primary-dark));
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .password-change-container {
            width: 100%;
            max-width: 450px;
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            padding: 40px 30px;
            position: relative;
            animation: cardIn 0.6s ease-out;
        }

        .password-change-container:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary), var(--success));
        }

        .password-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .password-header i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 15px;
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .password-header h2 {
            font-size: 1.8rem;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .password-header p {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            padding-left: 10px;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1.2rem;
        }

        input[type="password"] {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: 1px solid #ddd;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: #f8fbfe;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        input[type="password"]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .password-strength {
            height: 4px;
            background: #eee;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
            position: relative;
        }

        .strength-meter {
            height: 100%;
            width: 0;
            background: var(--danger);
            border-radius: 2px;
            transition: var(--transition);
        }

        .password-requirements {
            margin-top: 5px;
            font-size: 0.8rem;
            color: var(--text-light);
        }

        .submit-button {
            width: 100%;
            padding: 15px;
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(41, 128, 185, 0.4);
        }

        .submit-button:active {
            transform: translateY(-1px);
        }

        .password-footer {
            margin-top: 25px;
            text-align: center;
            font-size: 0.9rem;
            color: var(--text-light);
        }

        .password-footer a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
        }

        .password-footer a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        /* 动画效果 */
        @keyframes cardIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 响应式设计 */
        @media (max-width: 576px) {
            .password-change-container {
                padding: 30px 20px;
            }

            .password-header h2 {
                font-size: 1.6rem;
            }

            input[type="password"] {
                padding: 12px 12px 12px 45px;
            }
        }
    </style>
</head>
<body>
<div class="password-change-container">
    <div class="password-header">
        <i class="fas fa-lock"></i>
        <h2>更改密码</h2>
        <p>为了您的账户安全，请定期更改密码</p>
    </div>

    <form action="${pageContext.request.contextPath}/user/doUpdatePassword" method="post" id="passwordForm">
        <div class="form-group">
            <label for="currentPassword">当前密码</label>
            <div class="input-with-icon">
                <i class="fas fa-key"></i>
                <input type="password" id="currentPassword" name="currentPassword" minlength="6" required placeholder="请输入当前密码">
            </div>
        </div>

        <div class="form-group">
            <label for="newPassword">新密码</label>
            <div class="input-with-icon">
                <i class="fas fa-lock"></i>
                <input type="password" id="newPassword" name="newPassword" minlength="6" required placeholder="请输入新密码">
            </div>
            <div class="password-strength">
                <div class="strength-meter" id="strengthMeter"></div>
            </div>
            <div class="password-requirements">
                密码至少包含6个字符（建议使用字母、数字和符号组合）
            </div>
        </div>

        <div class="form-group">
            <label for="confirmPassword">确认新密码</label>
            <div class="input-with-icon">
                <i class="fas fa-lock"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" required placeholder="请再次输入新密码">
            </div>
            <div id="passwordMatch" class="password-requirements"></div>
        </div>

        <button type="submit" class="submit-button">
            <i class="fas fa-sync-alt"></i> 更新密码
        </button>
    </form>

    <div class="password-footer">
        <p>忘记密码？<a href="#">点击这里重置</a></p>
    </div>
</div>

<script>
    // 密码强度检测
    const newPasswordInput = document.getElementById('newPassword');
    const strengthMeter = document.getElementById('strengthMeter');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const passwordMatch = document.getElementById('passwordMatch');

    newPasswordInput.addEventListener('input', function() {
        const password = this.value;
        let strength = 0;

        if (password.length >= 6) strength += 25;
        if (/[A-Z]/.test(password)) strength += 25;
        if (/[0-9]/.test(password)) strength += 25;
        if (/[^A-Za-z0-9]/.test(password)) strength += 25;

        strengthMeter.style.width = strength + '%';

        if (strength < 50) {
            strengthMeter.style.background = '#e74c3c';
        } else if (strength < 75) {
            strengthMeter.style.background = '#f39c12';
        } else {
            strengthMeter.style.background = '#2ecc71';
        }
    });

    // 密码匹配检测
    confirmPasswordInput.addEventListener('input', function() {
        if (newPasswordInput.value !== this.value && this.value.length > 0) {
            passwordMatch.textContent = "两次输入的密码不匹配";
            passwordMatch.style.color = '#e74c3c';
        } else if (this.value.length > 0) {
            passwordMatch.textContent = "密码匹配";
            passwordMatch.style.color = '#2ecc71';
        } else {
            passwordMatch.textContent = "";
        }
    });

    // 表单提交验证
    document.getElementById('passwordForm').addEventListener('submit', function(e) {
        if (newPasswordInput.value !== confirmPasswordInput.value) {
            e.preventDefault();
            passwordMatch.textContent = "两次输入的密码不匹配";
            passwordMatch.style.color = '#e74c3c';
            confirmPasswordInput.focus();
        }
    });

    // 错误消息提示
    <% if (request.getAttribute("Message") != null) { %>
    window.onload = function() {
        setTimeout(function() {
            alert('<%= request.getAttribute("Message") %>');
        }, 500);
    };
    <% } %>
</script>
</body>
</html>