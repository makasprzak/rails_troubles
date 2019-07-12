class AddChildrenToParent < ActiveRecord::Migration[5.0]
  def change
    add_reference :parents, :children, foreign_key: true
  end
end
