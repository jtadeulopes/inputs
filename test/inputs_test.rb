require File.expand_path(File.join(File.dirname(__FILE__), '../../../../test/test_helper'))

class InputsTest < Test::Unit::TestCase 

  include Inputs

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::AssetTagHelper

  def test_masked_text_field_phone
    assert_dom_equal %(<input name=\"user[phone]\" size=\"30\" id=\"user_phone\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_phone').mask('(99)9999-9999');\n//]]>\n</script>),
    masked_text_field(:user, :phone, :mask => '(99)9999-9999')
  end

  def test_masked_text_field_date
    assert_dom_equal %(<input name=\"user[birth]\" size=\"30\" id=\"user_birth\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_birth').mask('99/99/9999');\n//]]>\n</script>),
    masked_text_field(:user, :birth, :mask => '99/99/9999')
  end

  def test_masked_text_field_date_with_size_10
    assert_dom_equal %(<input name=\"user[birth]\" size=\"10\" id=\"user_birth\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_birth').mask('99/99/9999');\n//]]>\n</script>),
    masked_text_field(:user, :birth, :size => 10, :mask => '99/99/9999')
  end

  def test_return_error_if_mask_option_nil
    assert_raise RuntimeError do
      masked_text_field(:user, :phone)
    end
  end

  def test_javascript_include_inputs
    assert_dom_equal %(<script src=\"/javascripts/maskedinput.js?1248409652\" type=\"text/javascript\"></script>),
      javascript_include_inputs
  end

end
