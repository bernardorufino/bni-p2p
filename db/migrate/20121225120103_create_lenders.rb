class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.float :credit
      
      t.timestamps
    end
  end
end
