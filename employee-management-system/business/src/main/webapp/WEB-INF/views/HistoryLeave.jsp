<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>历史请假记录</title>
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
            padding: 2rem;
            color: var(--dark);
        }

        .container {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            padding: 0 20px;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

        h1:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(to right, var(--primary), var(--primary-light));
            border-radius: 2px;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: var(--primary);
            color: white;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3);
        }

        .back-button:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(41, 128, 185, 0.4);
        }

        .back-button i {
            margin-right: 8px;
        }

        .content-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--primary-light);
            margin-bottom: 30px;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 800px;
        }

        thead th {
            background: linear-gradient(to bottom, var(--primary), var(--primary-dark));
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
            border: none;
        }

        th:first-child {
            border-top-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
        }

        tbody td {
            padding: 15px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        tbody tr {
            transition: var(--transition);
            opacity: 0;
            transform: translateY(20px);
        }

        tbody tr.visible {
            opacity: 1;
            transform: translateY(0);
        }

        tbody tr:hover {
            background: rgba(52, 152, 219, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .leave-type {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary-dark);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            font-weight: 500;
        }

        .detail-btn {
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary-dark);
        }

        .detail-btn:hover {
            background: rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }

        .cancel-btn {
            background: rgba(231, 76, 60, 0.15);
            color: #c0392b;
        }

        .cancel-btn:hover {
            background: rgba(231, 76, 60, 0.25);
            transform: translateY(-2px);
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 15px 20px;
            border-radius: 10px;
            border: 1px solid #ffcdd2;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 500;
            max-width: 800px;
            margin: 0 auto 30px;
            animation: fadeIn 0.5s ease;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .status-pending {
            background-color: rgba(241, 196, 15, 0.2);
            color: #f39c12;
        }

        .status-approved {
            background-color: rgba(46, 204, 113, 0.2);
            color: #27ae60;
        }

        .status-rejected {
            background-color: rgba(231, 76, 60, 0.2);
            color: #c0392b;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .empty-state {
            text-align: center;
            padding: 50px;
            color: #7f8c8d;
        }

        .empty-icon {
            font-size: 5rem;
            color: #bdc3c7;
            margin-bottom: 20px;
        }

        .empty-text {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .filter-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 20px;
            background: white;
            border: 2px solid var(--primary-light);
            border-radius: 50px;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
        }

        .filter-btn.active, .filter-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            h1 {
                font-size: 2rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }

            .table-container {
                padding: 10px;
            }

            .filter-container {
                gap: 8px;
            }

            .filter-btn {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-history"></i> 历史请假记录</h1>
        <a href="${pageContext.request.contextPath}/leave/employeeLeave" class="back-button">
            <i class="fas fa-arrow-left"></i> 返回
        </a>
    </div>

    <c:if test="${not empty leaveError}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${leaveError}
        </div>
    </c:if>

    <div class="filter-container">
        <div class="filter-btn active" data-filter="all">全部记录</div>
        <div class="filter-btn" data-filter="pending">待审核</div>
        <div class="filter-btn" data-filter="approved">已批准</div>
        <div class="filter-btn" data-filter="rejected">已拒绝</div>
    </div>

    <div class="content-card">
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty leaveList}">
                    <table>
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>请假类型</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="leaveTableBody">
                        <c:forEach var="leave" items="${leaveList}" varStatus="bianhao">
                            <tr>
                                <td>${bianhao.index + 1}</td>
                                <td>
                                        <span class="leave-type">
                                            <c:choose>
                                                <c:when test="${leave.leaveType == 0}">
                                                    <i class="fas fa-heartbeat"></i> 病假
                                                </c:when>
                                                <c:when test="${leave.leaveType == 1}">
                                                    <i class="fas fa-calendar-check"></i> 事假
                                                </c:when>
                                                <c:when test="${leave.leaveType == 2}">
                                                    <i class="fas fa-umbrella-beach"></i> 年假
                                                </c:when>
                                            </c:choose>
                                        </span>
                                </td>
                                <td>
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                                <td>
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${leave.status == 0}">
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock"></i> 待审核
                                                </span>
                                        </c:when>
                                        <c:when test="${leave.status == 1}">
                                                <span class="status-badge status-approved">
                                                    <i class="fas fa-check-circle"></i> 已批准
                                                </span>
                                        </c:when>
                                        <c:when test="${leave.status == 2}">
                                                <span class="status-badge status-rejected">
                                                    <i class="fas fa-times-circle"></i> 已拒绝
                                                </span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <form action="${pageContext.request.contextPath}/leave/detailLeave?leaveId=${leave.leaveId}" method="post" class="inline-form">
                                            <button type="submit" class="action-btn detail-btn">
                                                <i class="fas fa-info-circle"></i> 详情
                                            </button>
                                        </form>
                                        <c:if test="${leave.status == 0}">
                                            <form action="${pageContext.request.contextPath}/leave/delete?leaveId=${leave.leaveId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
                                                <button type="submit" class="action-btn cancel-btn">
                                                    <i class="fas fa-times"></i> 取消
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="far fa-folder-open"></i>
                        </div>
                        <h3>暂无请假记录</h3>
                        <p class="empty-text">您还没有提交过请假申请</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    function confirmDelete() {
        return confirm("确定要取消该请假申请吗？");
    }

    // 初始化页面时添加行动画
    document.addEventListener('DOMContentLoaded', function() {
        // 添加表格行动画
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach((row, index) => {
            setTimeout(() => {
                row.classList.add('visible');
            }, 100 * index);
        });

        // 筛选功能
        const filterButtons = document.querySelectorAll('.filter-btn');
        filterButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                // 移除所有按钮的active类
                filterButtons.forEach(b => b.classList.remove('active'));

                // 为当前按钮添加active类
                this.classList.add('active');

                // 获取筛选条件
                const filter = this.dataset.filter;

                // 筛选表格行
                const rows = document.querySelectorAll('tbody tr');
                let visibleCount = 0;

                rows.forEach(row => {
                    const statusCell = row.cells[4];
                    const statusText = statusCell.textContent.trim();

                    // 根据状态文本判断
                    let match = false;
                    if (filter === 'all') {
                        match = true;
                    } else if (filter === 'pending' && statusText.includes('待审核')) {
                        match = true;
                    } else if (filter === 'approved' && statusText.includes('已批准')) {
                        match = true;
                    } else if (filter === 'rejected' && statusText.includes('已拒绝')) {
                        match = true;
                    }

                    if (match) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                // 如果没有符合条件的记录
                const emptyState = document.querySelector('.empty-state');
                if (emptyState) {
                    emptyState.style.display = visibleCount === 0 ? 'block' : 'none';
                }
            });
        });
    });
</script>
</body>
</html>