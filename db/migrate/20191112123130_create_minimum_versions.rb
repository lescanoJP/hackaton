class CreateMinimumVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :minimum_versions do |t|
      t.string :platform
      t.string :version_number
      t.string :build_number
      t.boolean :required, default: false
      t.text :description

      t.timestamps
    end
  end
end
