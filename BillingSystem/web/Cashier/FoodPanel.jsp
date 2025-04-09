<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%!
    Connection cn;
    Statement stmt, stmt2, stmt3, stmt4, stmt5, stmt6;
    ResultSet rs_of_drinks, rs_of_gujrati, rs_of_chinese, rs_of_fast_food, rs_of_allfood, rs_of_alldrink;

    double total_of_drinks = 0;
    double total_of_foods = 0;
    double total = 0;

    String customer_name = "0";
    String phone_number = "0";
    String bill_number = "0";

%>

<%

    Class.forName("com.mysql.cj.jdbc.Driver");
    cn = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
    stmt = cn.createStatement();
    stmt2 = cn.createStatement();
    stmt3 = cn.createStatement();
    stmt4 = cn.createStatement();
    stmt5 = cn.createStatement();
    stmt6 = cn.createStatement();

    rs_of_drinks = stmt.executeQuery("select * from food_item where food_category='Drinks'");

    rs_of_chinese = stmt2.executeQuery("select * from food_item where food_category='Chinese'");
    rs_of_gujrati = stmt3.executeQuery("select * from food_item where food_category='Gujarati'");
    rs_of_fast_food = stmt4.executeQuery("select * from food_item where food_category='fast food'");

    rs_of_alldrink = stmt6.executeQuery("select * from food_item where food_category='Drinks'");
    rs_of_allfood = stmt5.executeQuery("select * from food_item where food_category!='Drinks' ");
%>

<!-- //after form submit click on total-->

<%     String x = request.getParameter("submit");
    if (x != null && "POST".equals(request.getMethod())) {

        total_of_drinks = 0;
        total_of_foods = 0;
        total = 0;

        customer_name = request.getParameter("customer_name");
        phone_number = request.getParameter("phone_number");
        bill_number = request.getParameter("bill_number");

//   getting item and its value in hashmap first here
// make maps with name and price
// and make maps with name and quentity
        HashMap< String, Integer> hash_map_of_drink_and_price = new HashMap< String, Integer>();
        HashMap< String, Integer> hash_map_of_food_and_price = new HashMap< String, Integer>();

        Vector<String> all_drink_name = new Vector<String>();
        Vector<String> all_food_name = new Vector<String>();

        while (rs_of_alldrink.next()) {
            hash_map_of_drink_and_price.put(rs_of_alldrink.getString(2), rs_of_alldrink.getInt(4));
            all_drink_name.add(rs_of_alldrink.getString(2));

        }

        while (rs_of_allfood.next()) {
            hash_map_of_food_and_price.put(rs_of_allfood.getString(2), rs_of_allfood.getInt(4));
            all_food_name.add(rs_of_allfood.getString(2));

        }

        //   now check how many item is order...
        HashMap< String, Integer> hash_map_of_drink_and_quantity = new HashMap< String, Integer>();
        HashMap< String, Integer> hash_map_of_food_and_quantity = new HashMap< String, Integer>();

        try {
            if (hash_map_of_drink_and_price.size() > 0) {
                for (int i = 0; i < hash_map_of_drink_and_price.size(); i++) {

                    String drink_quantity = request.getParameter(all_drink_name.get(i));
                    int drink_quantity_int = Integer.parseInt(drink_quantity);

                    hash_map_of_drink_and_quantity.put(all_drink_name.get(i), drink_quantity_int);

                }
            }
        } catch (Exception e) {
            out.println("pelu   " + e);
        }

        // calculate total price for each item based on quantity
        try {
            if (hash_map_of_food_and_price.size() > 0) {
                for (int j = 0; j < hash_map_of_food_and_price.size(); j++) {
                    String str = all_food_name.get(j);
                    String[] words = str.split(" ");
                    String firstWord = words[0];

// i am using only first work here because when i give full string to elment as name it take only first name . so also for retrive  i use first word.
                    String food_quantity = request.getParameter(firstWord);
                    //  out.print(" food_quantity"+all_food_name.POST());

                    int food_quantity_int = Integer.parseInt(food_quantity);
                    hash_map_of_food_and_quantity.put(all_food_name.get(j), food_quantity_int);
                }
            }
            //  Block of code to try
        } catch (Exception e) {
            out.println("last " + e);
            //  Block of code to handle errors
        }

        //calculate total price for each item based on quantity
        for (String drinkname : hash_map_of_drink_and_price.keySet()) {
            double price = hash_map_of_drink_and_price.get(drinkname);
            int quantity = hash_map_of_drink_and_quantity.get(drinkname);
            double totalPrice = price * quantity;
            total_of_drinks = total_of_drinks + totalPrice;

        }

        try {
            //  Block of code to try
            for (String foodname : hash_map_of_food_and_price.keySet()) {
                double price = hash_map_of_food_and_price.get(foodname);
                int quantity = hash_map_of_food_and_quantity.get(foodname);

                double totalPrice = price * quantity;;
                total_of_foods = total_of_foods + totalPrice;
            }
        } catch (Exception e) {
            //  Block of code to handle errors
            out.println("error in find foof total " + e);
        }
        total = total_of_drinks + total_of_foods;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Food Panel</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <script>
            function submitForm() {
                var form = document.getElementById("myForm"); // POST reference to form element
                var submitter = event.submitter; // POST reference to clicked submit button
                if (submitter.name === "submit") { // if first submit button was clicked
                    form.action = "FoodPanel.jsp"; // submit to self (empty action attribute)
                } else if (submitter.name === "generate_bill") { // if second submit button was clicked
                    form.action = "Bill.jsp"; // submit to second.jsp
                } else if (submitter.name === "clear_bill") { // if second submit button was clicked
                    form.action = "FoodPanel.jsp"; // submit to second.jsp
                } else if (submitter.name === "logout") {
                    form.action = "../Authentication/Login.html";
                }
                return true; // allow form submission to proceed
            }
        </script>
        <style>
            body{
                background-color: #cccccc;
            }

            h1{
                margin: 0 !important;
                padding: 0 !important;
            }

            .width25{
                width: 25%;
            }
            .width20{
                width: 100%;
            }
            .margin10{
                margin: 10px;

            }
            .margin20{
                margin: 10px;
            }

            .margin5{
                margin: 5px;
            }

            .darkgray{
                background-color: #999999;
                padding-top: 10px;
            }

            #menu_items_div{
                display: flex;
                flex-direction: row;
            }

            #bill_menu_div{
                display: flex;
                flex-direction: row;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form id="myForm"  method="POST"  onsubmit="return submitForm()">
                <!--customerr detaill--> 
                <div id="customer_detail" class="container my-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="customer_name" class="form-label">Customer Name</label>
                            <input type="text" id="customer_name" name="customer_name" class="form-control" required 
                                   value=<% String aa = request.getParameter("submit");
                                       if (aa != null && "POST".equals(request.getMethod())) {
                                           out.println(customer_name);
                                       }%>>
                        </div>
                        <div class="col-md-6">
                            <label for="phone_number" class="form-label">Phone Number</label>
                            <input type="text" id="phone_number" name="phone_number" class="form-control" required 
                                   value=<% String ss = request.getParameter("submit");
                                       if (ss != null && "POST".equals(request.getMethod())) {
                                           out.println(phone_number);
                                       } %>>
                        </div>
                    </div>
                </div>



                <!--select meni item rowwwww-->
                <div id="menu_items_div" class="row">
                    <!-- Gujarati Section -->
                    <div id="colddrinks_div" class="col-md-3 darkgray">
                        <h4 class="text-center">Gujarati</h4>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    while (rs_of_gujrati.next()) {

                                        out.println("<tr>");
                                        out.println("<td><h6>" + rs_of_gujrati.getString(2) + "</td>");
                                        out.println("<td><input type='text' class='width20' value=");
                                        String qq = request.getParameter("submit");
                                        if (qq != null && "POST".equals(request.getMethod())) {
                                            String str = rs_of_gujrati.getString(2);
                                            String[] words = str.split(" ");
                                            String firstWord = words[0];
                                            out.println(request.getParameter(firstWord));
                                        } else {
                                            out.println("0");
                                        }
                                        out.println("  name=" + rs_of_gujrati.getString(2) + "> </h6></td>");
                                        out.println("<td>" + rs_of_gujrati.getString(4) + "</td></tr>");
                                    }
                                %>

                            </tbody>
                        </table>
                    </div>

                    <!--2--><div id="starter_div" class="col-md-3 darkgray">
                        <h4 class="text-center">Chinese</h4>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs_of_chinese.next()) {
                                        out.println("<tr><td><h6>" + rs_of_chinese.getString(2) + "</td><td><input type='text' class='width20' value=");
                                        String ww = request.getParameter("submit");
                                        if (ww != null && "POST".equals(request.getMethod())) {
                                            String str = rs_of_chinese.getString(2);
                                            String[] words = str.split(" ");
                                            String firstWord = words[0];
                                            out.println(request.getParameter(firstWord));
                                        } else {
                                            out.println("0");
                                        }

                                        out.println("name=" + rs_of_chinese.getString(2) + "> </h6></td><td>" + rs_of_chinese.getString(4) + "</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!--3-->
                    <div id="main_dish_div" class="col-md-3 darkgray">
                        <h4 class="text-center">Fast Food</h4>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs_of_fast_food.next()) {
                                        out.println("<tr><td><h6>" + rs_of_fast_food.getString(2) + "</td><td><input type='text' class='width20' value=");
                                        String ww = request.getParameter("submit");
                                        if (ww != null && "POST".equals(request.getMethod())) {
                                            String str = rs_of_fast_food.getString(2);
                                            String[] words = str.split(" ");
                                            String firstWord = words[0];
                                            out.println(request.getParameter(firstWord));
                                        } else {
                                            out.println("0");
                                        }

                                        out.println("name=" + rs_of_fast_food.getString(2) + "> </h6></td><td>" + rs_of_fast_food.getString(4) + "</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!--4-->
                    <div id="full_dish_div" class="col-md-3 darkgray">
                        <h4 class="text-center">Drinks</h4>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody><%
                                while (rs_of_drinks.next()) {
                                    //out.println("<tr><td><h6>"+rs_of_full_dish.getString(1)+"</td><td><input type='text' class='width20' placeholder="+rs_of_full_dish.getString(1)+" value="+rs_of_full_dish.getString(1)+" name="+rs_of_full_dish.getString(1)+"> </h6></td><td>"+rs_of_full_dish.getString(2)+"</td></tr>");
                                    out.println("<tr><td><h6>" + rs_of_drinks.getString(2) + "</td><td><input type='text' class='width20' value=");
                                    String ee = request.getParameter("submit");
                                    if (ee != null && "POST".equals(request.getMethod())) {
                                        String str = rs_of_drinks.getString(2);
                                        String[] words = str.split(" ");
                                        String firstWord = words[0];
                                        out.println(request.getParameter(firstWord));
                                    } else {
                                        out.println("0");
                                    }

                                    out.print(" name=" + rs_of_drinks.getString(2) + "> </h6></td><td>" + rs_of_drinks.getString(4) + "</td></tr>");

                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!--menu item select ends-->


                <div id="bill_menu_div" class="row mt-4">
                    <!-- Bill Menu -->
                    <div class="col-md-6">
                        <h4>Food Bill</h4>
                        <table class="table table-bordered">
                            <tr>
                                <td>Total of all drinks:</td>
                                <td>
                                    <input type="text" class="form-control" name="total_of_drinks" disabled="true"
                                           value="<% String xx = request.getParameter("submit");
                                               if (xx != null && "POST".equals(request.getMethod())) {
                                                   out.println(total_of_drinks);
                                               } else {
                                                   out.println("0");
                                               } %>">
                                </td>
                            </tr>
                            <tr>
                                <td>Total of all food:</td>
                                <td>
                                    <input type="text" class="form-control" name="total_of_foods" disabled="true"
                                           value="<% String xy = request.getParameter("submit");
                                               if (xy != null && "POST".equals(request.getMethod())) {
                                                   out.println(total_of_foods);
                                               } else {
                                                   out.println("0");
                                               } %>">
                                </td>
                            </tr>
                            <tr>
                                <td>Total:</td>
                                <td>
                                    <input type="text" class="form-control" name="total" readonly
                                           value="<% String yy = request.getParameter("submit");
                                               if (yy != null && "POST".equals(request.getMethod())) {
                                                   out.println(total);
                                               } else {
                                                   out.println("0");
                                               } %>">
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- Tax Details -->
                    <div class="col-md-6">
                        <h4>Tax</h4>
                        <table class="table table-bordered">
                            <tr>
                                <td>3% tax on drinks:</td>
                                <td>
                                    <input type="text" class="form-control" name="tax_on_drinks" disabled
                                           value="<% String rr = request.getParameter("submit");
                                               if (rr != null && "POST".equals(request.getMethod())) {
                                                   out.println(total_of_drinks * 0.03);
                                               } else {
                                                   out.println("0");
                                               } %>">
                                </td>
                            </tr>
                            <tr>
                                <td>5% tax on food:</td>
                                <td>
                                    <input type="text" class="form-control" name="tax_on_food" disabled="true"
                                           value="<% String tt = request.getParameter("submit");
                                               if (tt != null && "POST".equals(request.getMethod())) {
                                                   out.println(total_of_foods * 0.05);
                                               } else {
                                                   out.println("0");
                                               } %>">
                                </td>
                            </tr>
                            <tr>
                                <td>Total tax:</td>
                                <td>
                                    <input type="text" class="form-control" name="xxx" readonly
                                           value="<% String uu = request.getParameter("submit");
                                               if (uu != null && "POST".equals(request.getMethod())) {
                                                   out.println(total_of_drinks * 0.03 + total_of_foods * 0.05);
                                               } else {
                                                   out.println("0");
                                               }%>">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="d-flex justify-content-center">
                    <input type="submit" value="Total" name="submit" class="btn btn-light px-4 py-3 mx-2">
                    <input type="submit" value="Clear" name="clear_bill" class="btn btn-light px-4 py-3 mx-2">
                </div>

                <% if ("POST".equals(request.getMethod())) {
                        out.print("<div class=\"d-flex justify-content-center my-4\"><input type = \"submit\" value = \"Bill\" name = \"generate_bill\" class=\"btn btn-light mx-2 px-4 py-3> </div>");
                    }
                %>
        </div>
    </div>
</form>
<<form action="../Authentication/Login.html">
    <div class="d-flex justify-content-center">
        <input type="submit" value="Logout" name="logout" class="btn btn-danger px-4 py-3 mx-2">
    </div>
</form>
</body>
</html>

</html>
