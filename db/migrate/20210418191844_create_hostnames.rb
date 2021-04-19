class CreateHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :hostnames do |t|
      t.string :hostname, index: true
      t.references :dns_record

      t.timestamps
    end
  end
end
