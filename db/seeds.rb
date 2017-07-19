Item.all.delete_all
Unique.all.delete_all
5.times do
  Item.create(counter: 1)
end
