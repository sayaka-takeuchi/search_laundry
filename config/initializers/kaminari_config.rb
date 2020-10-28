# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 8
  config.window = 2
  config.outer_window = 1
end
