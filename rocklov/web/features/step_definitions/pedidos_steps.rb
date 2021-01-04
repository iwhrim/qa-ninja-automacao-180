Dado('que meu perfil de anunciante eh {string} e {string}') do |email, password|
  @email_anunciante = email
  @password_anunciante = password
end

Dado('que eu tenho o seguinte equipamento cadastrado:') do |table|
  user_id = SessionsService.new.get_user_id(@email_anunciante, @password_anunciante)

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  MongoDB.new.remove_equipment(@equipo[:name], @email_anunciante)
  result = EquiposService.new.create(@equipo, user_id)
  @equipo_id = result.parsed_response["_id"]
end

Dado('acesso o meu dashboard') do
  @login_page.open
  @login_page.with(@email_anunciante, @password_anunciante)

  expect(@dashboard_page.on_dash?).to be true
end

Quando('{string} e {string} solicita a locacao desse equipo') do |email, password|
  user_id = SessionsService.new.get_user_id(email, password)
  EquiposService.new.booking(@equipo_id, user_id)
end

Então('devo ver a seguinte mensagem:') do |message|
  expected_message = message.gsub("DATA_ATUAL", Time.now.strftime("%d/%m/%Y"))
  expect(@dashboard_page.order).to have_text expected_message
end

Então('devo ver o links: {string} e {string} no pedido') do |button_accept, button_reject|
  expect(@dashboard_page.order_actions(button_accept)).to be true
  expect(@dashboard_page.order_actions(button_reject)).to be true
end