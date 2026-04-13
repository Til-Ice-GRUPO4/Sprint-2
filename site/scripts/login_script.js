function changePage(_path) {
    // Levar para a página do parâmetro
    window.location.href = _path
}

function auth_login() {
    // Lógica de login
    let email = ipt_email.value
    let password = ipt_senha.value

    email = email.trim()

    let allowed_email = "admin@gmail.com"
    let allowed_password = "admin123"

    if (email == "") {
        alert("Campo email não pode estar vazio")
    }

    if (password == "") {
        alert("Campo senha não pode estar vazio")
    }

    if (email == allowed_email && password == allowed_password) {
        alert("Admin entrou!")
        changePage("../../index.html")
    } else {
        alert("Email/Senha incorreto(s)")
    }
}

function auth_register() {
    // Lógica de cadastro
    let email = ipt_email.value
    let senha = ipt_senha.value
    let confirmar_senha = ipt_confirmar_senha.value

    email = email.trim()

    changePage("./register2.html")
}