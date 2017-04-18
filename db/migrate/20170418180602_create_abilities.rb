class CreateAbilities < ActiveRecord::Migration[5.0]
  def change
    create_table :abilities do |t|

      t.timestamps
    end
  end
end
