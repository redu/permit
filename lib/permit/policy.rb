module Permit
  class Policy
    def initialize(opts)
      @collection = opts[:collection]
      @resource_id = opts[:resource_id]
    end

    def rules(opts)
      @collection.find selector(opts)
    end

    # Creates or updates an existent rule for the resource and subject.
    #
    # policy = Policy.new(:resource_id => 'r')
    # policy.create(:subeject_id => 's', :actions => { :read => true ))
    def create(opts)
      update(opts)
    end

    def remove(opts)
      update('$unset', opts)
    end

    protected

    def update(modifier='$set', opts)
      selector = selector({:subject_id => opts.delete(:subject_id)})
      document = { modifier => dot_notation(opts.delete(:actions)) }
      @collection.update(selector, document, :upsert => true)
    end

    def selector(opts)
      { :resource_id => @resource_id }.merge(opts)
    end

    # Converts { :read => true } to { "actions.read" => true }
    def dot_notation(actions)
      return { "actions" => true } unless actions

      actions.reduce({}) do |acc, (key, value)|
        acc["actions.#{key}"] = value
        acc
      end
    end
  end
end
