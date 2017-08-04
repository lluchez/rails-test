require 'rails_helper'

RSpec.describe "todos/index", type: :view do
  before(:each) do
    assign(:todos, [
      Todo.create!(
        :name => "Name"
      ),
      Todo.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of todos" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
