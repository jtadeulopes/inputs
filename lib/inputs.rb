#
# Add helpers to create text_field with masks.
#
module Inputs
  
  #   masked_text_field(:user, :phone, :size => 13, :mask => '(99)9999-9999')
  #
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

  # Add required files
  #
  # View:
  # <%= javascript_include_inputs %>
  #
  def javascript_include_inputs
    javascript_include_tag 'maskedinput'
  end

end
