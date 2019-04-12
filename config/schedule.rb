# frozen_string_literal: true

every 15.minutes do
  rake 'products:update_entities'
end
