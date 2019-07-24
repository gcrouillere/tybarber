module MetaTagsHelper
  def meta_title
    content_for?(:title_tag) ? content_for(:title_tag) : "Eden Black : les objets d'art en Morta de Philippe Nerriere"
  end

  def meta_product_name
    content_for?(:meta_product_name) ? content_for(:meta_product_name) : "Eden Black : les objets d'art en Morta de Philippe Nerriere"
  end

  def meta_description
    description = "Laissez vous inspirer par les objets d'arts en morta pour la décoration, la table ou le soin."
    content_for?(:description) ? content_for(:description) : description
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image).strip : image_path(ENV['HOMEPIC3']))
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end

  def meta_no_index
    content_for(:noindex) if content_for?(:noindex)
  end
end

