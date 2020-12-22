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
    Esquema do Cenario: Tentativa de cadastro de anúncios
        Dado que acesso o formulario de cadastro de anuncios
            E que eu tenho o seguinte equipamento:
            | thumb     | <foto>      |
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
        Quando submeto o cadastro desse item
        Então deve conter mensagem de alerta: "<saida>"

        Exemplos:
            | foto          | nome      | categoria | preco        | saida                                |
            |               | Violao    | Cordas    | 150          | Adicione uma foto no seu anúncio!    |
            | clarinete.jpg |           | Outros    | 250          | Informe a descrição do anúncio!      |
            | mic.jpg       | Microfone |           | 350          | Informe a categoria                  |
            | trompete.jpg  | Trompete  | Outros    |              | Informe o valor da diária            |
            | conga.jpg     | Conga     | Outros    | not_a_number | O valor da diária deve ser numérico! |
            | conga.jpg     | Conga     | Outros    | 100a         | O valor da diária deve ser numérico! |

