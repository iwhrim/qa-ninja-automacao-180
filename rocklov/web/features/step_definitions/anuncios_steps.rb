Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)

  expect(@dashboard_page.on_dash?).to be true
end

Dado("que acesso o formulario de cadastro de anuncios") do
  @dashboard_page.go_to_equipments_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  @anuncio = table.rows_hash

  MongoDB.new.remove_equipment(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipments_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dashboard_page.equipment_list).to have_content @anuncio[:nome]
  expect(@dashboard_page.equipment_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter mensagem de alerta: {string}") do |expected_alert|
  expect(@alert.dark).to have_text expected_alert
end

#Remover anuncios
Dado('que eu tenho o seguinte anuncio indesejado:') do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)
  visit current_path
end

Quando('eu solicito a exlusao desse item') do
  @dashboard_page.request_removal(@equipo[:name])
end

Quando('confirmo a exclusao') do
  @dashboard_page.confirm_removal
end

Quando('nao confirmo a solicitacao') do
  @dashboard_page.cancel_removal
end

Então('nao devo ver esse item no meu Dashboard') do
  expect(@dashboard_page.has_no_equipo?(@equipo[:name])).to be true
end

Então('esse item deve permanecer no meu Dashboard') do
  expect(@dashboard_page.equipment_list).to have_content @equipo[:name]
end

