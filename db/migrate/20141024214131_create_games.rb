class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.references :team, index: true

      t.timestamps
    end
  end
end
