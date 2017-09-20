ActiveAdmin.register Category do
  permit_params :name
  config.filters = false
  actions  :index, :new, :create, :destroy, :update, :edit
  menu priority: 2

  index do
    column :name
    actions
  end


  controller do
    def create
      super do |format|
        redirect_to admin_produits_path and return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to admin_produits_path and return if resource.valid?
      end
    end

    def destroy
      super do |format|
        redirect_to admin_produits_path and return if resource.valid?
      end
    end
  end

end
