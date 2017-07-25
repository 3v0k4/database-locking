class WriteWriteController < ApplicationController
  def fetch
    render plain: "#{Item.first!.color} #{Item.second!.color}"
  end

  def not_safe
    first_item = Item.first!
    first_item.color = item_params["color"]
    first_item.save!
    do_something
    second_item = Item.second!
    second_item.color = item_params["color"]
    second_item.save!

    render plain: "#{Item.first!.color} #{Item.second!.color}"
  end

  def safe
    first_item = Item.first!
    second_item = Item.second!
    ActiveRecord::Base.transaction do
      first_item.color = item_params["color"]
      first_item.save!
      do_something
      second_item.color = item_params["color"]
      second_item.save!
    end

    render plain: Item.first!.color
  end

  private
  def do_something
    sleep rand/2
  end

  def item_params
    params.permit(:color)
  end
end
