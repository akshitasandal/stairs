class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.integer :company_id
      t.text :title
      t.text :content, :null => false
      t.boolean :deleted, :default => 0
      t.timestamps :null => false
    end
  end
end
