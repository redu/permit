require 'grape'

module Permit
  class API < Grape::API
    format :json

    resource :rules do
      params do
        requires :resource_id, :type => String
        requires :subject_id, :type => String
        requires :action, :type => String
      end
      head '/' do
        env.logger.info params
        filter = {}
        filter[:resource_id] = params[:resource_id] if params[:resource_id]
        filter[:subject_id] = params[:subject_id] if params[:subject_id]
        filter[:actions] = {}
        filter[:actions][params[:action]] = true

        policy = Policy.new(filter.merge(:logger => env.logger))
        rules = policy.rules.count

        if rules > 0
          status 200
        else
          status 404
        end
      end
    end
  end
end
