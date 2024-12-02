class CreateReflections < ActiveRecord::Migration[8.0]
  def change
    create_table :reflections do |t|
      t.text :content, null: false, default: ''
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
