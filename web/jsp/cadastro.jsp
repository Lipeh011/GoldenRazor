<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro - Golden Razor</title>
    <style>
        body {
            background-color: #1c1c1c;
            color: #f5f5f5;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .cadastro-container {
            background: linear-gradient(135deg, #2a2a2a, #1e1e1e);
            padding: 40px;
            border-radius: 10px;
            max-width: 450px;
            width: 100%;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.6);
            text-align: center;
            border: 1px solid #31d100;
        }
  
        .cadastro-container h1 {
            font-size: 28px;
            color: #31d100;
            margin-bottom: 20px;
        }
        .feedback {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 16px;
            background-color: rgba(195, 155, 119, 0.1);
            border: 1px solid #31d100;
            color: #FFFFF;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background: #31d100;
            color: white;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
            transition: background 0.3s;
            text-decoration: none;
        }
        .btn:hover {
            background:rgb(15, 128, 0);
        }
    </style>
</head>
<body>
    <div class="cadastro-container">
        <h1>Golden Razor</h1>
        <%
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String telefone = request.getParameter("telefone");
            String senha = request.getParameter("senha");

            if (nome != null && email != null && telefone != null && senha != null) {
                Connection conecta = null;
                PreparedStatement st = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/goldenrazor?useTimezone=true&serverTimezone=UTC";
                    conecta = DriverManager.getConnection(url, "root", "p@$$w0rd");

                    String sql = "INSERT INTO clientes (nome, email, telefone, senha) VALUES (?, ?, ?, ?)";
                    st = conecta.prepareStatement(sql);
                    st.setString(1, nome);
                    st.setString(2, email);
                    st.setString(3, telefone.replaceAll("\\D", ""));
                    st.setString(4, senha);
                    st.executeUpdate();

                    out.print("<div class='feedback'>Usuário cadastrado com sucesso! Agora você pode realizar o login, " + nome + ".</div>");

                } catch (Exception ex) {
                    out.print("<div class='feedback'>Erro ao cadastrar usuário. Por favor, tente novamente mais tarde.</div>");
                } finally {
                    try { if (st != null) st.close(); } catch (Exception ignored) {}
                    try { if (conecta != null) conecta.close(); } catch (Exception ignored) {}
                }
            } else {
                out.print("<div class='feedback'>Preencha todos os campos para se cadastrar.</div>");
            }
        %>
        <a href="../pages/login.html" class="btn">Voltar ao Login</a>
    </div>
</body>
</html>
