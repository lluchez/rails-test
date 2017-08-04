class AddTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string  :name, :null => false
      t.boolean :done, :null => false, :default => false
      t.timestamps
    end
    add_index :todos, [:done], :name => 'index_on_todos_done'
  end
end
