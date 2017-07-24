class ReadWriteController < ApplicationController
  def fetch
    render plain: Item.first!.counter
  end

  def not_safe
    item = Item.first!
    item.counter = item.counter + 1
    item.save!

    render plain: Item.first!.counter
  end

  def safe_
    item = Item.first!
    ActiveRecord::Base.transaction do
      item.lock!
      item.counter = item.counter + 1
      item.save!
    end

    render plain: Item.first!.counter
  end

  def safe_
    item = Item.first!
    item.with_lock do
      item.counter = item.counter + 1
      item.save!
    end

    render plain: Item.first!.counter
  end

  def safe_
    ActiveRecord::Base.transaction do
      item = Item.lock.first!
      item.counter = item.counter + 1
      item.save!
    end

    render plain: Item.first!.counter
  end

  def safe
    item_id = Item.first!.id
    Item.increment_counter(:counter, item_id)

    render plain: Item.first!.counter
  end
end
