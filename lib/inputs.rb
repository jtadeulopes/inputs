#
# Adiciona helpers para criar text_field com mascaras.
#
module Inputs
  
  #   Monta o text_field
  #
  #   masked_text_field(:user, :phone, :mask => '(99)9999-9999')
  #
  #   # => <input id="user_phone" name="user[phone]" size="30" type="text" />
  #   # => <script type="text/javascript">
  #         //<![CDATA[
  #           $('#user_phone').mask('(99)9999-9999');
  #         //]]>
  #       </script>
  #
  def masked_text_field(object,method,mask={})
    text_field(object,method) +
    javascript_tag("$('##{object}_#{method}').mask('#{mask.values.first}');")
  end

  # Adiciona arquivos javascripts necessários
  #
  # View:
  # <%= javascript_include_inputs %>
  def javascript_include_inputs
    javascript_include_tag 'maskedinput'
  end

end
