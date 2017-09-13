 class RenameTable < ActiveRecord::Migration
   def change
     rename_table :baskets, :basketlines
   end
 end
