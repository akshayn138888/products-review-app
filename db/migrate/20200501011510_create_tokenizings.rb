class CreateTokenizings < ActiveRecord::Migration[6.0]
  def change
    create_table :tokenizings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
