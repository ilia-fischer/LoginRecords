require 'rubygems'
require 'sinatra'
require 'json'
require_relative 'data.rb'

get '/login_entry/:id' do
  puts "**** get login_entry number #{params[:id]}"
  login_entry = LoginEntry.get(params[:id])
  if login_entry.nil? then
    status 404
  else
    status 200
    body(login_entry.to_json)
  end
end

delete '/login_entry/:id' do
  puts "**** delete login_entry number #{params[:id]}"
  login_entry = LoginEntry.get(params[:id])
  if login_entry.nil? then
    status 404
  else
    if login_entry.destroy then
      status 200
    else
      status 500
    end
  end
end

put '/login_entry' do
  data = JSON.parse(request.body.string)
  if data.nil? or !data.has_key?('user_name') then
    status 400
  else
    login_entry = LoginEntry.create(
                              :user_name => data['user_name'],
                              :accessed_at => Time.now
                              )
    login_entry.save
    status 200
    puts "**** put a new login_entry @" + login_entry.id.to_s
    body(login_entry.id.to_s)
  end
end

post 'login_entry/:id' do
  puts "**** update login_entry number #{params[:id]}"
  data = JSON.parse(request.body.string)
  
  if data.nil? then
    status 400
  else
    puts ""
    login_entry = LoginEntry.get(params[:id])
    if login_entry.nil? then
      status 404
    else
      updated = false
      %w(user_name).each do |k|
        if data.has_key?(k)
          login_entry[k] = data[k]
          updated = true
        end
        
      end
      if updated then
        login_entry['accessed_at'] = Time.now
        if !login_entry.save then
          status 500
        end
      end
    end
  end
 end
 