package com.miniproject.phonetail.controller.action;

import java.io.IOException;

import com.miniproject.phonetail.DAO.MemberDAO;
import com.miniproject.phonetail.DTO.MemberDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		MemberDAO mdao = MemberDAO.getInstance();
		MemberDTO mdto = mdao.getMember(userid);
		
		String url = "member/loginForm.jsp";
		
		if( mdto == null ) 
			request.setAttribute("message", "아이디가 없습니다");
		else if( !mdto.getPwd().equals(pwd) ) 
			request.setAttribute("message", "패스워드가 틀립니다");
		else if( mdto.getUsestate().equals("N") ) 
			request.setAttribute("message", "해당 계정은 휴면상태이거나 탈퇴상태입니다. 관리자에게 문의하세요");
		else if( mdto.getPwd().equals(pwd) ) {
			url = "phonetail.do?command=main";
			HttpSession session = request.getSession();
			session.setAttribute("login", mdto);
		}else 
			request.setAttribute("message", "관리자에게 문의하세요");
		
		request.getRequestDispatcher(url).forward(request, response);

	}

}
