ActiveAdmin.register Ceramique do
  permit_params :name, :description, :stock, :category_id, :price_cents, photos: []
  menu priority: 1

  index do
    column :name
    column :description
    column :stock
    column :category_id
    column :price_cents
    actions
  end

  form do |f|
  f.inputs "" do
    f.input :name
    f.input :description
    f.input :stock
    f.input :category
    f.input :price_cents
    f.input :photos, :as => :formtastic_attachinary
    # , :hint => image_tag(f.object.photos[0].path)
  end
  f.actions
 end

show do |ceramique|
  attributes_table do
    row :name
    row :description
    row :stock
    row :category
    row :price_cents
    row :images do |ceramique|
      ceramique.photos.each do |photo|
        span img(src: "http://res.cloudinary.com/dbhsa0hgf/image/upload/#{photo.path}")
      end
    end
  end
 end

 controller do
    def create
      super do |format|
        redirect_to admin_ceramiques_path and return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to admin_ceramiques_path and return if resource.valid?
      end
    end

     def destroy
      super do |format|
        redirect_to admin_ceramiques_path and return if resource.valid?
      end
    end
  end

end
