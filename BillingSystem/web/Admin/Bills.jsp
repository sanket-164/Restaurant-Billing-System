<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bills</title>
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

        <h2 class="my-3 ms-3" >Bills</h2>
        <table class="table border border-dark">
            <thead>
                <tr>
                    <th scope="col">No.</th>
                    <th scope="col">Customer Name</th>
                    <th scope="col">Customer Number</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Time</th>
                    <th scope="col">Cashier Username</th>
                    <th scope="col">Update</th>
                    <th scope="col">Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM bills");
                    while (rs.next()) {
                    counter++;
                %>
                <tr>
            <form action="../ManageBill" method="post">
                <th scope="row"><% out.print(counter); %></th>
                <input type="hidden" value="<% out.print(rs.getString("bill_id")); %>" name="bill_id">
                <td><input type="text" value="<% out.print(rs.getString("customer_name")); %>" name="customer_name"></td>
                <td><input type="number" value="<% out.print(rs.getString("customer_num")); %>" name="customer_num"></td>
                <td><input type="number" value="<% out.print(rs.getString("bill_amount")); %>" name="bill_amount"></td>
                <td><% out.print(rs.getString("bill_time")); %></td>
                <td><% out.print(rs.getString("cashier_uname")); %></td>
                <td><input type="submit" class="btn btn-outline-dark" name="submit" value="Update"></td>
                <td><a href="../ManageBill?bill_id=<% out.print(rs.getString("bill_id")); %>" class="btn btn-outline-danger">Delete</a></td>
            </form>
            </tr>

            <% }counter = 0;%>
            </tbody>
        </table>
    </div>
</body>
</html>
