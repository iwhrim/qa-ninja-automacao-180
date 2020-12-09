#language: pt

Funcionalidade: Cadastro de Anuncios

    Sendo usuario cadastrado no Rocklov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu possa disponibilizar-los para locacao

    Contexto: Login
        * Login com "john_wick@gmail.com" e "k1llth3m4ll"

    @equipments
    Cenario: Novo equipamento
        Dado que acesso o formulario de cadastro de anuncios
            E que eu tenho o seguinte equipamento:
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard


    @temp
    Cenario: Anuncio sem foto
        Dado que acesso o formulario de cadastro de anuncios
            E que eu tenho o seguinte equipamento:
            | thumb     |               |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então deve conter mensagem de alerta: "Adicione uma foto no seu anúncio!"