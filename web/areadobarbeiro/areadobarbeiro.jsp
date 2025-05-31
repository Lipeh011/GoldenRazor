<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/12-areadobarbeiro.css">
        <link rel="stylesheet" href="../css/8-rodape.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Zen+Antique+Soft&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@1,100;1,400&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <title>Área do Barbeiro</title>
        <script>

            function hideMessage() {
                setTimeout(() => {
                    const messageDiv = document.getElementById("message");
                    if (messageDiv) {
                        messageDiv.style.display = "none";
                    }
                }, 3000);
            }
        </script>
    </head>
    
    <header class="main-header">
    <div class="logo-container">
        <img src="../assets/GoldenRazor_logo.png" alt="Golden Razor" class="logo">
    </div>
    <nav class="navbar">
        <ul class="nav-links">
            <li><a href="#clientes">Clientes</a></li>
            <li><a href="#barbeiros">Barbeiros</a></li>
        </ul>
    </nav>
    <div class="header-info">
        <h1>Golden Razor</h1>
    </div>
</header>

    
    
    <body onload="hideMessage()">
        <div class="container">
            <h2>Gestão de Clientes</h2>

            <!-- Mensagens de Feedback -->
            <div id="message" style="color: green; display: <%= (request.getParameter("success") != null ? "block" : "none")%>;">
                <%= request.getParameter("success")%>
            </div>
            <div id="message" style="color: red; display: <%= (request.getParameter("error") != null ? "block" : "none")%>;">
                <%= request.getParameter("error")%>
            </div>

            <!-- Lista de Clientes -->
            <table id="clientes">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>Telefone</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");

                            stmt = conn.prepareStatement("SELECT * FROM clientes");
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id")%></td>
                        <td><%= rs.getString("nome")%></td>
                        <td><%= rs.getString("email")%></td>
                        <td><%= rs.getString("telefone")%></td>
                        <td>
                            <form method="post" action="excluir_cliente.jsp" style="display:inline;">
                                <input type="hidden" name="cliente_id" value="<%= rs.getInt("id")%>">
                                <button type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='5'>Erro ao listar clientes: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                            } catch (SQLException ignored) {
                            }
                            try {
                                if (stmt != null) {
                                    stmt.close();
                                }
                            } catch (SQLException ignored) {
                            }
                            try {
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (SQLException ignored) {
                            }
                        }
                    %>
                </tbody>
            </table>

            <h2>Adicionar Barbeiro</h2>
            <!-- Formulário para Adicionar Barbeiro -->
            <div class="form-container" id="barbeiros">
                <form method="post" action="adicionar_barbeiro.jsp">
                    <label for="nome">Nome do Barbeiro:</label>
                    <input type="text" id="nome" name="nome" required>
                    <button type="submit">Adicionar</button>
                </form>
            </div>


            <h2>Gestão de Barbeiros</h2>

            <!-- Lista de Barbeiros -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");

                            stmt = conn.prepareStatement("SELECT * FROM barbeiros");
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id")%></td>
                        <td><%= rs.getString("nome")%></td>
                        <td>
                            <form method="post" action="excluir_barbeiro.jsp" style="display:inline;">
                                <input type="hidden" name="barbeiro_id" value="<%= rs.getInt("id")%>">
                                <button type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='3'>Erro ao listar barbeiros: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                            } catch (SQLException ignored) {
                            }
                            try {
                                if (stmt != null) {
                                    stmt.close();
                                }
                            } catch (SQLException ignored) {
                            }
                            try {
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (SQLException ignored) {
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <footer class="footer-container">
            <div class="footer-content">
                <div class="footer-section">
                    <div class="footer-logo">Golden Razor</div>
                    <p>A barbearia premium que combina tradição com modernidade para oferecer um corte de cabelo e barba impecável.</p>
                </div>
                <div class="footer-section">
                    <h4>Contato</h4>
                    <p>Endereço: Avenida Europa, 1923 - Cidade, Estado</p>
                    <p>Telefone: (11) 98765-4321</p>
                    <p>Email: contato@goldenrazor.com</p>
                </div>
                <div class="footer-section">
                    <h4>Siga-nos</h4>
                    <div class="footer-socials">
                        <a href="#" target="_blank" aria-label="Facebook"><i class="fab fa-facebook"></i></a>
                        <a href="#" target="_blank" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
                <div class="footer-section">
                    <h4>Links Úteis</h4>
                    <div class="footer-links">
                        <a href="#sobre">Sobre Nós</a>
                        <a href="#servicos">Serviços</a>
                        <a href="#contato">Contato</a>
                        <a href="#horarios">Horários</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                &copy; 2024 Golden Razor - Todos os direitos reservados.
            </div>
        </footer>


    </body>
</html>
