module ErrorSerializer
  
    def ErrorSerializer.serialize(resource, message='Validation Failed')
      errors = resource.errors
      return if errors.nil?
  
      json = {message: message}
  
      new_hash = errors.to_hash(true).map do |field, messages|
        messages.map do |msg|
              {resource: resource.class.to_s, field: field, code: 'custom', message: msg}
        end
      end.flatten
  
      json[:errors] = new_hash
      json
    end
  
  end