class EquipmentsPage
    include Capybara::DSL

    def create(equip)
        page.has_css?("#equipoForm")

        upload(equip[:thumb]) if equip[:thumb].length > 0

        find("input[placeholder$=equipamento]").set equip[:nome]
        find("#category").find('option', text: equip[:categoria]).select_option
        find("input[placeholder^=Valor]").set equip[:preco]
    
        click_button "Cadastrar"
    end

    def upload(filename)
        thumb = Dir.pwd + "/features/support/fixtures/images/" + filename

        find("#thumbnail input[type=file]", visible: false).set thumb
    end


end