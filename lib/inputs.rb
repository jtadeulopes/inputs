module Inputs
  
  # Create text_field with mask.
  #
  # Example:
  #   
  #   # View:
  #   <%= masked_text_field(:user, :phone, :size => 13, :mask => '(99)9999-9999') %>
  #
  #   # Output:
  #   # => <input alt="(99)9999-9999" id="user_phone" name="user[phone]" size="13" type="text" />
  #
  def masked_text_field(object, method, options = {})
    return text_field(object, method, options) unless options.has_key?(:mask)
    options[:title] = options.delete(:alt) if options.has_key?(:alt)
    options[:alt] = options.delete(:mask)
    text_field(object, method, options)
  end

  # #
  # !! Sorry, this method has been deprecated.
  # #
  #
  # Create text_field with masks for price
  #
  # Example:
  #
  #   # View:
  #   <%= price_us_text_field(:product, :price, :size => 10) %>
  #
  #   # Output:
  #   # => <input id="product_price" name="product[price]" size="10" type="text" />
  #   # => <script type="text/javascript">
  #         //<![CDATA[
  #           $('#product_price').priceFormat();
  #         //]]>
  #       </script>
  #
  def price_us_text_field(object, method, options = {})
    raise "[DEPRECATION] price_us_text_field is deprecated."
  end

  # Add required files
  #
  #   # View:
  #   <%= javascript_include_tag :defaults %>
  #   <%= javascript_include_inputs %>
  #
  def javascript_include_inputs
    javascript_include_tag('jquery.meio.mask.min') +
      javascript_tag("(function($){$(function(){$('input:text').setMask();});})(jQuery);")
  end

  module Formtastic

    def self.included(base)
      base.class_eval do

        def basic_input_helper(form_helper_method, type, method, options)
          if options.has_key?(:mask)
            mask = options.delete(:mask)
            options.has_key?(:input_html) ? options[:input_html].merge!(:alt => mask) : options.merge!(:input_html => {:alt => mask})
          end
          html_options = options.delete(:input_html) || {}
          html_options = default_string_options(method, type).merge(html_options) if [:numeric, :string, :password].include?(type)

          self.label(method, options_for_label(options)) <<
          self.send(form_helper_method, method, html_options)
        end

      end
    end

  end

end
