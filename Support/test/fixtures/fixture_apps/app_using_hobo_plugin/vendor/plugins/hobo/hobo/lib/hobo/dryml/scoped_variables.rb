module Hobo::Dryml
  
  class ScopedVariables
    
    def initialize
      @scopes = [{}]
    end
    
    def [](key)
     s = scope_with_key(key) and s[key]
    end
    
    def []=(key, val)
      s = scope_with_key(key) || @scopes.last
      s[key] = val
    end
    
    def new_scope
      @scopes << {}
      res = yield
      @scopes.pop
      res
    end
    
    def scope_with_key(key)
      @scopes.reverse_each do |s|
        return s if s.has_key?(key)
      end 
      nil
    end
    
    def method_missing(name, *args)
      if name.to_s =~ /=$/
        self[name.to_s[0..-2].to_sym] = args.first
      else
        self[name]
      end
    end
    
  end
  
end
