<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>请假详情</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3498db;
            --primary-light: #5dade2;
            --primary-dark: #2874a6;
            --accent: #1abc9c;
            --light: #f8f9fa;
            --light-blue: #e8f4fd;
            --blue-bg: #e3f2ff;
            --dark: #2c3e50;
            --gray: #7f8c8d;
            --success: #2ecc71;
            --warning: #f39c12;
            --error: #e74c3c;
            --pending: #f1c40f;
            --approved: #27ae60;
            --rejected: #c0392b;
            --shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
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
            padding: 30px;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            width: 100%;
            margin: 0 auto;
        }

        .leave-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
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
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }

        .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        .card-content {
            padding: 40px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            padding: 20px;
            background: var(--light-blue);
            border-radius: 15px;
            transition: var(--transition);
            border: 1px solid #d6e9ff;
        }

        .detail-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(52, 152, 219, 0.15);
        }

        .detail-icon {
            width: 60px;
            height: 60px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .detail-icon i {
            font-size: 1.8rem;
            color: var(--primary);
        }

        .detail-text {
            flex: 1;
        }

        .detail-label {
            font-size: 0.95rem;
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
        }

        .reason-section {
            background: var(--light-blue);
            border-radius: 15px;
            padding: 25px;
            margin-top: 20px;
            border: 1px solid #d6e9ff;
        }

        .section-title {
            font-size: 1.3rem;
            color: var(--primary-dark);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: var(--primary);
        }

        .reason-content {
            font-size: 1.1rem;
            line-height: 1.7;
            color: #444;
            padding: 15px;
            background: white;
            border-radius: 12px;
            border-left: 4px solid var(--primary);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 18px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1rem;
            margin-top: 5px;
        }

        .status-badge i {
            margin-right: 8px;
        }

        .status-pending {
            background: rgba(241, 196, 15, 0.15);
            color: var(--pending);
        }

        .status-approved {
            background: rgba(39, 174, 96, 0.15);
            color: var(--approved);
        }

        .status-rejected {
            background: rgba(192, 57, 43, 0.15);
            color: var(--rejected);
        }

        .leave-type-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 18px;
            border-radius: 30px;
            font-weight: 600;
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
        }

        .btn {
            padding: 14px 35px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            cursor: pointer;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(41, 128, 185, 0.3);
        }

        .btn-outline {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-outline:hover {
            background: rgba(52, 152, 219, 0.1);
            transform: translateY(-3px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 30px;
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--primary);
            margin-bottom: 20px;
            opacity: 0.7;
        }

        .empty-title {
            font-size: 1.8rem;
            color: var(--dark);
            margin-bottom: 15px;
        }

        .empty-text {
            font-size: 1.1rem;
            color: var(--gray);
            max-width: 500px;
            margin: 0 auto 30px;
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
            .detail-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                gap: 15px;
            }

            .card-header {
                padding: 25px 20px;
            }

            h1 {
                font-size: 2rem;
            }

            .card-content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="leave-card">
        <div class="card-header">
            <h1><i class="fas fa-file-invoice"></i> 请假申请详情</h1>
            <p class="subtitle">申请编号: L2023052712 | 提交日期: 2023-05-27</p>
        </div>

        <div class="card-content">
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-id-badge"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">员工工号</div>
                        <div class="detail-value">E100235</div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">请假员工</div>
                        <div class="detail-value">张明</div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">请假类型</div>
                        <div class="detail-value">
                                <span class="leave-type-badge">
                                    <i class="fas fa-heartbeat"></i> 病假
                                </span>
                        </div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">开始时间</div>
                        <div class="detail-value">2023-06-01 09:00</div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">结束时间</div>
                        <div class="detail-value">2023-06-05 18:00</div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">审核状态</div>
                        <div class="detail-value">
                                <span class="status-badge status-approved">
                                    <i class="fas fa-check-circle"></i> 已通过
                                </span>
                        </div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">审核人员</div>
                        <div class="detail-value">李经理</div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="detail-text">
                        <div class="detail-label">总时长</div>
                        <div class="detail-value">4.5 个工作日</div>
                    </div>
                </div>
            </div>

            <div class="reason-section">
                <div class="section-title">
                    <i class="fas fa-comment-dots"></i> 请假原因
                </div>
                <div class="reason-content">
                    <p>近期因感冒引起发烧，医生诊断为流感，建议休息一周。根据医院出具的诊断证明（附件已上传），需要在家休息并接受治疗，避免传染给同事。请假期间会保持手机畅通，紧急工作事项可通过邮件或微信联系。</p>
                    <p style="margin-top: 15px;">请假期间工作已安排同事小王代为处理，重要事项已做好交接，不会影响项目进度。感谢理解与支持！</p>
                </div>
            </div>

            <div class="action-buttons">
                <a href="#" class="btn btn-primary">
                    <i class="fas fa-print"></i> 打印申请
                </a>
                <a href="#" class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> 返回列表
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    // 添加简单的动画效果
    document.addEventListener('DOMContentLoaded', function() {
        const detailItems = document.querySelectorAll('.detail-item');

        detailItems.forEach((item, index) => {
            item.style.opacity = "0";
            item.style.transform = "translateY(20px)";

            setTimeout(() => {
                item.style.transition = "opacity 0.5s ease, transform 0.5s ease";
                item.style.opacity = "1";
                item.style.transform = "translateY(0)";
            }, 150 * index);
        });
    });
</script>
</body>
</html>