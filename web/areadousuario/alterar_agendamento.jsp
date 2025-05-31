<%@page import="java.sql.*"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String data = request.getParameter("data");
    String horario = request.getParameter("horario");
    int barbeiroId = Integer.parseInt(request.getParameter("barbeiro_id"));
    String tipoCorte = request.getParameter("tipo_corte");

    try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/goldenrazor", "root", "p@$$w0rd")) {
        PreparedStatement st = conecta.prepareStatement("UPDATE agendamentos SET data=?, horario=?, barbeiro_id=?, tipo_corte=? WHERE id=?");
        st.setString(1, data);
        st.setString(2, horario);
        st.setInt(3, barbeiroId);
        st.setString(4, tipoCorte);
        st.setInt(5, id);
        st.executeUpdate();
        session.setAttribute("mensagemSucesso", "Agendamento atualizado com sucesso!");
    } catch (SQLException e) {
        session.setAttribute("mensagemErro", "Erro ao atualizar agendamento: " + e.getMessage());
    }
    response.sendRedirect("areadousuario.jsp");
%>
