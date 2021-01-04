#language: pt

Funcionalidade: Receber pedido de locacao
  Sendo um anunciante que possui equipamentos cadastrados
  Desejo receber pedidos de locacao
  Para que eu possa decidir se quero aprova-los ou rejeita-los

  @temp
  Cenario: Receber pedido

    Dado que meu perfil de anunciante eh "offin@bdo.com" e "d3str0y3r"
    E que eu tenho o seguinte equipamento cadastrado:
      | thumb     | baixo.jpg  |
      | nome      | Baixo Alto |
      | categoria | Cordas     |
      | preco     | 654        |
    E acesso o meu dashboard
    Quando "kree_ara@runescape.com" e "gwd123" solicita a locacao desse equipo
    Então devo ver a seguinte mensagem:
  """
  kree_ara@runescape.com deseja alugar o equipamento: Baixo Alto em: DATA_ATUAL
  """
    E devo ver o links: "ACEITAR" e "REJEITAR" no pedido