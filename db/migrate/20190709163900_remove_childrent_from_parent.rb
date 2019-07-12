class RemoveChildrentFromParent < ActiveRecord::Migration[5.0]
  def change
    remove_reference :parents, :children, foreign_key: true
  end
end
