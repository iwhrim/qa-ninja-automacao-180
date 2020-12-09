Então('sou redirecionado para o Dashboard') do                               
    expect(page).to have_css ".dashboard"
end

Então('vejo a mensagem de alerta: {string}') do |expected_alert|                     
    alert = find(".alert-dark")
    expect(alert.text).to eql expected_alert 
  end
  