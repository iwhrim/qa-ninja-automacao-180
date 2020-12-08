#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro
        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome      | email               | senha       |
            | John Wick | john_wick@gmail.com | k1llth3m4ll |
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentativa de Cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_input>"

        Exemplos:
            | nome_input | email_input         | senha_input | mensagem_input                   |
            |            | john_wick@gmail.com | k1llth3m4ll | Oops. Informe seu nome completo! |
            | John Wick  |                     | k1llth3m4ll | Oops. Informe um email válido!   |
            | John Wick  | john_wick$gmail.com | k1llth3m4ll | Oops. Informe um email válido!   |
            | John Wick  | john_wick#gmail.com | k1llth3m4ll | Oops. Informe um email válido!   |
            | John Wick  | john_wick@gmail.com |             | Oops. Informe sua senha secreta! |
