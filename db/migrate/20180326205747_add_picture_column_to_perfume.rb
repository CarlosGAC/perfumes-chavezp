class AddPictureColumnToPerfume < ActiveRecord::Migration[5.1]
  def change
    add_attachment :perfumes, :picture
  end
end
