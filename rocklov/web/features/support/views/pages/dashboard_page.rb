class DashboardPage
  include Capybara::DSL

  def go_to_equipments_form
    click_button "Criar anúncio"
  end

  def equipment_list
    return find(".equipo-list")
  end

  def on_dash?
    return page.has_css?(".dashboard")
  end

  def has_no_equipo?(name)
    return page.has_no_css?(".equipo-list li", text: name)
  end

  def request_removal(name)
    equipo = find(".equipo-list li", text: name)
    equipo.find(".delete-icon").click
  end

  def confirm_removal
    click_on "Sim"
  end

  def cancel_removal
    click_on "Não"
  end

  def order
    find(".notifications p")
  end

  def order_actions(name)
    page.has_css?(".notifications button", text: name)
  end
end
