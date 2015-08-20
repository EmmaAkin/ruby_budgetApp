class Expenses< ActiveRecord::Base
  belongs_to :expenses_category, counter_cache: true
  # Remember to create a migration!
end
