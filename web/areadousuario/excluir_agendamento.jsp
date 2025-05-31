<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Declarar as variáveis
            Connection conecta;
            PreparedStatement st;
            int i;
            // Receber o id digitado no formulário
            i = Integer.parseInt(request.getParameter("id"));
            //Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver"); //aponta para a biblioteca JDBC
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");
            // Excluir o produto da tabela do banco de dados
            st = conecta.prepareStatement("DELETE from agendamentos WHERE id=?");
            st.setInt(1, i);
            int status = st.executeUpdate(); //Eexecuta o DELETE na tabela do BD
            if(status==1){
                    response.sendRedirect("../areadousuario/areadousuario.jsp");
                    session.setAttribute("mensagemSucesso", "Agendamento excluido com sucesso!");
            } else {
                    session.setAttribute("mensagemSucesso", "Agendamento não encontrado !");
            }            
          %>  
    </body>
</html>
