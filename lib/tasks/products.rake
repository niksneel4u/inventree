namespace :products do
  desc "TODO"
  task update_entities: :environment do
    Product.active.ids.each { |id| ScrapingJob.perform_later(id) }
  end
end
