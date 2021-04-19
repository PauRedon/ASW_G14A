class AddTipustoContribucios < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucios, :tipus, :string
  end
end
