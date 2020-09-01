# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def render_error_message(errors)
    error_message = if !errors.class.method_defined?(:full_messages)
                      errors.message
                    else
                      errors.full_messages.to_sentence
     end
    render json: { message: error_message }, status: 422
  end
end
