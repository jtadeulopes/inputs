module Inputs
  
  # Create text_field with mask.
  #
  # Example:
  #   
  #   # View:
  #   <%= masked_text_field(:user, :phone, :size => 13, :mask => '(99)9999-9999') %>
  #
  #   # Output:
  #   # => <input id="user_phone" name="user[phone]" size="13" type="text" />
  #   # => <script type="text/javascript">
  #         //<![CDATA[
  #           $('#user_phone').mask('(99)9999-9999');
  #         //]]>
  #       </script>
  #
  def masked_text_field(object, method, options = {})
    return text_field(object, method, options) unless options.has_key?(:mask)
    mask = options.delete(:mask)
    text_field(object, method, options) + 
      javascript_tag("$('##{object}_#{method}').mask('#{mask}');")
  end

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
    text_field(object, method, options) + 
      javascript_tag("$('##{object}_#{method}').priceFormat();")
  end

  # Add required files
  #
  #   # View:
  #   <%= javascript_include_tag :defaults %>
  #   <%= javascript_include_inputs %>
  #
  def javascript_include_inputs
    javascript_include_tag 'maskedinput', 'price'
  end

end
