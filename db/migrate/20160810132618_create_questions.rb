class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :asker_id
      t.string  :title
      t.integer :views, default: 0
      t.text    :content

      t.timestamps(null: false)
    end
  end
end
