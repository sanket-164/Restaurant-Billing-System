import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/ChangeAdmin"})
public class ChangeAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Servlet ChangeAdmin at " + request.getContextPath() + "</h1>");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name, email, number, dob;
        name = request.getParameter("profile_name");
        email = request.getParameter("profile_email");
        number = request.getParameter("profile_number");
        dob = request.getParameter("profile_dob");
        Connection con;
        Statement stmt;
        int check;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/billing_system", "root", "");
            stmt = con.createStatement();
            String update_admin = "UPDATE admin SET admin_name='" + name + "', "
                    + "admin_email='" + email + "', "
                    + "admin_num='" + number + "', "
                    + "admin_dob='" + dob + "' ;";
            check = stmt.executeUpdate(update_admin);
            if(check > 0){
                response.sendRedirect("./Admin/Profile.jsp");
            }else{
                response.sendRedirect("./Admin/Profile.jsp");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
