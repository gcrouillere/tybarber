ActiveAdmin.register Ceramique, as: 'Produits' do
  permit_params :name, :description, :stock, :weight, :category_id, :price_cents, :position, :support_price_cents, photos: []
  menu priority: 1
  config.filters = false
  config.sort_order = 'position_asc'

  index do
    span Category.all.map{|c| c.name}.join("#"), class: "hidden-categories"
    column :id
    column :position
    column :name
    column "Description" do |ceramique|
      ceramique.description.size > 200 ? etc = " ..." : etc = ""
      ceramique.description[0..200] + etc
    end
    column :stock
    column :weight
    column "Catégorie", class: "col-category" do |ceramique|
      ceramique.category.name
    end
    column :price_cents
    column "HIDDEN DESCRIPTION", class: "hidden-desc" do |ceramique|
      ceramique.description
    end
    actions
  end

  form do |f|
    f.inputs "" do
      f.input :name
      f.input :description
      f.input :position
      f.input :stock
      f.input :weight, :hint => "Poids en grammes"
      f.input :category
      f.input :price_cents, :hint => "Prix en centimes d'euros. Ex: entrez 1200 pour un prix de 12 €"
      f.input :support_price_cents, :hint => "Prix du support en centimes d'euros. Entrez 0 si le support n'existe pas."
    end
    f.inputs "Images", class: 'product_images' do
      f.object.photos.each {|photo| img(src: cl_image_path(photo.path, :width=>250, :crop=>"scale"))} unless f.object.new_record?
      f.input :photos, :as => :formtastic_attachinary, :hint => "Sélectionnez les photos du produit. Maintenez Ctrl appuyé pour en sélectionner plusieurs."
    end
    f.actions
  end

show do |ceramique|
  attributes_table do
    row :name
    row :description
    row :stock
    row :weight
    row "Categorie" do |ceramique|
      ceramique.category.name
    end
    row :price_cents
    row :images do |ceramique|
      ceramique.photos.each do |photo|
        span img(src: cl_image_path(photo.path, :width=>250, :crop=>"scale"))
      end
    end
  end
 end

 csv do
    column :position
    column :name
    column :description
    column :stock
    column :weight
    column "Catégorie" do |ceramique|
      ceramique.category.name
    end
    column :price_cents
    column "Nb de ventes - CA" do |ceramique|
      total = 0
      sum = 0
      ceramique.basketlines.each do |basketline|
        if basketline.order.state == "paid"
          total += basketline.quantity
        end
      end
      sum = total * ceramique.price
      "#{total} - #{sum} €"
    end
 end

  controller do

    def create
      super do |format|
        if resource.valid?
          product_positions_management
          flash[:notice] = "Produit mis à jour"
          redirect_to admin_produits_path and return
        else
          flash[:alert] = "Certains champs ont été oubliés ou ne sont pas correctement remplis. Voir ci-dessous."
        end
      end
    end

    def destroy
      if Order.where(state: ["pending","payment page"]).joins(:basketlines).where("basketlines.ceramique_id = ?", resource.id).present?
        flash[:alert] = "Ce produit est dans un panier dans le processus d'achat, vous ne pouvez pas le supprimer"
        redirect_to request.referrer and return
      else
        resource.basketlines.update(ceramique_id: nil)
        flash[:notice] = "#{ENV['MODEL'][0...-1].capitalize} supprimé"
      end
      super do |format|
        redirect_to admin_produits_path and return
      end
    end

    def update
      super do |format|
        if resource.valid?
          product_positions_management
          flash[:notice] = "Produit mis à jour"
          redirect_to admin_produits_path and return
        else
          flash[:alert] = "Certains champs ont été oubliés ou ne sont pas correctement remplis. Voir ci-dessous."
        end
      end
    end

    def product_positions_management
      if params[:ceramique][:position].present?
        products_to_manage = Ceramique.where("position IS NOT NULL AND position >= ?", params[:ceramique][:position]).where.not(id: resource.id)
        products_to_manage.each {|product| product.update(position: product.position + 1)}
        new_ceramiques_order = Ceramique.all.order(position: :asc).order(updated_at: :desc)
        Ceramique.all.order(position: :asc).order(updated_at: :desc).each{|ceramique| ceramique.update(position: new_ceramiques_order.index(ceramique) + 1)}
      end
    end

  end

end
