namespace :products do
  desc "TODO"
  task update_entities: :environment do
    Product.ids.each { |id| ScrapingJob.perform_now(id) }
  end
end
