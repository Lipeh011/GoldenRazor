<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adicionar Barbeiro</title>
    </head>
    <body>
        <%
            // Variáveis de conexão
            Connection conecta = null;
            PreparedStatement st = null;
    
            // Receber os dados do formulário
            String nomeBarbeiro = request.getParameter("nome");
       
            try {
                // Conectar com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); // Aponta para a biblioteca JDBC
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");

                // Inserir os dados na tabela barbeiros
                String sql = "INSERT INTO barbeiros (nome) VALUES (?)";
                st = conecta.prepareStatement(sql);
                st.setString(1, nomeBarbeiro);

                int rowsAffected = st.executeUpdate(); // Executa o INSERT no banco de dados
                
                // Informar o usuário
                if (rowsAffected > 0) {
                    response.sendRedirect("areadobarbeiro.jsp?success=Um novo barbeiro foi cadastrado com sucesso !"); 
                } else {
                    response.sendRedirect("areadobarbeiro.jsp?success=Ocorreu um erro ao cadastrar o barbeiro!"); 
                }
            } catch (SQLException erro) {
                out.print("<p style='color:red;'>Erro ao cadastrar o barbeiro: " + erro.getMessage() + "</p>");
            } catch (ClassNotFoundException erro) {
                out.print("<p style='color:red;'>Erro: Driver JDBC não encontrado.</p>");
            } finally {
                // Fechar os recursos
                try { if (st != null) st.close(); } catch (SQLException ignored) {}
                try { if (conecta != null) conecta.close(); } catch (SQLException ignored) {}
            }
        %>  
    </body>
</html>
