class Todo < ActiveRecord::Base

  scope :completed, ->{ where(:done => true) }
  scope :uncompleted, ->{ where(:done => false) }

  validates_presence_of :name

end
