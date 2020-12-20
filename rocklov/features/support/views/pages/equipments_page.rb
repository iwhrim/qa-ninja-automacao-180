class EquipmentsPage
  include Capybara::DSL

  def create(equip)
    page.has_css?("#equipoForm")

    upload(equip[:thumb]) if equip[:thumb].length > 0

    find("input[placeholder$=equipamento]").set equip[:nome]

    select_cat(equip[:categoria]) if equip[:categoria].length > 0

    find("input[placeholder^=Valor]").set equip[:preco]

    click_button "Cadastrar"
  end

  def select_cat(category)
    find("#category").find("option", text: category).select_option
  end

  def upload(filename)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + filename

    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
