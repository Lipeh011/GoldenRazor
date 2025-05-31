<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Excluir Cliente</title>
    </head>
    <body>
        <%
            // Conexão e variáveis
            Connection conecta = null;
            PreparedStatement st = null;
            int clienteId = Integer.parseInt(request.getParameter("cliente_id"));
            try {
                // Conectar ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");

                // Excluir agendamentos relacionados ao cliente
                st = conecta.prepareStatement("DELETE FROM agendamentos WHERE cliente_id = ?");
                st.setInt(1, clienteId);
                st.executeUpdate();
                st.close();

                // Excluir o cliente
                st = conecta.prepareStatement("DELETE FROM clientes WHERE id = ?");
                st.setInt(1, clienteId);
                int status = st.executeUpdate();

                if (status > 0) {
                   response.sendRedirect("areadobarbeiro.jsp?success=Clientes excluido com sucesso!");         
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Erro ao excluir cliente: " + e.getMessage() + "</p>");
            } finally {
                try { if (st != null) st.close(); } catch (Exception ignored) {}
                try { if (conecta != null) conecta.close(); } catch (Exception ignored) {}
            }
        %>

    </body>
</html>
