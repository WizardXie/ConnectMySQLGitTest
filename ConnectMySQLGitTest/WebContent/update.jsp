<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改学生信息</title>
</head>
<body>
请输入要修改的学生信息
	<form method="post" action="update.jsp">
		学号：<input type="text" name="id"><br> 
		姓名：<input type="text" name="name"><br> 
		性别：<input type="text" name="gender"><br> 
		系部：<input type="text" name="department"><br> 
		<input type="submit" value="修改">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="重置">
	</form>
	<hr>
	<%-- 获取学生信息 --%>
	<%
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String gender=request.getParameter("gender");
		String department=request.getParameter("department");
		
	%>
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
		if((id!=null&& name!=null) && (id.equals("")||name.equals(""))){
			out.println("<font color=\"red\">请输入学号和姓名，这是必填信息</font><br><hr>");
		}else if(id!=null&& name!=null){
			String updatesql="update studentinfo set name='"+name+"',gender='"+gender+"',department='"+department+"' where id='"+id+"'";
			int i=stmt.executeUpdate(updatesql);
			if(i==0){
				out.println("<font color=\"red\">请输入正确的学号</font><br><hr>");
			}
		}
		//创建包含sql语句的字符串
		String sql = "select * from studentinfo";
		//执行SQL语句并获取执行结果
		ResultSet rs = stmt.executeQuery(sql);
		//显示读取出来的信息
	%>
	<table border=1>
		<caption>学生信息表</caption>
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>系部</th>
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