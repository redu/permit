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
        subject_id = params.delete(:subject_id)
        filter = {}
        filter[:resource_id] = params[:resource_id]
        filter[:actions] = {}
        filter[:actions][params[:action]] = true

        policy = Policy.new(:subject_id => subject_id, :logger => env.logger,
                            :collection => Connection.pool.collection('rules'))
        rules = policy.rules(filter).count

        if rules > 0
          status 200
        else
          status 404
        end
      end
    end
  end
end
