<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/2
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加部门</title>
    <style>
        /* 谷歌字体 */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* CSS变量 */
        :root {
            --first-color: #1E88E5;
            --second-color: #42A5F5;
            --form-bg-color: #E3F2FD; /* 表单浅蓝色背景 */
            --white-color: #FFF;
            --border-color: #1565C0; /* 深蓝色边框 */
            --page-bg-color: #f5f5f5; /* 页面背景色 */
            /* 字体 */
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 1rem;
            --small-font-size: .875rem;
        }

        /* 基础规定 */
        *, ::before, ::after {
            box-sizing: border-box;
        }
        body {
            position: relative;
            margin: 0;
            padding: 2rem;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            background-color: var(--page-bg-color);
            transition: .5s;
            min-height: 100vh;
        }
        h1 {
            margin: 0;
            text-align: center;
            color: var(--first-color);
        }
        ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        a {
            text-decoration: none;
        }
        .content {
            position: relative;
            width: 100%;
            min-height: calc(100vh - 4rem);
            overflow: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .form-container {
            background-color: var(--form-bg-color); /* 表单浅蓝色背景 */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 320px;
            padding: 25px;
            text-align: center;
            transition: transform 0.3s ease;
            border: 2px solid var(--border-color); /* 深蓝色边框 */
        }
        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        label {
            display: block;
            margin-top: 15px;
            color: var(--border-color);
            font-weight: 600;
            text-align: left;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 2px solid var(--border-color); /* 深蓝色边框 */
            border-radius: 5px;
            font-size: var(--normal-font-size);
            transition: border-color 0.3s;
            background-color: var(--white-color); /* 输入框白色背景 */
        }
        input[type="text"]:focus {
            outline: none;
            border-color: var(--first-color);
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        button {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        button[type="submit"] {
            background-color: var(--first-color);
            color: var(--white-color);
        }
        button[type="submit"]:hover {
            background-color: var(--border-color);
        }
        button[type="button"] {
            background-color: var(--white-color);
            color: var(--border-color);
            border: 1px solid var(--border-color);
        }
        button[type="button"]:hover {
            background-color: #e0e0e0;
        }
        h2 {
            color: var(--border-color);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="form-container">
        <h2>添加岗位</h2>
        <form action="${pageContext.request.contextPath}/department/addDepartment" method="post" onsubmit="return confirmAddPosition();">
            <label for="departmentName">部门名称:</label>
            <input type="text" id="departmentName" name="departmentName" required><br>

            <label for="departmentCode">部门编码:</label>
            <input type="text" id="departmentCode" name="departmentCode" required><br>

            <div class="button-group">
                <button type="submit">新增部门</button>
                <button type="button" onclick="historyBack()">返回</button>
            </div>
        </form>
    </div>
</div>

<script>
    function historyBack() {
        window.history.back();
    }
    function confirmAddPosition() {
        var departmentName = document.getElementById('departmentName').value;
        var departmentCode = document.getElementById('departmentCode').value;

        if (departmentName.trim() === '' || departmentCode.trim() === '') {
            alert("部门名称和部门编码不能为空，请重新输入。");
            return false; // 阻止表单提交
        }
        return confirm("确定要添加这个部门吗？"); // 弹出确认对话框
    }
</script>
</body>
</html>