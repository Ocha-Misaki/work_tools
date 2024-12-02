class CreateDailyReports < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_reports do |t|
      t.text :content, null: false, default: ''
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
