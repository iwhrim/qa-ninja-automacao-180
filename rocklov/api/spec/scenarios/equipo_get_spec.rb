describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "qaninja@gmail.com", password: "qaninja" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end

  context "obter um equipo" do
    before(:all) do

      # dado que eu tenho um novo equipamento
      @payload = { thumbnail: Helpers::get_thumb("sanfona.jpg"),
                   name: "Sanfona do Tio Bilia",
                   category: "Outros",
                   price: 499,
      }

      # e eu tenho o id desse equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # quando faco uma requisicao GET por id
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)

      # limpando banco de dados
      MongoDB.new.remove_equipment(@payload[:name], @user_id)
    end

    it 'should return 200' do
      expect(@result.code).to eql 200
    end

    it 'should return equipment name' do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end

  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)

    end

    it 'should return 404' do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "another_ninja@gmail.com", password: "P4s$W0rD" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end

  context "obter uma lista" do

    before(:all) do
      # dado que eu tenho uma lista de equipos
      payloads = [
        { thumbnail: Helpers::get_thumb("sanfona.jpg"),
          name: "Sanfona do Tio Bilia",
          category: "Outros",
          price: 199,
        },
        { thumbnail: Helpers::get_thumb("pedais.jpg"),
          name: "Pedais HyperX",
          category: "Outros",
          price: 299,
        },
        { thumbnail: Helpers::get_thumb("mic.jpg"),
          name: "Microfone Dazz",
          category: "Outros",
          price: 399,
        }
      ]
      payloads.each do |payload|
        MongoDB.new.remove_equipment(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      # quando faco uma request GET em /equipos
      @result = Equipos.new.list(@user_id)
    end

    it 'should return 200' do
      expect(@result.code).to eql 200
    end

    it 'should return a list of equipments' do
      expect(@result.parsed_response).not_to be_empty
    end
    
  end
end