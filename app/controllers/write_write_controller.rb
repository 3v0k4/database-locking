class WriteWriteController < ApplicationController
  def fetch
    render plain: "#{Item.first!.counter} #{Item.second!.counter}"
  end

  def not_safe
    first_item = Item.first!
    first_item.counter = params["first"]
    first_item.save!
    do_something
    second_item = Item.second!
    second_item.counter = params["second"]
    second_item.save!

    render plain: "#{Item.first!.counter} #{Item.second!.counter}"
  end

  def safe
    first_item = Item.first!
    second_item = Item.second!
    ActiveRecord::Base.transaction do
      first_item.counter = params["first"]
      first_item.save!
      do_something
      second_item.counter = params["second"]
      second_item.save!
    end

    render plain: Item.first!.counter
  end

  private
  def do_something
    sleep rand/2
  end
end
