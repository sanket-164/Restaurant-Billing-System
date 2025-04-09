<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="./NavBar.js"></script>
    </head>
    <body>
    <header-component></header-component>
        <%!
            Connection con;
            Statement stmt;
            ResultSet rs;
        %>

    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM admin WHERE admin_uname='" + request.getSession().getAttribute("username") + "'");
        if (rs.next()) {
    %>
    <form action="../ChangeAdmin" method="post">
        <div class="container d-flex justify-content-center">
            <div class="card mt-4" style="width: 40rem; background-color: #f2f2f2;">
                <div class="card-body">
                    <table width="100%">
                        <tr>
                            <td colspan="2"> <h3 class="card-title"><% out.print(rs.getString("admin_uname")); %></h3></td>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <td><input type="text" class="form-control" name="profile_name" value="<% out.print(rs.getString("admin_name")); %>"></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><input type="email" class="form-control" name="profile_email" value="<% out.print(rs.getString("admin_email")); %>"></td>
                        </tr>
                        <tr>
                            <th>Mobile No.</th>
                            <td><input type="number" class="form-control" name="profile_number" minlength="10" value="<% out.print(rs.getString("admin_num")); %>"></td>
                        </tr>
                        <tr>
                            <th>Birth Date</th>
                            <td><input type="date" class="form-control" name="profile_dob" value="<% out.print(rs.getString("admin_dob")); %>"></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="submit" name="editprofile_submit" value="Change Profile" class="btn btn-dark d-flex justify-content-center px-5 py-2 my-3"></td>
                        </tr>
                    </table>
                </div>

            </div>
        </div>
    </form>
    <% }%>
</body>
</html>
