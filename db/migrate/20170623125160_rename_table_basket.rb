 class RenameTableBasket < ActiveRecord::Migration
   def change
     rename_table :basketlines, :basket_lines
   end
 end
