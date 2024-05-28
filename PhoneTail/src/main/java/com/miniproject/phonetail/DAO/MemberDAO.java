package com.miniproject.phonetail.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.miniproject.phonetail.DTO.MemberDTO;
import com.miniproject.phonetail.util.DB;

public class MemberDAO {
	
	private MemberDAO() {}
	private static MemberDAO itc = new MemberDAO();
	public static MemberDAO getInstance() { return itc; }
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public MemberDTO getMember(String userid) {
		
		MemberDTO mdto = null;
		con = DB.getConnection();
		String sql = "select * from member where userid=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				mdto = new MemberDTO();
				mdto.setUserid( rs.getString("userid") );
				mdto.setPwd(rs.getString("pwd"));
				mdto.setName(rs.getString("name"));
				mdto.setEmail(rs.getString("email"));
				mdto.setZip_num(rs.getString("zip_num"));
				mdto.setAddress1(rs.getString("address1"));
				mdto.setAddress2(rs.getString("address2"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setUsestate(rs.getString("usestate"));
				mdto.setIndate(rs.getTimestamp("indate"));
			}
		} catch (SQLException e) { e.printStackTrace();
		} finally { DB.close(con, pstmt, rs); }
		return mdto;
	}
	
}
