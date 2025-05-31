function mostrarMensagemErro(input, mensagem) {
    const mensagemErro = document.getElementById('mensagemErro');
    mensagemErro.style.display = 'block';
    mensagemErro.innerHTML = mensagem;
    input.classList.add('erro'); 
}

function limparMensagemErro(input) {
    const mensagemErro = document.getElementById('mensagemErro');
    mensagemErro.style.display = 'none';
    mensagemErro.innerHTML = '';
    input.classList.remove('erro'); 
}

function validarNome() {
    const nome = document.getElementById('nome');
    if (!/^[a-zA-Zà-úÀ-Ú\s]{3,}$/.test(nome.value)) {
        mostrarMensagemErro(nome, 'Por favor, digite um nome válido com pelo menos 3 caracteres.');
    } else {
        limparMensagemErro(nome);
    }
}

function validarEmail() {
    const email = document.getElementById('email');
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email.value)) {
        mostrarMensagemErro(email, 'Por favor, digite um e-mail válido.');
    } else {
        limparMensagemErro(email);
    }
}

function validarTelefone() {
    const telefone = document.getElementById('telefone');
    if (!/^\d{11}$/.test(telefone.value)) {
        mostrarMensagemErro(telefone, 'Por favor, digite um telefone válido com 11 números, incluindo o DDD.');
    } else {
        limparMensagemErro(telefone);
    }
}

function validarSenha() {
    const senha = document.getElementById('senha');
    const senhaRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$/;
    if (!senhaRegex.test(senha.value)) {
        mostrarMensagemErro(senha, 'A senha deve conter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma letra minúscula, um número e um caractere especial.');
    } else {
        limparMensagemErro(senha);
    }
}

// Adiciona o evento onblur para validar cada campo
document.getElementById('nome').addEventListener('blur', validarNome);
document.getElementById('email').addEventListener('blur', validarEmail);
document.getElementById('telefone').addEventListener('blur', validarTelefone);
document.getElementById('senha').addEventListener('blur', validarSenha);
