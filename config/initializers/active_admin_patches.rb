class ActiveAdmin::ResourceController
  def check_model_errors(object)
      return unless object.errors.any?
      flash[:error] ||= []
      flash[:error].concat(object.errors.full_messages)
  end

  def find_resource
    finder = resource_class.is_a?(FriendlyId) ? :slug : :id
    scoped_collection.find_by(finder => params[:id])
  end
end
