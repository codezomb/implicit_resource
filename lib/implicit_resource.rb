require "implicit_resource/version"
require "implicit_resource/railtie"
require "responders"
require "has_scope"

module ImplicitResource
  extend ActiveSupport::Concern

  ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

  included do
    ACTIONS.each do |action|
      define_method(action) do
        respond_with(action == :index ? collection : act_on_resource)
      end
    end

    helper_method :collection
    helper_method :resource
  end

  protected

  def namespace
    @namespace ||= controller_path.split('/')[0..-2].map(&:to_sym)
  end

  def model_klass
    @model_klass ||= controller_name.classify.safe_constantize
  end

  def collection
    @collection ||= apply_scopes(model_klass.all)
  end

  def resource
    @resource ||= if params[:id].present?
      collection.find(params[:id])
    else
      collection.new
    end
  end

  # Persist the passed in resource to the database
  def persist_resource
    return unless %w[create update].include?(action_name)

    ActiveRecord::Base.transaction do
      resource.attributes = permitted_attributes(resource)
      resource.save
    end
  end

  # Delete the given resource from the database
  def destroy_resource
    resource.destroy! if action_name == 'destroy'
  end

  # Build a resource based on contextual info
  def act_on_resource
    @act_on_resource ||= resource.tap do
      unless destroy_resource
        persist_resource
      end
    end
  end
end
