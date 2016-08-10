class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id,  null:false
      t.integer :commenter_id,    null:false
      t.string  :commentable_type
      t.text    :content

      t.timestamps(null: false)
    end
  end
end
