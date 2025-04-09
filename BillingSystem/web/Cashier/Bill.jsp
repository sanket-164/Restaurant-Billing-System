<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%!
    Connection cn;
    Statement stmt, stmt2, insert_bill;
    ResultSet rs_of_allfood, rs_of_alldrink;

    double total_of_drinks = 0;
    double total_of_foods = 0;
    double total = 0;
    String tax = "o";

    String customer_name = "";
    String phone_number = "";

    HashMap< String, Integer> hash_map_of_drink_and_price = new HashMap< String, Integer>();
    HashMap< String, Integer> hash_map_of_food_and_price = new HashMap< String, Integer>();

    Vector<String> all_drink_name = new Vector<String>();
    Vector<String> all_food_name = new Vector<String>();

    HashMap< String, Integer> hash_map_of_drink_and_quantity = new HashMap< String, Integer>();
    HashMap< String, Integer> hash_map_of_food_and_quantity = new HashMap< String, Integer>();

%>



<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    cn = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
    stmt = cn.createStatement();
    stmt2 = cn.createStatement();
    insert_bill = cn.createStatement();

    rs_of_alldrink = stmt.executeQuery("select * from food_item where food_category='Drinks'");
    rs_of_allfood = stmt2.executeQuery("select * from food_item where food_category!='Drinks' ");

%>


<!-- //after form submit click on total-->

<%     String x = request.getParameter("generate_bill");
    if (x != null && "POST".equals(request.getMethod())) {
        total_of_drinks = 0;
        total_of_foods = 0;
        total = 0;

        customer_name = request.getParameter("customer_name");
        phone_number = request.getParameter("phone_number");

//   getting item and its value in hashmap first here
// make maps with name and price
// and make maps with name and quentity
        while (rs_of_alldrink.next()) {
            hash_map_of_drink_and_price.put(rs_of_alldrink.getString(2), rs_of_alldrink.getInt(4));
            all_drink_name.add(rs_of_alldrink.getString(2));

        }

        while (rs_of_allfood.next()) {
            hash_map_of_food_and_price.put(rs_of_allfood.getString(2), rs_of_allfood.getInt(4));
            all_food_name.add(rs_of_allfood.getString(2));

        }

        //   now check how many item is order...
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

                    int food_quantity_int = Integer.parseInt(food_quantity);
                    hash_map_of_food_and_quantity.put(all_food_name.get(j), food_quantity_int);
                }
            }
            //  Block of code to try
        } catch (Exception e) {
            out.println("last " + e);
            //  Block of code to handle errors
        }

        tax = request.getParameter("xxx");
        total = Double.parseDouble(request.getParameter("total")) + Double.parseDouble(tax);

        try {
            int check = insert_bill.executeUpdate("INSERT INTO bills (customer_name, customer_num, bill_amount, cashier_uname) VALUES"
                    + "('" + customer_name + "'," + phone_number + "," + total + ",'" + request.getSession().getAttribute("username") + "')");
        } catch (Exception e) {
            out.println(e);
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>

        <script>

            function saveDivAsPdf() {

                var element = document.getElementById("milan");
                //  element.style.width = "1500px";

                html2pdf().from(element).set({html2canvas: {scale: 1}, filename: 'Bill.pdf', pagebreak: {mode: ['avoid-all', 'css', 'legacy']}}).save();
            }
        </script>

    </head>
    <body>
        <div name="milan"  id="milan" class="container d-flex justify-content-center mt-3" >
            <div class="card border border-dark col-md-4 text-dark">

                <div class="card-body bg-light ">
                    <div class="card-title d-flex justify-content-center border"><h2>Bill</h2> </div>
                    <p class="card-text  d-flex justify-content-center">Thank you for visiting come again</p>
                    <div class="card-text">Customer name: <% out.println(customer_name);%></div>
                    <div class="card-text">Phone Number: <% out.println(phone_number);%></div>
                    <div>====================================</div>

                    <table class="table">
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Price</th
                        </tr>

                        <%

                            for (int i = 0; i < all_drink_name.size(); i++) {
                                int drinks_qunatity = hash_map_of_drink_and_quantity.get(all_drink_name.get(i));

                                if (drinks_qunatity > 0) {
                                    out.println("<tr><td>" + all_drink_name.get(i));
                                    out.println("</td><td>" + drinks_qunatity);
                                    double total = drinks_qunatity * hash_map_of_drink_and_price.get(all_drink_name.get(i));
                                    out.println("</td><td>" + total);
                                    out.println("</td></tr>");
                                }

                            }

                            all_drink_name.clear();

                            // for food
                            for (int i = 0; i < all_food_name.size(); i++) {
                                int foods_qunatity = hash_map_of_food_and_quantity.get(all_food_name.get(i));

                                if (foods_qunatity > 0) {
                                    out.println("<tr><td>" + all_food_name.get(i));
                                    out.println("</td><td>" + foods_qunatity);
                                    double total = foods_qunatity * hash_map_of_food_and_price.get(all_food_name.get(i));
                                    out.println("</td><td>" + total);
                                    out.println("</td></tr>");
                                }

                            }
                            all_food_name.clear();
                        %>
                        <tr>
                            <td>additional tax :</td>
                            <td></td>
                            <th><%out.println(tax);%></th>
                        </tr>
                        <tr>
                            <td>Total bill amount :</td>
                            <td></td>
                            <th><%out.println(total);%></th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="d-flex justify-content-center">
            <a class="btn btn-dark text-light m-3" href="FoodPanel.jsp">Continue</a>

            <button class="btn btn-dark text-light m-3" onclick="saveDivAsPdf()">Save as PDF</button>
        </div>
    </body>
</html>
