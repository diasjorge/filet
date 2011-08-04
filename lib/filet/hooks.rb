module Filet
  module Hooks
    def self.extended(base)
      base.class_eval do
        @@context_hook = nil
        @@feature_hook = nil
      end
    end

    # TODO: Abstract the hook creation if we need another one
    def feature_hook(&block)
      if block
        @@feature_hook = block
      else
        @@feature_hook
      end
    end

    def feature_hook=(block)
      @@feature_hook = block
    end

    def context_hook(&block)
      if block
        @@context_hook = block
      else
        @@context_hook
      end
    end

    def context_hook=(block)
      @@context_hook = block
    end
  end

  extend Hooks
end
