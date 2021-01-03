require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipments

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipments = client[:equipos]
  end

  def drop_database
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user_id(email)
    user = @users.find({ email: email }).first
    user[:_id]
  end

  def remove_equipment(name, user_id)
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipments.delete_many({ name: name, user: obj_id })
  end
  def get_mongo_id
    BSON::ObjectId.new
  end
end
