require 'sinatra'
require 'test/unit'
require 'rack/test'
require_relative 'loginrecords.rb'

ENV['RACK_ENV'] = 'test'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def test_add_login
    login_entry = {
                "user_name" => "mikich"
    }
    
    put '/login_entry', login_entry.to_json
    assert_equal 200, last_response.status
  end
  
  def test_get_login
    get '/login_entry/1'
    assert_equal 200, last_response.status
    assert last_response.body.include?('mikich')
  end
  
  def test_delete_login
    delete '/login_entry/1'
    assert_equal 200, last_response.status
  end
end

  
  