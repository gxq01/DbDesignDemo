<%--
  Created by IntelliJ IDEA.
  User: a9573
  Date: 2020/11/16
  Time: 2:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">

    <!-- 引入css样式表 -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/resources/css/BorrowManagement.css">

    <!-- 引入JS文件 -->
    <script
            src="${pageContext.request.contextPath }/resources/js/admin/BorrowManagement.js"></script>
</head>
<body>
<div class = "book-top">
    <div class = "book-title">
        <h3>已借图书管理</h3>
    </div>
    <div class = "book_functionArea">
        <div class="book-search input-group-lg">
            <input type="text" class = "borrow-search-input" placeholder="直接查询学号or查询书籍号(以b开头)">
            <button class = "btn btn-secondary book-search-button"
                    id="book-search-button" @click="searchBook()">搜索</button>
        </div>
    </div>
</div>
<!--书籍信息列表-->
<div class="content" id="content">
    <table class="table table-condensed table-hover" id="table-content">
        <thead>
        <tr>
            <th>学号</th>
            <th>书籍编号</th>
            <th>学生姓名</th>
            <th>书名</th>
            <th>借阅日期</th>
            <th>应还日期</th>
            <th>实还日期</th>
            <th>逾期情况</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(borrow,index) in borrowList">
            <td>{{borrow.stuId}}</td>
            <td>{{borrow.bookId}}</td>
            <td>{{borrow.stuName}}</td>
            <td>{{borrow.bookName}}</td>
            <td>{{borrow.borrowDate}}</td>
            <td>{{borrow.expectReturnDate}}</td>
            <td v-if="borrow.realReturnDate==null">尚未归还</td>
            <td v-else>{{borrow.realReturnDate}}</td>
            <td v-if="borrow.isExceeded=='逾期'"><font color="red">逾&emsp;期</font></td>
            <td v-else>{{borrow.isExceeded}}</td>
            <td v-if="borrow.realReturnDate==null"><button class="btn btn-sm btn-warning book-return" v-bind:value='index' data-toggle="modal" data-target="#book-return" id="book-return-button"><font color="white">确认归还</font></button></td>
            <td v-else><button class="btn btn-warning btn-sm  book-return" v-bind:value='index' data-toggle="modal" data-target="#book-return" id="book-return-button" hidden="hidden" ></button></td>

        </tr>
        </tbody>
    </table>
    <div class="book-total" id="book-total">共有{{allBorrowCount}}条借阅记录</div>
    <!--分页功能-->
    <div class="pageNav">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" id="page" href="#" @click="pageChange(prePage)" v-if="flag==true">上一页</a> </li>
            <li class="page-item"><a class="page-link" id="page" href="#" @click="searchPage(prePage)" v-if="flag==false">上一页</a> </li>
            <li class="page-item active" v-for="pages in pageNum" v-if="pages==page">
                <a class="page-link" id="page" @click="pageChange(pages)" href="#" v-if="flag">{{pages}}</a>
                <a class='page-link' id='page' @click="searchPage(pages,search)" href="#" v-else>{{pages}}</a>
            </li>
            <li class='page-item' v-else>
                <a class='page-link' id='page' @click="pageChange(pages)" href="#" v-if="flag">{{pages}}</a>
                <a class='page-link' id='page' @click="searchPage(pages,search)" href="#" v-else>{{pages}}</a>
            </li>

            <li class='page-item'><a class='page-link' id='page' href="#" @click="pageChange(nextPage)" v-if="flag == true">下一页</a></li>
            <li class='page-item'><a class='page-link' id='page' href="#" @click="searchPage(nextPage,search)" v-if="flag == false">下一页</a></li>
        </ul>
    </div>
</div>

<!-- 确认归还模态框 -->
<div class="modal fade" id="book-return">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">确认归还</h4>
                <button type="button" class="close" id="close-button" data-dismiss="modal">&times;</button>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body">
                <form action="" id="book-return-form" method="post">
                    <div>
                        <label for="stu-id">学号:</label>
                        <input type="text" name="stuId" id="stu-id" readonly="readonly">
                    </div>
                    <div>
                        <label for="book-id">书籍编号:</label>
                        <input type="text" name="bookId" id="book-id" readonly="readonly">
                    </div>
                    <div>
                        <label for="book-name">书籍名称:</label>
                        <input type="text" name="bookName" id="book-name" readonly="readonly">
                    </div>
                    <div>
                        <label for="real-return-date">实际还书日期:</label>
                        <input type="date" name="realReturnDate" id="real-return-date">
                    </div>
                    <!-- 模态框底部 -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="book-return-input">提交</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
</body>
</html>
