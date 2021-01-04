#language: pt

Funcionalidade: Remover Anuncios
  Sendo um anunciante que possui um equipamento indesejado
  Quero poder remover esse anuncio
  Para que eu possa manter meu Dashboard atualizado

  Contexto: Login
    * Login com "tsunade@hotmail.com" e "BiggerThanYours"

  Cenario: Remover um anuncio

    Dado que eu tenho o seguinte anuncio indesejado:
      | thumb     | telecaster.jpg     |
      | nome      | Telecaster da Xuxa |
      | categoria | Outros             |
      | preco     | 987                |
    Quando eu solicito a exlusao desse item
    E confirmo a exclusao
    Então nao devo ver esse item no meu Dashboard

  Cenario: Desistir da exclusao
    Dado que eu tenho o seguinte anuncio indesejado:
      | thumb     | conga.jpg         |
      | nome      | Conga da Macarena |
      | categoria | Outros            |
      | preco     | 354               |
    Quando eu solicito a exlusao desse item
    Mas nao confirmo a solicitacao
    Então esse item deve permanecer no meu Dashboard
