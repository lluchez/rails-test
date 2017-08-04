require 'rails_helper'

RSpec.describe Todo, type: :model do

  it { should validate_presence_of(:name) }

  describe "uncompleted" do
    it "should only return uncomplete todos" do
      todo1 = FactoryGirl.create(:todo, :name => "Todo 1", :done => false)
      todo2 = FactoryGirl.create(:todo, :name => "Todo 2", :done => false)
      todo3 = FactoryGirl.create(:todo, :name => "Todo 3", :done => true)
      todo4 = FactoryGirl.create(:todo, :name => "Todo 4", :done => true)
      uncompleted_todos = Todo.uncompleted.all
      expect(uncompleted_todos.count).to eq(2)
      expect(uncompleted_todos.map(&:id)).to eq([todo1.id, todo2.id])
    end
  end

end
