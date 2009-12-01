ActionController::Base.helper(Inputs)

if Object.const_defined?("Formtastic")
  require 'inputs'
  Formtastic::SemanticFormBuilder.send(:include, Inputs::Formtastic)
end
