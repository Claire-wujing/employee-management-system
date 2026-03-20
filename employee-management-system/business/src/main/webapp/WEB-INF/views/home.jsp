<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>企业员工管理系统主页</title>
    <style>
        /*===== 基础设置 =====*/
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            overflow-x: hidden;
            position: relative;
        }

        /*===== 顶部横幅 =====*/
        .banner {
            height: 180px;
            background: linear-gradient(135deg, #1e5799 0%,#207cca 51%,#2989d8 100%);
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .banner-content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            padding-left: 220px;
            background: url('https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1800&q=80') center/cover no-repeat;
            transition: padding-left 0.5s ease;
        }

        .banner-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, rgba(0,0,0,0.6) 0%, rgba(0,0,0,0.3) 100%);
        }

        .banner-text {
            position: relative;
            z-index: 2;
            color: white;
            max-width: 800px;
        }

        .banner-text h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .banner-text p {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
        }

        /*===== 侧边栏样式 =====*/
        .l-navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 200px;
            height: 100vh;
            background: linear-gradient(to bottom, #4da1ff, #2d7fc8);
            color: white;
            padding: 20px 15px;
            transition: width 0.5s ease;
            z-index: 100;
            box-shadow: 3px 0 15px rgba(0,0,0,0.1);
        }

        .nav {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .nav__brand {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .nav__toggle {
            font-size: 1.5rem;
            cursor: pointer;
            background: rgba(255,255,255,0.1);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .nav__toggle:hover {
            background: rgba(255,255,255,0.2);
        }

        .nav__logo {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav__logo i {
            font-size: 1.4rem;
        }

        .nav__list {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .nav__link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 15px;
            color: white;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
        }

        .nav__link:hover {
            background: rgba(255,255,255,0.15);
        }

        .nav__link.active {
            background: rgba(255,255,255,0.25);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .nav__icon {
            font-size: 1.3rem;
            min-width: 24px;
            text-align: center;
        }

        .nav__name {
            font-size: 1rem;
            transition: opacity 0.3s ease;
        }

        .logout-section {
            border-top: 1px solid rgba(255,255,255,0.2);
            padding-top: 15px;
        }

        /* 收缩状态 */
        .l-navbar.collapsed {
            width: 70px;
        }

        .l-navbar.collapsed .nav__name,
        .l-navbar.collapsed .nav__logo span {
            opacity: 0;
            width: 0;
            overflow: hidden;
            position: absolute;
        }

        .l-navbar.collapsed .banner-content {
            padding-left: 90px;
        }

        .l-navbar.collapsed .nav__brand {
            justify-content: center;
        }

        .l-navbar.collapsed .nav__link {
            justify-content: center;
        }

        /*===== 主内容区 =====*/
        .main-content {
            padding: 20px 20px 20px 220px;
            transition: padding-left 0.5s ease;
        }

        .l-navbar.collapsed ~ .main-content {
            padding-left: 90px;
        }

        .content {
            position: relative;
            height: calc(100vh - 220px);
            overflow: auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
            border-radius: 12px;
        }

        /* 欢迎面板 */
        .welcome-panel {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .welcome-panel h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .welcome-panel p {
            font-size: 1.1rem;
            max-width: 800px;
            opacity: 0.9;
        }

        /* 快速统计 */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
        }

        .stat-icon.blue {
            background: #e3f2ff;
            color: #2196f3;
        }

        .stat-icon.green {
            background: #e8f5e9;
            color: #4caf50;
        }

        .stat-icon.orange {
            background: #fff3e0;
            color: #ff9800;
        }

        .stat-icon.purple {
            background: #f3e5f5;
            color: #9c27b0;
        }

        .stat-info h3 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #666;
            font-size: 0.95rem;
        }

        /* 响应式调整 */
        @media (max-width: 992px) {
            .banner-content {
                padding-left: 90px;
            }

            .l-navbar {
                width: 70px;
            }

            .l-navbar .nav__name,
            .l-navbar .nav__logo span {
                opacity: 0;
                width: 0;
                overflow: hidden;
                position: absolute;
            }

            .l-navbar .nav__brand {
                justify-content: center;
            }

            .l-navbar .nav__link {
                justify-content: center;
            }

            .main-content {
                padding-left: 90px;
            }
        }

        @media (max-width: 576px) {
            .banner {
                height: 140px;
            }

            .banner-text h1 {
                font-size: 1.8rem;
            }

            .banner-text p {
                font-size: 0.9rem;
            }

            .l-navbar {
                width: 100%;
                height: 60px;
                padding: 10px;
                bottom: 0;
                top: auto;
            }

            .l-navbar .nav {
                flex-direction: row;
            }

            .l-navbar .nav__brand {
                display: none;
            }

            .l-navbar .nav__list {
                flex-direction: row;
                width: 100%;
                justify-content: space-around;
            }

            .l-navbar .nav__link {
                flex-direction: column;
                gap: 5px;
                padding: 8px;
                font-size: 0.8rem;
            }

            .l-navbar .nav__icon {
                font-size: 1.2rem;
            }

            .l-navbar .nav__name {
                font-size: 0.7rem;
            }

            .l-navbar .logout-section {
                display: none;
            }

            .banner-content {
                padding-left: 20px;
            }

            .main-content {
                padding: 90px 15px 80px 15px;
            }

            .l-navbar.collapsed ~ .main-content {
                padding-left: 15px;
            }
        }
    </style>
</head>
<body>
<!-- 侧边导航栏 -->
<div class="l-navbar" id="navbar">
    <nav class="nav">
        <div>
            <div class="nav__brand">
                <div class="nav__logo">
                    <i class="fas fa-building"></i>
                    <span>企业管理系统</span>
                </div>
                <div class="nav__toggle" id="nav-toggle">
                    <i class="fas fa-bars"></i>
                </div>
            </div>

            <div class="nav__list">
                <a href="#" class="nav__link active" onclick="loadMainPage()">
                    <i class="fas fa-home nav__icon"></i>
                    <span class="nav__name">主页</span>
                </a>

                <c:if test="${sessionScope.user.role == 1}">
                    <a href="#" class="nav__link" onclick="clockIn()">
                        <i class="fas fa-calendar-check nav__icon"></i>
                        <span class="nav__name">打卡</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadLeavePage()">
                        <i class="fas fa-clock nav__icon"></i>
                        <span class="nav__name">请假</span>
                    </a>
                </c:if>

                <c:if test="${sessionScope.user.role == 2}">
                    <a href="#" class="nav__link" onclick="loadLeaveManagementPage()">
                        <i class="fas fa-tasks nav__icon"></i>
                        <span class="nav__name">请假管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadAttendanceStatisticsPage()">
                        <i class="fas fa-clipboard-list nav__icon"></i>
                        <span class="nav__name">考勤列表</span>
                    </a>
                </c:if>

                <c:if test="${sessionScope.user.role == 3}">
                    <a href="#" class="nav__link" onclick="loadEmployeeManagementPage()">
                        <i class="fas fa-users nav__icon"></i>
                        <span class="nav__name">员工管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadDepartmentManagementPage()">
                        <i class="fas fa-sitemap nav__icon"></i>
                        <span class="nav__name">部门管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadPositionManagementPage()">
                        <i class="fas fa-briefcase nav__icon"></i>
                        <span class="nav__name">岗位管理</span>
                    </a>
                </c:if>

                <a href="#" class="nav__link" onclick="loadSettingsPage()">
                    <i class="fas fa-cog nav__icon"></i>
                    <span class="nav__name">设置</span>
                </a>
            </div>
        </div>

        <div class="logout-section">
            <a href="#" action="${pageContext.request.contextPath}/user/logout" class="nav__link">
                <i class="fas fa-sign-out-alt nav__icon"></i>
                <span class="nav__name">退出登录</span>
            </a>
        </div>
    </nav>
</div>

<!-- 企业照片横幅 -->
<div class="banner">
    <div class="banner-content">
        <div class="banner-text">
            <h1>企业员工管理系统</h1>
            <p>高效管理员工信息、考勤记录、请假审批和部门组织，提升企业人力资源管理水平</p>
        </div>
    </div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <div class="welcome-panel">
        <h2>欢迎回来，${sessionScope.user.username}！</h2>
        <p>今天是 <span id="current-date"></span>，祝您工作愉快！</p>
    </div>


    <div class="content">
        <iframe src="" frameborder="0" id="contentFrame"></iframe>
    </div>
</div>

<script>
    // 侧边栏收缩功能
    const navbar = document.getElementById('navbar');
    const navToggle = document.getElementById('nav-toggle');

    navToggle.addEventListener('click', () => {
        navbar.classList.toggle('collapsed');
        document.querySelector('.banner-content').style.paddingLeft =
            navbar.classList.contains('collapsed') ? '90px' : '220px';
    });

    // 设置当前日期
    const now = new Date();
    const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
    document.getElementById('current-date').textContent = now.toLocaleDateString('zh-CN', options);

    // 导航链接高亮
    const navLinks = document.querySelectorAll('.nav__link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            navLinks.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // 页面加载函数
    function loadMainPage() {
        const url = "${pageContext.request.contextPath}/user/Main";
        document.getElementById('contentFrame').src = url;
    }

    function loadSettingsPage() {
        const url = "${pageContext.request.contextPath}/user/updatePassword";
        document.getElementById('contentFrame').src = url;
    }

    function clockIn() {
        const url = "${pageContext.request.contextPath}/attendance/Clock";
        document.getElementById('contentFrame').src = url;
    }

    function loadLeavePage() {
        const url = "${pageContext.request.contextPath}/leave/employeeLeave";
        document.getElementById('contentFrame').src = url;
    }

    function loadEmployeeManagementPage() {
        const url = "${pageContext.request.contextPath}/employee/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadDepartmentManagementPage() {
        const url = "${pageContext.request.contextPath}/department/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadPositionManagementPage() {
        const url = "${pageContext.request.contextPath}/position/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadLeaveManagementPage() {
        const url = "${pageContext.request.contextPath}/leave/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadAttendanceStatisticsPage() {
        const url = "${pageContext.request.contextPath}/attendance/List";
        document.getElementById('contentFrame').src = url;
    }

    // 退出登录
    const logoutLink = document.querySelector('a[action]');
    logoutLink.addEventListener('click', function(e) {
        e.preventDefault();
        const form = document.createElement('form');
        form.setAttribute('action', this.getAttribute('action'));
        form.setAttribute('method', 'post');
        document.body.appendChild(form);
        form.submit();
    });

    // 页面加载完成后默认加载主页
    window.onload = function() {
        loadMainPage();
    };
</script>
</body>
</html>