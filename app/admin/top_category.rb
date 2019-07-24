ActiveAdmin.register TopCategory, as: "Univers" do
  permit_params :name, :mobile_name, :description, :photo_1, :photo_2
  config.filters = false
  actions  :index, :new, :create, :destroy, :update, :edit
  menu priority: 2

  index do
    column :name
    column :mobile_name
    column :description
    actions
  end

  form do |f|
    f.inputs "" do
      f.input :name
      f.input :mobile_name
      f.input :description
    end
    f.inputs "Images", class: 'product_images' do
      img(src: cl_image_path(f.object.photo_1.path , :width=>250, :crop=>"scale")) unless f.object.new_record?
      f.input :photo_1, :as => :formtastic_attachinary, :hint => "Sélectionnez la photo 1 de cet univers"
      img(src: cl_image_path(f.object.photo_2.path, :width=>250, :crop=>"scale")) unless f.object.new_record?
      f.input :photo_2, :as => :formtastic_attachinary, :hint => "Sélectionnez la photo 1 de cet univers"
    end
    f.actions
   end

  controller do

   def create
      super do |format|
        redirect_to admin_univers_path and return if resource.valid?
      end
    end

    def destroy
      top_category = TopCategory.find(params[:id].to_i)
      categories = top_category.categories.size
      if categories > 0
        flash[:alert] = "Cette catégorie principale est toujours utilisée dans des produits. Impossible de la supprimer."
        redirect_to admin_univers_path and return
      end
      super do |format|
        redirect_to admin_univers_path and return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to admin_univers_path and return if resource.valid?
      end
    end

  end

end
