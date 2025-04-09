<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cashiers</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="./NavBar.js"></script>
    </head>
    <body>
    <header-component></header-component>
        <%!
            Connection con;
            Statement stmt;
            ResultSet rs;
            int counter = 0;
        %>
        <div class="container">

            <div class="d-flex justify-content-between my-3">
                <h2 class="ms-4">Cashiers</h2>
                <a href="./CreateCashier.html" class="btn btn-dark me-3"><h5>Create Cashier</h5></a>
            </div>
            <table class="table border border-dark">
                <thead>
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Username</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Mobile No.</th>
                        <th scope="col">Birth Date</th>
                        <th scope="col">Update</th>
                        <th scope="col">Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
                        stmt = con.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM cashier");
                        while (rs.next()) {
                        counter++;
                    %>
                    <tr>
                <form action="../ManageCashier" method="post">
                    <th scope="row"><% out.print(counter); %></th>
                    <input type="hidden" value="<% out.print(rs.getString("cashier_uname")); %>" name="cashier_uname">
                    <th scope="row"><h5><% out.print(rs.getString("cashier_uname")); %></h5></th>
                    <td><input type="text" value="<% out.print(rs.getString("cashier_name")); %>" name="cashier_name"></td>
                    <td><input type="email" value="<% out.print(rs.getString("cashier_email")); %>" name="cashier_email"></td>
                    <td><input type="number" value="<% out.print(rs.getString("cashier_num")); %>" name="cashier_num"></td>
                    <td><input type="date" value="<% out.print(rs.getString("cashier_dob")); %>" name="cashier_dob"></td>
                    <td><input type="submit" class="btn btn-outline-dark" name="submit" value="Update"></td>
                    <td><a href="../ManageCashier?cashier_uname=<% out.print(rs.getString("cashier_uname")); %>" class="btn btn-outline-danger">Delete</a></td>
                </form>
                </tr>

                <% } counter = 0;%>
                </tbody>
            </table>
        </div>
    </body>
</html>
