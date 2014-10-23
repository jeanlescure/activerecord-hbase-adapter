require 'active_record/connection_adapters/abstract_mysql_adapter'

module Hbase
  class Result
    include Enumerable
    
    attr_accessor :members
    
    ### Keeping this just in case, for now
    # def self.new(result = {'fields' => [], 'results' => []})
    #   return nil if result['fields'].length < 1 && result['results'].length < 1
    #   
    #   super
    # end
  
    def initialize(result = {'fields' => [], 'results' => []})
      @result = result
      @members = @result['results']
    end
    
    def hasherize_rows(symbolize_keys = false)
      if symbolize_keys
        keys = @result['fields'].map! { |v| v.to_sym }
      else
        keys = @result['fields']
      end
      #binding.pry
      hashed_rows = @result['results'].map { |row| Hash[keys.zip row] }
    end
    
    def each(arg_hash = {},&block)
      unless arg_hash[:as].nil?
        symbolize_keys = (arg_hash[:symbolize_keys].nil?) ? false : arg_hash[:symbolize_keys]
        if arg_hash[:as] == :hash
          hasherize_rows(symbolize_keys).each &block
        end
      else
        @result['results'].each &block
      end
    end
    
    def fields
      @result['fields']
    end
    
    def count
      @result['results'].length
    end
    
    alias :size :count
  end
end