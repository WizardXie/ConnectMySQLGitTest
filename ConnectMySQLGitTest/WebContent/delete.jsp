<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除学生信息</title>
</head>
<body>
	<form method="post" action="delete.jsp">
		请输入要删除的学生学号：<input type="text" name="id"> <br>
		 <input	type="submit" value="删除">
	</form>
	<hr>
	<%
		//获取输入的学生姓名，如果没有输入，则默认为*
		request.setCharacterEncoding("utf-8");	
		String id = request.getParameter("id");
	%>
	<%-- 获取数据库连接 --%>
	<%
		//定义表示MySQL的jdbc驱动类名的字符串	
		String driver = "com.mysql.jdbc.Driver";
		//定义表示数据库的URL的字符串，localhost为MySQL服务器的计算机名，也可以用IP地址表示，3306为访问端口
		String url = "jdbc:mysql://localhost:3306/testdb?useSSL=false";
		//定义表示数据库用户名和密码的字符串
		String username = "root";
		String password = "12345678";
		//加载数据库JDBC驱动
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			out.println("数据库驱动出现问题，具体内容如下：");
			e.printStackTrace();
		}
		//创建网页到数据库的连接，注意：这里的Connection类来自包java.sql.Connection
		Connection conn = DriverManager.getConnection(url, username, password);
		//创建SQL语句对象
		Statement stmt = conn.createStatement();
		//创建包含sql语句的字符串，根据name字符串是否为空选择合适的查询语句
		String sql;
		sql = "select * from studentinfo";
		if (id == null || id.equals("")) {
			out.println("<font color=\"red\">请输入待删除学生的学号</font><br><hr>");
		} else {
			String deletesql="delete from studentinfo where id='"+id+"'";
			int i =stmt.executeUpdate(deletesql);
			if(i==0){
				out.println("<font color=\"red\">输入的学号有误，请重新输入</font><br><hr>");
			}
		}

		//执行SQL语句并获取执行结果
		ResultSet rs = stmt.executeQuery(sql);
		//显示读取出来的信息
	%>
	<table border=1>
		<caption>学生信息表</caption>
		<tr>
			<th>学号Fix</th>
			<th>姓名Fix</th>
			<th>性别Fix</th>
			<th>系部Fix</th>
		</tr>
		<%
			//输出信息		
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("</tr>");
			}
		%>
	</table>
	<%
		//关闭连接
		rs.close();
		stmt.close();
		conn.close();
	%>
</body>
</html>