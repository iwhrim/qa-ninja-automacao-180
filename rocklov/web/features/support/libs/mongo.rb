require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipments

  def initialize
    @client = Mongo::Client.new(CONFIG["mongo"])
    @users = client[:users]
    @equipments = client[:equipos]
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def drop_database
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def get_user_id(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipment(name, email)
    user_id = get_user_id(email)

    @equipments.delete_many({ name: name, user: user_id })
  end
end
