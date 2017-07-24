class Item < ApplicationRecord
  scope :not_flagged, -> { where(counter: 1) }

  def flag!
    self.counter = self.counter + 1
    self.save!
  end
end
