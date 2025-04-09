
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet(urlPatterns = {"/CreateCashier"})
public class CreateCashier extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Servlet CreateCashier at " + request.getContextPath() + "</h1>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname, password, name, email, number, dob;
        uname = request.getParameter("cashier_uname");
        password = request.getParameter("cashier_password");
        name = request.getParameter("cashier_name");
        email = request.getParameter("cashier_email");
        number = request.getParameter("cashier_num");
        dob = request.getParameter("cashier_dob");
        Connection con;
        Statement stmt;
        int check;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            con.setAutoCommit(false);
            stmt = con.createStatement();
            String insert_login = "INSERT INTO login VALUES('" + uname + "', '" + password + "', 'Cashier');";
            check = stmt.executeUpdate(insert_login);
            if (check > 0) {
                String create_cashier = "INSERT INTO cashier VALUES('" + uname + "', '" + name + "', '" + email + "', '" + number + "', '" + dob + "');";
                check = stmt.executeUpdate(create_cashier);
                if (check > 0) {
                    con.commit();
                    response.sendRedirect("./Admin/Cashiers.jsp");
                } else {
                    con.rollback();
                    response.sendRedirect("./Admin/Cashiers.jsp");
                }
            } else {
                response.sendRedirect("./Admin/Cashiers.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
