class AddColumnAndForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :style_id, :integer
    add_foreign_key :beers, :styles
  end

  def testi
  end

end
