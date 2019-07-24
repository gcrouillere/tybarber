class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :confirmation, :atelier, :contact, :google906057532e2dbb7e, :robots, :legal, :agenda, :cgv, :atelier, :morta, :la_briere, :presse, :sites_partenaires, :sur_mesure]

  def home
    @dev_redirection = "https://www.creermonecommerce.fr/"
    @top_categories = TopCategory.all.includes(:categories)
    # @rasoir = Ceramique.joins(:category).where("categories.name ILIKE ?", "%rasoir%").order(position: :asc).order(updated_at: :desc).first
    # @lampe = Ceramique.joins(:category).where("categories.name ILIKE ?", "%lampe%").order(position: :asc).order(updated_at: :desc).first
    # @tirebouchon = Ceramique.joins(:category).where("categories.name ILIKE ?", "%tire-bouchon%").order(position: :asc).order(updated_at: :desc).first
    render "home_#{@active_theme.name}"
  end

  def confirmation
    render "confirmation_#{@active_theme.name}"
  end

  def atelier
    @dev_redirection = "https://www.creermonecommerce.fr/#anchor-info"
    render "atelier_#{@active_theme.name}"
  end

  def la_briere
    @dev_redirection = "https://www.creermonecommerce.fr/product_claim_details"
  end

  def sur_mesure
    @dev_redirection = "https://www.creermonecommerce.fr/product_claim_details"
  end

  def morta
    @dev_redirection = "https://www.creermonecommerce.fr/#anchor-info"
  end

  def presse
    @dev_redirection = "https://www.creermonecommerce.fr/#anchor-info"
  end

  def sites_partenaires
    @dev_redirection = "https://www.creermonecommerce.fr/#anchor-info"
  end

  def contact
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
    render "contact_#{@active_theme.name}"
  end

  def agenda
    @dev_redirection = "https://www.creermonecommerce.fr"
  end

  def cgv
    @dev_redirection = "https://www.creermonecommerce.fr"
  end

  def legal
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
  end

  def cgv
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
  end

  def google906057532e2dbb7e
  end

  def robots
    render 'pages/robots.txt.erb'
    expires_in 6.hours, public: true
  end

end
