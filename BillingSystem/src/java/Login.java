
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String uname, password;
        uname = request.getParameter("login_username");
        password = request.getParameter("login_password");
        Connection con;
        Statement stmt;
        ResultSet rs;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            String get_user = "SELECT * FROM login WHERE username='" + uname + "';";

            HttpSession session = request.getSession(true);
            session.setAttribute("username", uname);
            
            rs = stmt.executeQuery(get_user);
            if (rs.next()) {
                if (password.equals(rs.getString("password"))) {
                    if (rs.getString("user_role").equals("Admin")) {
                        response.sendRedirect("./Admin/HomePage.jsp");
                    } else {
                        response.sendRedirect("./Cashier/FoodPanel.jsp");
                    }
                } else {
                    response.sendRedirect("./Authentication/Login.html");
                }
            } else {
                response.sendRedirect("./Authentication/Login.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
