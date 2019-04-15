namespace :products do
  desc "TODO"
  task update_entities: :environment do
    Product.ids.each { |id| ScrapingJob.perform_later(id) }
  end
end
