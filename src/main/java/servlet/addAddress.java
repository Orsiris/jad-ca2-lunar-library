package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AddressDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addAddress
 */
@WebServlet("/addAddress")
public class addAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addAddress() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int userId = Integer.parseInt(request.getParameter("userId"));
		String addressLine1 = request.getParameter("addressLine1");
		String addressLine2 = request.getParameter("addressLine2");
		int postalCode = Integer.parseInt(request.getParameter("postalCode"));

		AddressDAO AddressDAO = new AddressDAO();

		try {
			int numRowsAffected = AddressDAO.insertAddress(userId, addressLine1, addressLine2, postalCode);

			if (numRowsAffected > 0) {
				response.sendRedirect("jsp/user/profilePage.jsp");
			} else {
				response.sendRedirect("jsp/userProfile/addAddress.jsp?error=1");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("jsp/userProfile/addAddress.jsp?error=1");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.sendRedirect("jsp/userProfile/addAddress.jsp?error=1");
		}
	}

}
