require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/LoginRecords.sqlite3")

class LoginEntry
  include DataMapper::Resource
  
  property :id, Serial
  property :user_name, String, :required => true, :length => 255
  property :accessed_at, Time
  
  def to_json(*a)
  {
    'user_name' => self.user_name,
    'date' => self.accessed_at.to_i
  }.to_json(*a)
  end
end

DataMapper.finalize
LoginEntry.auto_upgrade!
