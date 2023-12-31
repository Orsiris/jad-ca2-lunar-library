package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ContactNumber;
import model.ContactNumberDAO;

/**
 * Servlet implementation class updateContact
 */
@WebServlet("/updateContact")
public class updateContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateContact() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int userId = Integer.parseInt(request.getParameter("userId"));
		String contact = request.getParameter("contact");
		
		ContactNumberDAO ContactNumberDAO = new ContactNumberDAO();

		try {
			int numRowsAffected = ContactNumberDAO.updateContactNumber(userId, contact);

			if (numRowsAffected > 0) {
				response.sendRedirect("jsp/user/profilePage.jsp?success=2");
			} else {
				response.sendRedirect("jsp/userProfile/profilePage.jsp?error=2");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("jsp/userProfile/profilePage.jsp?error=2");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.sendRedirect("jsp/userProfile/profilePage.jsp?error=2");
		}
	}

}
