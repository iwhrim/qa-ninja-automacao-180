#language: pt


Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @temp
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "john_wick@gmail.com" e "k1llth3m4ll"
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentar logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input> " e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_input>"

        Exemplos:
            | email_input      | senha_input   | mensagem_input                   |
            | hyperx@gmail.com | not_my_passwd | Usuário e/ou senha inválidos.    |
            | hyperx@404.com   | k1llth3m4ll   | Usuário e/ou senha inválidos.    |
            | hyperx$gmail.com | k1llth3m4ll   | Oops. Informe um email válido!   |
            |                  | k1llth3m4ll   | Oops. Informe um email válido!   |
            | hyperx@gmail.com |               | Oops. Informe sua senha secreta! |
