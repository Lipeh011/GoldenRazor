<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%
    Integer clienteId = (Integer) session.getAttribute("usuarioId");
    String nome = "", email = "", telefone = "";

    if (clienteId != null) {
        // Lógica para tratar a alteração de informações
        if ("salvar".equals(request.getParameter("action"))) {
            String novoNome = request.getParameter("nome");
            String novoEmail = request.getParameter("email");
            String novoTelefone = request.getParameter("telefone");

            try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
                PreparedStatement st = conecta.prepareStatement("UPDATE clientes SET nome=?, email=?, telefone=? WHERE id=?");
                st.setString(1, novoNome);
                st.setString(2, novoEmail);
                st.setString(3, novoTelefone);
                st.setInt(4, clienteId);
                st.executeUpdate();
                nome = novoNome;
                email = novoEmail;
                telefone = novoTelefone;
                session.setAttribute("mensagemSucesso", "Informações atualizadas com sucesso!");
            } catch (SQLException e) {
                out.println("<p>Erro ao salvar alterações: " + e.getMessage() + "</p>");
            }
        }

        // Lógica para buscar as informações do cliente
        try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
            PreparedStatement st = conecta.prepareStatement("SELECT nome, email, telefone FROM clientes WHERE id=?");
            st.setInt(1, clienteId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                nome = rs.getString("nome");
                email = rs.getString("email");
                telefone = rs.getString("telefone");
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            out.println("<p>Erro: " + e.getMessage() + "</p>");
        }

        // Lógica para agendar um novo serviço
        if ("agendar".equals(request.getParameter("action"))) {
            String data = request.getParameter("data");
            String horario = request.getParameter("horario");
            int barbeiroId = Integer.parseInt(request.getParameter("barbeiro_id"));
            String tipoCorte = request.getParameter("tipo_corte");

            try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
                PreparedStatement st = conecta.prepareStatement("INSERT INTO agendamentos (cliente_id, data, horario, barbeiro_id, tipo_corte) VALUES (?, ?, ?, ?, ?)");
                st.setInt(1, clienteId);
                st.setString(2, data);
                st.setString(3, horario);
                st.setInt(4, barbeiroId);
                st.setString(5, tipoCorte);
                st.executeUpdate();
                session.setAttribute("mensagemSucesso", "Agendamento realizado com sucesso!");
            } catch (SQLException e) {
                out.println("<p>Erro ao agendar: " + e.getMessage() + "</p>");
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Área do Usuário - GoldenRazor</title>
        <link rel="stylesheet" href="../style.css">
        <link rel="stylesheet" href="../css/11-areadousuario.css">
        <link rel="stylesheet" href="../css/8-rodape.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Zen+Antique+Soft&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@1,100;1,400&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    </head>
    </head>
    <body>

        <!-- Mensagem de Sucesso -->
        <div id="mensagem-sucesso" class="mensagem-sucesso" style="display: none;">
            <p id="mensagem-texto"></p>
        </div>

        <!-- Cabeçalho com Logo e Saudação -->
        <header class="header">
            <img src="../assets/GoldenRazor_logo.png" alt="GoldenRazor Logo" class="logo">
            <h1 class="welcome-message">Bem-vindo, <%= nome%></h1>
        </header>

        <div class="container">
            <!-- Barra Lateral de Navegação -->
            <nav class="sidebar">
                <button class="tab-button active" data-tab="info" onclick="showTab('info')">Minhas Informações</button>
                <button class="tab-button" data-tab="agendar" onclick="showTab('agendar')">Agendamentos</button>
                <button class="tab-button" data-tab="agendamentos" onclick="showTab('agendamentos')">Meus Agendamentos</button>
            </nav>

            <!-- Conteúdo Principal -->
            <main class="content">
                <!-- Seção Minhas Informações -->
                <section id="info" class="tab-content active">
                    <div class="form-container">
                        <h2>Minhas Informações</h2>
                        <form action="areadousuario.jsp" method="POST">
                            <label for="nome">Nome:</label>
                            <input type="text" name="nome" value="<%= nome%>" required>

                            <label for="email">Email:</label>
                            <input type="email" name="email" value="<%= email%>" required>

                            <label for="telefone">Telefone:</label>
                            <input type="text" name="telefone" value="<%= telefone%>" required>

                            <button type="submit" name="action" value="salvar">Salvar Alterações</button>
                        </form>
                    </div>
                </section>

                <!-- Seção Agendamentos -->
                <section id="agendar" class="tab-content">
                    <div class="form-container">
                        <h2>Agendar Serviço</h2>
                        <form action="areadousuario.jsp" method="POST">
                            <label for="data">Data:</label>
                            <input type="date" name="data" required>

                            <label for="horario">Horário:</label>
                            <input type="time" name="horario" required>

                            <label for="barbeiro_id">Escolha o Barbeiro:</label>
                            <select name="barbeiro_id" required>
                                <%
                                    try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
                                        PreparedStatement st = conecta.prepareStatement("SELECT id, nome FROM barbeiros");
                                        ResultSet rs = st.executeQuery();
                                        while (rs.next()) {
                                            int barbeiroId = rs.getInt("id");
                                            String barbeiroNome = rs.getString("nome");
                                %>
                                <option value="<%= barbeiroId%>"><%= barbeiroNome%></option>
                                <%
                                        }
                                        rs.close();
                                        st.close();
                                    } catch (SQLException e) {
                                        out.println("<p>Erro: " + e.getMessage() + "</p>");
                                    }
                                %>
                            </select>

                            <label for="tipo_corte">Tipo de Corte:</label>
                            <select name="tipo_corte" required>
                                <option value="Corte Clássico">Corte Clássico</option>
                                <option value="Barba Completa">Barba Completa</option>
                                <option value="Corte Moderno">Corte Moderno</option>
                                <option value="Sombrancelha">Sombrancelha</option>
                            </select>

                            <button type="submit" name="action" value="agendar">Agendar</button>
                        </form>
                    </div>
                </section>

                <!--Meus agendamentos -->            
                <section id="agendamentos" class="tab-content">
                    <div class="form-container">
                        <h2>Meus Agendamentos</h2>
                        <table>
                            <tr>
                                <th>Data</th>
                                <th>Horário</th>
                                <th>Barbeiro</th>
                                <th>Tipo de Corte</th>
                                <th>Ações</th>
                            </tr>
                            <%
                                try {
                                    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd");
                                    PreparedStatement st = conecta.prepareStatement(
                                            "SELECT a.id, a.data, a.horario, b.nome AS barbeiro_nome, a.tipo_corte "
                                            + "FROM agendamentos a "
                                            + "JOIN barbeiros b ON a.barbeiro_id = b.id "
                                            + "WHERE a.cliente_id = ?"
                                    );
                                    st.setInt(1, clienteId);
                                    ResultSet resultado = st.executeQuery();

                                    while (resultado.next()) {
                                        out.print("<tr>");
                                        out.print("<td>" + resultado.getDate("data") + "</td>");
                                        out.print("<td>" + resultado.getTime("horario") + "</td>");
                                        out.print("<td>" + resultado.getString("barbeiro_nome") + "</td>");
                                        out.print("<td>" + resultado.getString("tipo_corte") + "</td>");
                                        out.print("<td>");
                                        out.print("<a button onclick='openEditPopup(" + resultado.getInt("id") + ", \"" + resultado.getDate("data") + "\", \"" + resultado.getTime("horario") + "\", \"" + resultado.getString("barbeiro_nome") + "\", \"" + resultado.getString("tipo_corte") + "\")'>Alterar</button> | ");
                                        out.print("<a href='excluir_agendamento.jsp?id=" + resultado.getInt("id") + "' onclick='return confirm(\"Deseja excluir este agendamento?\");'>Excluir</a>");
                                        out.print("</td>");
                                        out.print("</tr>");
                                    }

                                    resultado.close();
                                    st.close();
                                    conecta.close();
                                } catch (SQLException e) {
                                    out.println("<p>Erro ao exibir agendamentos: " + e.getMessage() + "</p>");
                                }
                            %>
                        </table>
                    </div>
                </section>

                <div id="editPopup" class="popup" style="display: none;">
                    <div class="popup-content">
                        <h2>Alterar Agendamento</h2>
                        <form id="editForm" action="alterar_agendamento.jsp" method="POST">
                            <input type="hidden" name="id" id="editId">

                            <label for="editData">Data:</label>
                            <input type="date" name="data" id="editData" required>

                            <label for="editHorario">Horário:</label>
                            <input type="time" name="horario" id="editHorario" required>

                            <label for="editBarbeiro">Barbeiro:</label>
                            <select name="barbeiro_id" id="editBarbeiro" required>
                                <%
                                    try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
                                        PreparedStatement st = conecta.prepareStatement("SELECT id, nome FROM barbeiros");
                                        ResultSet rs = st.executeQuery();
                                        while (rs.next()) {
                                            int barbeiroId = rs.getInt("id");
                                            String barbeiroNome = rs.getString("nome");
                                %>
                                <option value="<%= barbeiroId%>"><%= barbeiroNome%></option>
                                <%
                                        }
                                        rs.close();
                                        st.close();
                                    } catch (SQLException e) {
                                        out.println("<p>Erro: " + e.getMessage() + "</p>");
                                    }
                                %>
                            </select>

                            <label for="editTipoCorte">Tipo de Corte:</label>
                            <select name="tipo_corte" id="editTipoCorte" required>
                                <option value="Corte Clássico">Corte Clássico</option>
                                <option value="Barba Completa">Barba Completa</option>
                                <option value="Corte Moderno">Corte Moderno</option>
                                <option value="Sombrancelha">Sombrancelha</option>
                            </select>

                            <button type="submit">Salvar Alterações</button>
                            <button type="button" onclick="closeEditPopup()">Cancelar</button>
                        </form>
                    </div>
                </div>


            </main>
        </div>
       
            <footer class="footer-container-usuario">
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
                            
        <script>
            function showTab(tabName) {
                const tabs = document.querySelectorAll('.tab-content');
                tabs.forEach(tab => {
                    tab.classList.remove('active');
                });

                const buttons = document.querySelectorAll('.tab-button');
                buttons.forEach(button => {
                    button.classList.remove('active');
                });

                document.getElementById(tabName).classList.add('active');
                const activeButton = document.querySelector(`button[data-tab="${tabName}"]`);
                activeButton.classList.add('active');
            }

            // Exibir mensagem de sucesso, se houver
            <% if (session.getAttribute("mensagemSucesso") != null) {%>
            document.getElementById("mensagem-sucesso").style.display = "block";
            document.getElementById("mensagem-texto").innerText = "<%= session.getAttribute("mensagemSucesso")%>";

            // Remover mensagem após 3 segundos
            setTimeout(() => {
                document.getElementById("mensagem-sucesso").style.display = "none";
            }, 3000);

            // Limpar mensagem da sessão para evitar reexibição
            <% session.removeAttribute("mensagemSucesso"); %>
            <% }%>

            // Funções para manipulação de pop up 
              function openEditPopup(id, data, horario, barbeiro, tipoCorte) {
                document.getElementById('editId').value = id;
                document.getElementById('editData').value = data;
                document.getElementById('editHorario').value = horario;

                // Ajustar barbeiro e tipo de corte
                const barbeiroSelect = document.getElementById('editBarbeiro');
                Array.from(barbeiroSelect.options).forEach(option => {
                    option.selected = option.text === barbeiro;
                });

                const tipoCorteSelect = document.getElementById('editTipoCorte');
                Array.from(tipoCorteSelect.options).forEach(option => {
                    option.selected = option.value === tipoCorte;
                });

                document.getElementById('editPopup').style.display = 'flex';
            }

            function closeEditPopup() {
                document.getElementById('editPopup').style.display = 'none';
            }


        </script>

        <script src="../js/areadousuario.js"></script>
    </body>
</html>
