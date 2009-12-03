begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

module InputSpecHelper

  include Inputs
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionController::PolymorphicRoutes

  class ::Project
    def name
    end
  end

  def self.included(base)
    base.class_eval do
      
      attr_accessor :output_buffer
      
      def protect_against_forgery?
        false
      end
      
    end
  end

end
