module PunditViewPolicy
  extend ActiveSupport::Concern

  included do
    before do
      controller.singleton_class.class_eval do

        def policy(record)
          Pundit.policy!(current_user, record)
        end
        helper_method :policy

        def current_user
          @current_user ||= User.find_by id: session[:current_user_id]
        end
        helper_method :current_user
      end
    end
  end
end

RSpec.configure do |config|
  config.include PunditViewPolicy, type: :view
end
