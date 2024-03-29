<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
			String uid = "sa";
			String pw = "304#serverpw";

			String sql = "SELECT userid, password FROM customer WHERE userid = ? AND password = ?";
			Connection conn = DriverManager.getConnection(url, uid, pw);
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, username);
			stmt.setString(2, password);

			try (ResultSet res = stmt.executeQuery()) {
				if (res.next()) {
					retStr = res.getString("userid");
				} else {
					retStr = "Username or Password was Invalid";
				}
			} catch (SQLException exep) {
				exep.printStackTrace();
			}
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
				
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

