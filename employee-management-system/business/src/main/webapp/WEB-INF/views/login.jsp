<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>米粒科技 - 员工管理系统</title>
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
            --secondary: #2ecc71;
            --accent: #f39c12;
            --light-bg: #e6f2ff;
            --dark-bg: #0d47a1;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            --transition: all 0.3s ease;
            --error: #e74c3c;
        }

        body {
            background: linear-gradient(135deg, var(--primary-light), var(--dark-bg));
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--text-dark);
            overflow-x: hidden;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            display: flex;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            height: 600px;
            position: relative;
        }

        /* 左侧图片区域 */
        .image-section {
            flex: 1;
            background: linear-gradient(rgba(41, 128, 185, 0.7), rgba(13, 71, 161, 0.8)),
            url('https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 40px;
            color: white;
            position: relative;
        }

        .company-info {
            z-index: 2;
        }

        .company-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .logo-icon {
            font-size: 36px;
            background: rgba(255, 255, 255, 0.2);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .company-name {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .slogan {
            font-size: 18px;
            margin-top: 10px;
            opacity: 0.9;
            max-width: 400px;
        }

        .features {
            margin-top: 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .feature-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .feature-text {
            font-size: 16px;
        }

        .copyright {
            font-size: 14px;
            opacity: 0.8;
            margin-top: 30px;
        }

        /* 右侧登录区域 */
        .login-section {
            width: 40%;
            background: var(--card-bg);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-container {
            width: 100%;
            max-width: 350px;
            margin: 0 auto;
        }

        .login-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-title h2 {
            font-size: 28px;
            color: var(--primary-dark);
            margin-bottom: 10px;
        }

        .login-title p {
            color: var(--text-light);
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            font-size: 18px;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            font-size: 18px;
            cursor: pointer;
            transition: var(--transition);
        }

        .password-toggle:hover {
            color: var(--primary);
        }

        .form-control {
            width: 100%;
            padding: 15px 50px 15px 50px;
            border: 1px solid #ddd;
            border-radius: 50px;
            font-size: 16px;
            transition: var(--transition);
            background: #f9fbfd;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .btn {
            width: 100%;
            padding: 15px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            margin-top: 30px;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }

        .security-note {
            text-align: center;
            margin-top: 20px;
            color: var(--text-light);
            font-size: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .system-status {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 15px;
            font-size: 12px;
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #2ecc71;
        }

        /* 响应式设计 */
        @media (max-width: 900px) {
            .container {
                flex-direction: column;
                height: auto;
                max-width: 600px;
            }

            .image-section {
                padding: 30px 20px;
                min-height: 300px;
            }

            .login-section {
                width: 100%;
                padding: 40px 20px;
            }

            .company-info {
                text-align: center;
            }

            .company-logo {
                justify-content: center;
            }

            .slogan {
                margin: 10px auto 0;
            }

            .features {
                margin-top: 30px;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }

            .feature {
                width: 45%;
            }
        }

        @media (max-width: 576px) {
            .feature {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 左侧图片区域 -->
    <div class="image-section">
        <div class="company-info">
            <div class="company-logo">
                <div class="logo-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="company-name">米粒科技有限公司</div>
            </div>
            <div class="slogan">高效 · 智能 · 安全的员工管理解决方案</div>

            <div class="features">
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="feature-text">高效人力资源管理</div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="feature-text">银行级数据安全</div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="feature-text">智能数据分析</div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <div class="feature-text">多平台支持</div>
                </div>
            </div>
        </div>

        <div class="copyright">
            © 2023 米粒科技有限公司 版权所有
        </div>
    </div>

    <!-- 右侧登录区域 -->
    <div class="login-section">
        <div class="login-container">
            <div class="login-title">
                <h2>企业员工管理系统</h2>
                <p>请登录您的账户</p>
            </div>

            <form id="login-form" action="${pageContext.request.contextPath}/user/doLogin" method="post">
                <div class="form-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" name="username" class="form-control" placeholder="用户名/工号" required>
                </div>

                <div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <i class="fas fa-eye password-toggle" id="toggle-password"></i>
                    <input type="password" name="password" id="password" class="form-control" placeholder="密码" minlength="6" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt"></i> 登录系统
                </button>
            </form>

            </div>
        </div>
    </div>
</div>

<script>
    // 密码可见性切换功能
    const passwordToggle = document.getElementById('toggle-password');
    const passwordInput = document.getElementById('password');

    passwordToggle.addEventListener('click', () => {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            passwordToggle.classList.remove('fa-eye');
            passwordToggle.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            passwordToggle.classList.remove('fa-eye-slash');
            passwordToggle.classList.add('fa-eye');
        }
    });

    // 表单提交时验证
    document.getElementById('login-form').addEventListener('submit', function(e) {
        const username = this.username.value.trim();
        const password = this.password.value.trim();

        if (!username || !password) {
            e.preventDefault();
            alert("请输入用户名和密码");
            return;
        }
    });

    // 登录失败提示
    window.onload = function () {
        const errorMessage = "${requestScope.error}";
        if (errorMessage) {
            setTimeout(() => {
                alert("登录失败: 密码或用户名错误，请重新输入");
            }, 500);
        }
    };

    // 表单回车提交
    document.getElementById('login-form').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            this.dispatchEvent(new Event('submit', {cancelable: true}));
        }
    });
</script>
</body>
</html>