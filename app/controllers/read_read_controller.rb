class ReadReadController < ApplicationController
  def not_safe_1
    ActiveRecord::Base.transaction do
      item = Item.lock.where(counter: 1).first!
      other_item = OtherItem.lock.where(counter: 1).first!

      render plain: "ok_1"
    end

  rescue ActiveRecord::Deadlocked
    render plain: "deadlock_1"
  end

  def not_safe_2
    ActiveRecord::Base.transaction do
      other_item = OtherItem.lock.where(counter: 1).first!
      item = Item.lock.where(counter: 1).first!

      render plain: "ok_2"
    end

  rescue ActiveRecord::Deadlocked
    render plain: "deadlock_2"
  end

  def safe
    ActiveRecord::Base.transaction do
      item = Item.lock.where(counter: 1).first!
      other_item = OtherItem.lock.where(counter: 1).first!

      render plain: "ok"
    end
  end
end
