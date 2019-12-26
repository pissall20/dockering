class SampleWorker
  include Sidekiq::Worker

  def perform(params)
    Ad.create!(name: 'is working')
  end

end
