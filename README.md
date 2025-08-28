# GoldenRazor - Sistema Integrado de Gestão e Apresentação para Barbearias

GoldenRazor é um sistema completo de **gestão e apresentação** desenvolvido para barbearias de alto padrão. O projeto une uma experiência visual refinada com funcionalidades práticas, entregando um painel funcional para **clientes e barbeiros**, com foco em agilidade, organização e estética premium.

---

## Funcionalidades

- **Landing Page Apresentativa**: Mostra serviços, galeria, localização e informações da marca.
- **Painel do Cliente**: Cadastro, login, agendamento de cortes e gerenciamento de perfil.
- **Painel do Barbeiro**: Visualização de agendamentos diários, com controle administrativo completo.
- **Sistema de Agendamentos**: Seleção de serviços, datas e horários com validação.
- **Gestão de Perfis**: CRUD completo para usuários (clientes e barbeiros).
- **Visual Premium**: Interface com tema branco, dourado e preto. Totalmente responsivo.

---

## Tecnologias Utilizadas

- **JSP** (Java Server Pages) para renderização server-side.
- **Tomcat** como servidor de aplicação.
- **MySQL** como banco de dados relacional.
- **JDBC** para conexão direta e gerenciamento do banco.
- **HTML, CSS, JavaScript puro** no front-end.
- **Validações com Regex** em campos de login e cadastro.
  
---

## Por que sem frameworks?

A proposta do projeto foi construir tudo sem usar frameworks como Spring ou Angular. Isso garante:

- Domínio completo sobre rotas, autenticação, sessão, conexão com banco e segurança.
- Clareza na lógica de programação e na arquitetura.
- Fundamento forte pra futuras migrações de stack com segurança.

---

## Melhorias Futuras

O GoldenRazor foi estruturado com possibilidade de evolução. A seguir, os próximos passos de atualização tecnológica:

- Migrar back-end para **Spring Boot**, usando padrão MVC e segurança com Spring Security.
- Trocar o front-end por **Angular ou React** com API REST.
- Integrar **JPA/Hibernate** para abstração de banco.
- Usar **JWT** ou **OAuth2** para autenticação moderna.
- Implementar versão mobile com **Flutter** ou PWA.

---

## Demonstração

![Galeria](https://github.com/user-attachments/assets/4324d8b1-2f4b-410f-995a-e27b65004124)

[Clique aqui para ver o vídeo de demonstração](https://youtu.be/ofKipAi2vL8)

---

## Como Executar

1. Clone este repositório.
2. Importe o banco de dados MySQL .
3. Configure o Tomcat apontando para o projeto.
4. Inicie o servidor.
5. Acesse a aplicação via navegador (ex: `http://localhost:8080/GoldenRazor`).


