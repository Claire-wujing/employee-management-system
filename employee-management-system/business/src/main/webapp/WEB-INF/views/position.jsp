<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>岗位管理</title>
    <style>
        /*===== 谷歌字体 =====*/
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap");

        /*===== CSS变量 =====*/
        :root {
            --primary-color: #0C5DF4;
            --primary-hover: #0A4ECC;
            --secondary-color: #6C757D;
            --light-blue: #E6F0FF;
            --light-blue-hover: #D0E0FF;
            --bg-color: #F5F5F5;
            --white-color: #FFFFFF;
            --border-color: #0C5DF4;
            --text-color: #212529;
            --text-light: #6C757D;
            --success-color: #28a745;
            --danger-color: #dc3545;

            /*===== 字体 =====*/
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 0.9375rem;
            --small-font-size: 0.875rem;
            --large-font-size: 1.25rem;

            /*===== 阴影 =====*/
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);

            /*===== 圆角 =====*/
            --border-radius: 0.375rem;
            --border-radius-lg: 0.5rem;
            --border-radius-sm: 0.25rem;
        }

        /*===== 基础规定 =====*/
        *, ::before, ::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            color: var(--text-color);
            background-color: var(--bg-color);
            line-height: 1.6;
            padding: 2rem;
        }

        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            text-align: center;
            position: relative;
            padding-bottom: 0.5rem;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), transparent);
            border-radius: 3px;
        }

        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background-color: var(--light-blue);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow);
            border: 2px solid var(--border-color);
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .search-container input[type="text"],
        .search-container select {
            padding: 0.5rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius);
            background-color: var(--white-color);
            font-size: var(--normal-font-size);
            transition: all 0.3s ease;
            min-width: 200px;
        }

        .search-container input[type="text"]:focus,
        .search-container select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(12, 93, 244, 0.25);
        }

        .search-container button {
            padding: 0.5rem 1.25rem;
            background-color: var(--primary-color);
            color: var(--white-color);
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .search-container button:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .search-container .reset-button {
            background-color: var(--secondary-color);
        }

        .search-container .reset-button:hover {
            background-color: #5A6268;
        }

        .add-button {
            padding: 0.5rem 1.25rem 0.5rem 2.5rem;
            background-color: var(--primary-color);
            color: var(--white-color);
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            position: relative;
            box-shadow: var(--shadow-sm);
        }

        .add-button:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .add-button::before {
            content: "+";
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            font-weight: bold;
            font-size: 1.1rem;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: var(--white-color);
            border-radius: var(--border-radius);
            overflow: hidden;
            border: 2px solid var(--border-color);
        }

        th {
            background-color: var(--primary-color);
            color: var(--white-color);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: rgba(12, 93, 244, 0.05);
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .edit-button, .delete-button {
            padding: 0.375rem 0.75rem;
            border-radius: var(--border-radius-sm);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: var(--small-font-size);
            border: 1px solid;
        }

        .edit-button {
            background-color: rgba(12, 93, 244, 0.1);
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .edit-button:hover {
            background-color: var(--primary-color);
            color: var(--white-color);
            transform: translateY(-1px);
        }

        .delete-button {
            background-color: var(--white-color);
            color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .delete-button:hover {
            background-color: #F1F1F1;
            transform: translateY(-1px);
        }
        .delete-button {
            background-color: var(--white-color);
            color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .delete-button:hover {
            background-color: #F1F1F1;
            transform: translateY(-1px);
        }
        .status-normal {
            color: var(--success-color);
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius-sm);
            background-color: rgba(40, 167, 69, 0.1);
            display: inline-block;
        }

        .status-abnormal {
            color: var(--danger-color);
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius-sm);
            background-color: rgba(220, 53, 69, 0.1);
            display: inline-block;
        }

        .error-message {
            background-color: #F8D7DA;
            color: #721C24;
            padding: 0.75rem 1.25rem;
            border-radius: var(--border-radius);
            border: 1px solid #F5C6CB;
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 500;
        }

        .create-time {
            color: var(--text-light);
            font-size: var(--small-font-size);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: stretch;
            }

            .search-container {
                flex-direction: column;
                align-items: stretch;
            }

            .search-container input,
            .search-container select,
            .search-container button {
                width: 100%;
            }

            .add-button-container {
                margin-bottom: 1rem;
            }

            .action-buttons {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<% if (request.getAttribute("Error") != null) { %>
<script>
    window.onload = function () {
        alert('<%= request.getAttribute("Error") %>');
    };
</script>
<% } %>
<body>
<div class="content">
    <% if (request.getAttribute("positionError") != null) { %>
    <div class="error-message"><%= request.getAttribute("positionError") %></div>
    <% } %>

    <h1>岗位管理系统</h1>

    <div class="header-container">
        <div class="add-button-container">
            <form action="${pageContext.request.contextPath}/position/add" method="post" class="inline-form" id="addPositionForm">
                <button type="submit" class="add-button">新增岗位</button>
            </form>
        </div>

        <div class="search-container">
            <form action="${pageContext.request.contextPath}/position/searchPosition" method="get">
                <input type="text" name="code" placeholder="岗位编码">
                <input type="text" name="positionName" placeholder="岗位名称">
                <select name="status">
                    <option value="">所有状态</option>
                    <option value="0">异常</option>
                    <option value="1">正常</option>
                </select>
                <button type="submit">查询</button>
                <button type="button" class="reset-button" onclick="resetSearch()">重置</button>
            </form>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>岗位编号</th>
                <th>岗位编码</th>
                <th>岗位名称</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="position" items="${positionList}" varStatus="bianhao">
                <tr>
                    <td>${bianhao.index + 1}</td>
                    <td>${position.code}</td>
                    <td>${position.positionName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${position.status == 1}">
                                <span class="status-normal">正常</span>
                            </c:when>
                            <c:when test="${position.status == 0}">
                                <span class="status-abnormal">异常</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td class="create-time"><fmt:formatDate value="${position.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <div class="action-buttons">
                            <form action="${pageContext.request.contextPath}/position/updatePosition?positionId=${position.positionId}" method="post" class="inline-form">
                                <button type="submit" class="edit-button">修改</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/position/deletePosition?positionId=${position.positionId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
                                <button type="submit" class="delete-button">删除</button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    window.onload = function () {
        var errorMessage = document.querySelector('.error-message');
        if (errorMessage) {
            alert(errorMessage.textContent);
        }
    };

    function confirmDelete() {
        return confirm("确定要删除该岗位吗？此操作不可恢复！");
    }

    function resetSearch() {
        document.querySelectorAll('.search-container input[type="text"], .search-container select').forEach(input => {
            input.value = '';
        });
    }
</script>
</body>
</html>