<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
        <script src="./NavBar.js"></script>
    </head>
    <body>
    <header-component></header-component>
        <%!
            int counter = 0;
            Connection con;
            Statement stmt;
            ResultSet rs;
        %>
    <div class="container">

        <h2 class="my-3 ms-3">Today's Bills</h2>
        <table class="table border border-dark">
            <thead>
                <tr>
                    <th scope="col">No.</th>
                    <th scope="col">Customer Name</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Time</th>
                    <th scope="col">Cashier Username</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM bills WHERE DATE(bill_time)= '" + java.time.LocalDate.now() + "'");
                    while (rs.next()) {
                        counter++;
                %>
                <tr>
                    <th scope="row"><% out.print(counter); %></th>
                    <td><% out.print(rs.getString("customer_name")); %></td>
                    <td><% out.print(rs.getString("bill_amount")); %></td>
                    <td><% out.print(rs.getString("bill_time")); %></td>
                    <td><% out.print(rs.getString("cashier_uname")); %></td>
                </tr>

                <% }
                    counter = 0;%>
            </tbody>
        </table>
    </div>
</body>
</html>
