class ReadController < ApplicationController
  def not_safe
    item = Item.where(counter: 1).first!
    item.counter = item.counter + 1
    item.save!

    render plain: item.id
  end

  def safe
    ActiveRecord::Base.transaction do
      item = Item.lock.where(counter: 1).first!
      item.counter = item.counter + 1
      item.save!

      render plain: item.id
    end
  end
end
