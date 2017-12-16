<%@ page import ="java.sql.*" %>
<%
    String productname = request.getParameter("productname");    
   // String pwd = request.getParameter("pass");
   productname = "{"+productname+"}";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/local_schema","root","");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select V2 from dataset where V1='" + productname +"'");
   /* int i=1;
    String predicted[];
    while(rs.next()){
    	predicted[i]=rs.getString(i);
        i++;
       }
    */
  
   if (rs.isBeforeFirst() ) {
       // session.setAttribute("userid", userid);
       while(rs.next()){
        out.println("The Entered Product ==> " + productname);
        out.println("The Predicted Products are ==> "+rs.getString(1));
       }
    
    //  out.println("The Predicted Products are ==> "+rs.getString(2));
       // response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }

    
%>