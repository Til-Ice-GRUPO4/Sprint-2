function changePage(_path) {
    // Levar para a página do parâmetro
    window.location.href = _path
}

function auth_login() {
    // Lógica de login
    let email = ipt_email.value
    let password = ipt_senha.value

    email = email.trim()

    let allowed_email = "admin@admin.com"
    let allowed_password = "admin123"

    if (email == "") {
        alert("Campo email não pode estar vazio")
        return
    }

    if (password == "") {
        alert("Campo senha não pode estar vazio")
        return
    }

    if (email != allowed_email || password != allowed_password) {
        alert("Email/Senha incorreto(s)")
        return
    }
    
    alert("Admin entrou!")
    changePage("../../index.html")
}

function auth_register_step1() {
    // Lógica da etapa 1 do cadastro
    let email = ipt_email.value
    let password = ipt_senha.value
    let confirm_password = ipt_confirmar_senha.value

    email = email.trim()

    if (email == "") {
        alert("Campo email não pode estar vazio")
        return
    }

    if (password == "") {
        alert("Campo senha não pode estar vazio")
        return
    }

    if (password != confirm_password) {
        alert("Campo 'Confirmar Senha' tem que ser igual ao campo 'Senha'")
        return
    }

    changePage("./register2.html")
}

function auth_register_step2() {
    // Lógica da etapa 2 do cadastro
    let nomeCompleto = ipt_nome_completo.value
    let cpf = ipt_cpf.value
    let nomeUsuario = ipt_nome_usuario.value

    nomeCompleto = nomeCompleto.trim()
    cpf = cpf.trim()
    nomeUsuario = nomeUsuario.trim()

    if (nomeCompleto == "") {
        alert("Campo 'Nome Completo' não pode estar vazio")
        return
    }

    if (cpf == "") {
        alert("Campo 'CPF' não pode estar vazio")
        return
    }
    
    if (nomeUsuario == "") {
        alert("Campo 'Nome de Usuário' não pode estar vazio")
        return
    }

    alert("Novo usuário cadastrado com sucesso!")
    changePage("../../index.html")
}