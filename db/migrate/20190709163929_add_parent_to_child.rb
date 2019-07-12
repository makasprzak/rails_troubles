class AddParentToChild < ActiveRecord::Migration[5.0]
  def change
    add_reference :children, :parent, foreign_key: true
  end
end
