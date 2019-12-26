class SampleController < ApplicationController
  def start
    require 'redis'
redis = Redis.new(host: "localhost")
redis.set("a", 'is working')
# "OK"
redis.get("a")

Ad.create!(name: 'is working')


    render json: {redis: redis.get("a"), mysql: Ad.first.name}
  end
end

