module ApplicationHelper

  def destroy_admin_user_session_path
    return "/produits"
  end

  def photo_update(variable, top, right, bottom, left, classe, texte)
    @variable = variable.to_sym
    @top = top
    @right = right
    @bottom = bottom
    @left = left
    @classe = classe
    @texte = texte
    render partial: "shared/photo_update"
  end

end
