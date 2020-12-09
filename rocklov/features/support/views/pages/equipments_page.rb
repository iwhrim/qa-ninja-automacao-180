class EquipmentsPage
    include Capybara::DSL

    def create(equip)
        page.has_css?("#equipoForm")

        thumb = Dir.pwd + "/features/support/fixtures/images/" + equip[:thumb]

        find("#thumbnail input[type=file]", visible: false).set thumb
        find("input[placeholder$=equipamento]").set equip[:nome]
        find("#category").find('option', text: equip[:categoria]).select_option
        find("input[placeholder^=Valor]").set equip[:preco]
    
        click_button "Cadastrar"
    end

end