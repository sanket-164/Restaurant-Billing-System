
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

@WebServlet(urlPatterns = {"/ManageCashier"})
public class ManageCashier extends HttpServlet {

    Connection con;
    Statement stmt;
    int check = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Servlet UpdateCashier at " + request.getContextPath() + "</h1>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            con.setAutoCommit(false);
            String delete_cashier = "DELETE FROM cashier WHERE cashier_uname='" + request.getParameter("cashier_uname") + "' ;";
            check = stmt.executeUpdate(delete_cashier);
            if (check > 0) {
                String delete_login = "DELETE FROM login WHERE username='" + request.getParameter("cashier_uname") + "' ;";
                check = stmt.executeUpdate(delete_login);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname, name, email, number, dob;
        uname = request.getParameter("cashier_uname");
        name = request.getParameter("cashier_name");
        email = request.getParameter("cashier_email");
        number = request.getParameter("cashier_num");
        dob = request.getParameter("cashier_dob");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            String update_cashier = "UPDATE cashier SET cashier_name='" + name + "', "
                    + "cashier_email='" + email + "', "
                    + "cashier_num='" + number + "', "
                    + "cashier_dob='" + dob + "' WHERE cashier_uname='" + uname + "';";
            check = stmt.executeUpdate(update_cashier);
            out.print(update_cashier);
            if (check > 0) {
                response.sendRedirect("./Admin/Cashiers.jsp");
            } else {
                response.sendRedirect("./Admin/Cashiers.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
