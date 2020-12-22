describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com.br", password: "pwd123" }
      @result = Signup.new.create(payload)
      MongoDB.new.remove_user(payload[:email])
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      payload = { name: "Herobrine", email: "herobrine@bol.com.br", password: "pwd123" }
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
      MongoDB.new.remove_user(payload[:email])
    end

    it "valida status code" do
      expect(@result.code).to eql 409
    end

    it "valida mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  examples = Helpers::get_fixture("signup")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create(e[:payload])
      end
      it "valida status code: #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem de erro: #{e[:error]}" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end


end