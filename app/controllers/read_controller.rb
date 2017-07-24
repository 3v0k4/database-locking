class ReadController < ApplicationController
  def not_safe
    item = Item.not_flagged.first!
    item.flag!

    render plain: item.id
  end

  def safe
    ActiveRecord::Base.transaction do
      item = Item.lock.not_flagged.first!
      item.flag!

      render plain: item.id
    end
  end
end
