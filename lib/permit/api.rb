require 'grape'

module Permit
  class API < Grape::API
    format :json

    resource :rules do
      head 'resource/:resource_id/subject/:subject_id/action/:action' do
        env.logger.info params
        filter = {}
        filter[:resource_id] = params[:resource_id] if params[:resource_id]
        filter[:subject_id] = params[:subject_id] if params[:subject_id]
        filter[:actions] = {}
        filter[:actions][params[:action]] = true

        policy = Policy.new(filter.merge(:logger => env.logger, :db => env.db))
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
