class CreateAffiliatedGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :affiliated_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.index %i[user_id group_id], unique: true
      t.timestamps
    end
  end
end
