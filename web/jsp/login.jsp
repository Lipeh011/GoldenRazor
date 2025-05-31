<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Golden Razor - Login</title>
        <link rel="stylesheet" href="../style.css">
        <link rel="stylesheet" href="../css/9-login.css">  
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Zen+Antique+Soft&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@1,100;1,400&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    </head>
    <body>

        <main>
            <section id="login-section">
                <div class="login-container">
                    <div class="login-header">
                        <img src="../assets/GoldenRazor_logo.png" alt="Logo Golden Razor" class="login-logo">
                        <h1>Bem-vindo à Golden Razor</h1>
                        <p>Entre ou cadastre-se para uma experiência exclusiva.</p>
                    </div>
                    <div class="login-form-container">
                        <form class="login-form" action="../jsp/login.jsp" method="post">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" placeholder="Digite seu email cadastrado" required>

                            <label for="senha">Senha</label>
                            <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>

                            <button type="submit" class="btn-login">Entrar</button>
                            <p class="alternative-option">Ainda não tem uma conta? <a href="../pages/cadastro.html" class="register-link">Cadastre-se aqui</a></p>
                        </form>
                        <%

                            String email = request.getParameter("email");
                            String senha = request.getParameter("senha");

                            if (email != null && senha != null && !email.isEmpty() && !senha.isEmpty()) {
                                Connection conecta = null;
                                PreparedStatement st = null;
                                ResultSet resultado = null;

                                try {
                                    // Conectar com o banco de dados
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");

                                    // Consulta ao banco de dados
                                    st = conecta.prepareStatement("SELECT * FROM clientes WHERE email=? AND senha=?");
                                    st.setString(1, email);
                                    st.setString(2, senha);
                                    resultado = st.executeQuery();

                                    if (resultado.next()) {
                                        String role = resultado.getString("role");

                                        // Redirecionamento por tipo de usuário
                                        if ("user".equals(role)) {
                                            session.setAttribute("usuarioId", resultado.getInt("id"));
                                            response.sendRedirect("../areadousuario/areadousuario.jsp?nome=" + resultado.getString("nome")
                                                    + "&email=" + resultado.getString("email")
                                                    + "&telefone=" + resultado.getString("telefone"));
                                        } else if ("admin".equals(role)) {
                                            session.setAttribute("adminId", resultado.getInt("id"));
                                            response.sendRedirect("../areadobarbeiro/areadobarbeiro.jsp");
                                        }
                                    } else {
                                        out.print("<div class='error-message'>Email e/ou senha inválidos.</div>");
                                    }
                                } catch (Exception ex) {
                                    out.print("<div class='error-message'>Erro ao processar a solicitação. Tente novamente.</div>");
                                    ex.printStackTrace(); // Para debug
                                } finally {
                                    try {
                                        if (resultado != null) {
                                            resultado.close();
                                        }
                                        if (st != null) {
                                            st.close();
                                        }
                                        if (conecta != null) {
                                            conecta.close();
                                        }
                                    } catch (Exception ignored) {
                                    }
                                }
                            } else {
                                out.print("<div class='error-message'>Preencha todos os campos.</div>");
                            }
                        %>


                    </div>
                </div>
            </section>
        </main>

    </body>
</html>
