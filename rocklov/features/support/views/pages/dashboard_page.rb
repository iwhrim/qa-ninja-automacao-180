

class DashboardPage
    include Capybara::DSL

    def go_to_equipments_form
        click_button "Criar anúncio"
    end

    def equipment_list
        return find(".equipo-list")
    end

    def on_dash?
        return page.has_css(".dashboard")
    end
end