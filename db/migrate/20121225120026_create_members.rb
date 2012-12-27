class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :company_id

      t.timestamps
    end
  end
end
