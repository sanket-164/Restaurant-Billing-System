import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/ManageBill"})
public class ManageBill extends HttpServlet {
    
    Connection con;
    Statement stmt;
    int check = 0;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Servlet ManageBill at " + request.getContextPath() + "</h1>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            String delete_bill = "DELETE FROM bills WHERE bill_id='" + request.getParameter("bill_id") + "' ;";
            check = stmt.executeUpdate(delete_bill);
            if (check > 0) {
                response.sendRedirect("./Admin/Bills.jsp");
            } else {
                response.sendRedirect("./Admin/Bills.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("bill_id")); 
        String name, number, amount;
        name = request.getParameter("customer_name");
        number = request.getParameter("customer_num");
        amount = request.getParameter("bill_amount");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            String update_cashier = "UPDATE bills SET customer_name='" + name + "', "
                    + "customer_num=" + number + ", bill_amount=" + amount + " WHERE bill_id=" + id + ";";
            check = stmt.executeUpdate(update_cashier);
            out.print(update_cashier);
            if (check > 0) {
                response.sendRedirect("./Admin/Bills.jsp");
            } else {
                response.sendRedirect("./Admin/Bills.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
