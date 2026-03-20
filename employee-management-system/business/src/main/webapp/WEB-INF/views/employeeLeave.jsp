<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工请假系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: #2c3e50;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            max-width: 800px;
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #2874a6, #3498db);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 15px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 4px;
            background: linear-gradient(to right, #3498db, #5dade2);
            border-radius: 2px;
        }

        .subtitle {
            font-size: 1.4rem;
            color: #2874a6;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .container {
            display: flex;
            justify-content: center;
            gap: 40px;
            max-width: 1200px;
            width: 100%;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .card {
            width: 100%;
            max-width: 500px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(41, 128, 185, 0.2);
            transition: all 0.4s ease;
            border: 2px solid rgba(52, 152, 219, 0.2);
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        .card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 20px 40px rgba(41, 128, 185, 0.3);
            border-color: rgba(52, 152, 219, 0.4);
        }

        .card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(52, 152, 219, 0.1) 0%, transparent 70%);
            z-index: -1;
            transition: all 0.6s ease;
        }

        .card:hover::before {
            transform: scale(1.1);
        }

        .card-content {
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            height: 100%;
        }

        .card-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #3498db, #5dade2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
            font-size: 3.5rem;
            color: white;
            box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);
        }

        .card h2 {
            font-size: 2.2rem;
            color: #2874a6;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 1.2rem;
            color: #5c7c9b;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .card-button {
            padding: 15px 40px;
            background: linear-gradient(135deg, #3498db, #2874a6);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 5px 15px rgba(41, 128, 185, 0.4);
        }

        .card-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(41, 128, 185, 0.6);
            background: linear-gradient(135deg, #2874a6, #3498db);
        }

        .footer {
            margin-top: 60px;
            text-align: center;
            color: #5c7c9b;
            font-size: 1.1rem;
        }

        .decoration {
            position: absolute;
            z-index: -1;
            opacity: 0.1;
        }

        .decoration-1 {
            top: 10%;
            left: 5%;
            font-size: 8rem;
            color: #3498db;
            animation: float 6s ease-in-out infinite;
        }

        .decoration-2 {
            top: 30%;
            right: 5%;
            font-size: 10rem;
            color: #2874a6;
            animation: float 8s ease-in-out infinite;
        }

        .decoration-3 {
            bottom: 20%;
            left: 15%;
            font-size: 6rem;
            color: #5dade2;
            animation: float 7s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
        }

        @media (max-width: 1100px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .card {
                max-width: 600px;
            }
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.8rem;
            }

            .subtitle {
                font-size: 1.2rem;
            }

            .card-content {
                padding: 30px;
            }

            .card-icon {
                width: 80px;
                height: 80px;
                font-size: 2.5rem;
            }

            .card h2 {
                font-size: 1.8rem;
            }

            .card p {
                font-size: 1.1rem;
            }

            .decoration {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="decoration decoration-1">
    <i class="fas fa-calendar-alt"></i>
</div>
<div class="decoration decoration-2">
    <i class="fas fa-user-clock"></i>
</div>
<div class="decoration decoration-3">
    <i class="fas fa-file-signature"></i>
</div>

<div class="header">
    <h1>员工请假管理系统</h1>
    <p class="subtitle">高效、便捷的请假申请与管理平台，让员工请假流程更加简单顺畅</p>
</div>

<div class="container">
    <div class="card">
        <div class="card-content">
            <div class="card-icon">
                <i class="fas fa-file-alt"></i>
            </div>
            <h2>请假申请</h2>
            <p>提交新的请假申请，选择请假类型、日期并填写请假原因。系统将自动提交给审批人进行处理。</p>
            <form action="${pageContext.request.contextPath}/leave/addLeave?employeeId=${employee.employeeId}" method="post">
                <button type="submit" class="card-button">
                    <i class="fas fa-pen"></i> 开始申请
                </button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-content">
            <div class="card-icon">
                <i class="fas fa-history"></i>
            </div>
            <h2>申请历史</h2>
            <p>查看您的请假历史记录，包括已批准、待审批和已拒绝的申请。随时了解您的请假状态。</p>
            <form action="${pageContext.request.contextPath}/leave/History?employeeId=${employee.employeeId}" method="post">
                <button type="submit" class="card-button">
                    <i class="fas fa-clock"></i> 查看历史
                </button>
            </form>
        </div>
    </div>
</div>

<div class="footer">
    <p>© 2023 员工请假管理系统 | 让请假管理更简单高效</p>
</div>
</body>
</html>