Dado('Login com {string} e {string}') do |email, password|
    @email = email

    @login_page.open
    @login_page.with(email, password)
end                                                                        

Dado('que acesso o formulario de cadastro de anuncios') do
    @dashboard_page.go_to_equipments_form
end                                                                          

Dado('que eu tenho o seguinte equipamento:') do |table|
    @anuncio = table.rows_hash

    MongoDB.new.remove_equipment(@anuncio[:nome], @email)
end

Quando('submeto o cadastro desse item') do
   @equipments_page.create(@anuncio)
end

Então('devo ver esse item no meu Dashboard') do
    anuncios = find(".equipo-list")
    expect(@dashboard_page.equipment_list).to have_content @anuncio[:nome]
    expect(@dashboard_page.equipment_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então('deve conter mensagem de alerta: {string}') do |expected_alert|
    expect(@alert.dark).to have_text expected_alert 
end