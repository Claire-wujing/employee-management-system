<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工管理系统</title>
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
            max-width: 1400px;
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

        .content-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--primary-light);
            margin-bottom: 30px;
        }

        .toolbar {
            display: flex;
            justify-content: space-between;
            padding: 25px 30px;
            background: rgba(52, 152, 219, 0.05);
            border-bottom: 2px solid var(--primary-light);
            flex-wrap: wrap;
            gap: 20px;
        }

        .search-section {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .search-input {
            padding: 12px 20px;
            border: 2px solid var(--primary-light);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--light-blue);
            color: var(--dark);
            min-width: 220px;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .btn {
            padding: 12px 25px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
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

        .btn-add {
            background: linear-gradient(to right, var(--success), #26c281);
            color: white;
            padding: 12px 25px 12px 45px;
            position: relative;
        }

        .btn-add::before {
            content: "+";
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-weight: bold;
            font-size: 1.4rem;
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
            min-width: 1000px;
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
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        tbody td {
            padding: 15px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        tbody tr {
            transition: var(--transition);
            opacity: 0;
            transform: translateY(10px);
        }

        tbody tr:hover {
            background: rgba(52, 152, 219, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .edit-btn, .delete-btn {
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

        .edit-btn {
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary-dark);
        }

        .edit-btn:hover {
            background: rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }

        .delete-btn {
            background: rgba(231, 76, 60, 0.15);
            color: #c0392b;
        }

        .delete-btn:hover {
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

        .department-badge, .position-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary-dark);
            font-size: 0.9rem;
            margin-top: 5px;
        }

        .hire-date {
            color: #7f8c8d;
            font-size: 0.9rem;
            display: block;
        }

        .employee-name {
            font-weight: 600;
            font-size: 1.1rem;
        }

        .employee-id {
            font-size: 0.85rem;
            color: #7f8c8d;
            margin-top: 3px;
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

        @media (max-width: 992px) {
            .toolbar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-section {
                flex-wrap: wrap;
            }

            .search-input {
                flex: 1;
                min-width: 100%;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            h1 {
                font-size: 2rem;
            }

            .btn {
                width: 100%;
            }

            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-users"></i> 员工管理系统</h1>
    </div>

    <% if (request.getAttribute("employeeError") != null) { %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("employeeError") %>
    </div>
    <% } %>

    <div class="content-card">
        <div class="toolbar">
            <div class="search-section">
                <form action="${pageContext.request.contextPath}/employee/searchEmployee" method="get" style="display: flex; gap: 15px; flex-wrap: wrap;">
                    <input type="text" name="employeeName" placeholder="员工姓名" class="search-input">
                    <input type="text" name="phone" placeholder="员工电话" class="search-input">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> 查询
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="resetSearch()">
                        <i class="fas fa-sync-alt"></i> 重置
                    </button>
                </form>
            </div>

            <form action="${pageContext.request.contextPath}/employee/add" method="post" class="inline-form">
                <button type="submit" class="btn btn-add">
                    新增员工
                </button>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>序号</th>
                    <th>员工信息</th>
                    <th>联系方式</th>
                    <th>所属部门</th>
                    <th>工作岗位</th>
                    <th>入职时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="employee" items="${employeeList}" varStatus="bianhao">
                    <tr>
                        <td>${bianhao.index + 1}</td>
                        <td>
                            <span class="employee-name">${employee.employeeName}</span>
                            <div class="employee-id">ID: ${employee.employeeId}</div>
                        </td>
                        <td>
                            <i class="fas fa-phone"></i> ${employee.phone}
                        </td>
                        <td>
                            <c:forEach var="department" items="${departmentList}">
                                <c:if test="${department.departmentId == employee.departmentId}">
                                    <span class="department-badge">
                                        <i class="fas fa-building"></i> ${department.departmentName}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="position" items="${positionList}">
                                <c:if test="${position.positionId == employee.positionId}">
                                    <span class="position-badge">
                                        <i class="fas fa-briefcase"></i> ${position.positionName}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <i class="fas fa-calendar-alt"></i>
                            <span class="hire-date">
                                <fmt:formatDate value="${employee.hireDate}" pattern="yyyy-MM-dd"/>
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <form action="${pageContext.request.contextPath}/employee/updateEmployee?employeeId=${employee.employeeId}" method="post" class="inline-form">
                                    <button type="submit" class="edit-btn">
                                        <i class="fas fa-edit"></i> 修改
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/employee/deleteEmployee?employeeId=${employee.employeeId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
                                    <button type="submit" class="delete-btn">
                                        <i class="fas fa-trash-alt"></i> 删除
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    window.onload = function () {
        var errorMessage = document.querySelector('.error-message');
        if (errorMessage) {
            setTimeout(function() {
                errorMessage.style.opacity = '1';
                errorMessage.style.transform = 'translateY(0)';
            }, 300);
        }

        // 添加表格行动画
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach((row, index) => {
            setTimeout(() => {
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, 100 * index);
        });
    };

    function confirmDelete() {
        return confirm("确定要删除该员工吗？此操作不可恢复！");
    }

    function resetSearch() {
        document.querySelectorAll('.search-input').forEach(input => {
            input.value = '';
        });
    }
</script>
</body>
</html>