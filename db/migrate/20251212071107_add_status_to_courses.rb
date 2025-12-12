class AddStatusToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :status, :string, default: "draft"
  end
end
