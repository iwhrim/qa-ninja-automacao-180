describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = { email: "another_ninja@gmail.com", password: "P4s$W0rD" }
    result = Sessions.new.login(payload)
    @another_user_id = result.parsed_response['_id']
  end

  context "solicitar locacao" do
    before(:all) do
      # dado que "QA Ninja" tem uma "Fender Strato" para locacao
      result = Sessions.new.login({ email: "qaninja@gmail.com", password: "qaninja" })
      qaninja_id = result.parsed_response["_id"]
      fender = { thumbnail: Helpers::get_thumb("fender-sb.jpg"),
                  name: "Fender Strato",
                  category: "Cordas",
                  price: 150,
      }
      MongoDB.new.remove_equipment(fender[:name], qaninja_id)
      result = Equipos.new.create(fender, qaninja_id)
      fender_id = result.parsed_response["_id"]


      # quando solicito a locacao da Fender do QA Ninja
      @result = Equipos.new.booking(fender_id, @another_user_id)
    end

    it 'should return 200' do
      expect(@result.code).to eql 200
    end



  end
end