require File.dirname(__FILE__) + '/spec_helper'

describe Inputs do

  include Inputs
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::AssetTagHelper

  describe "method javascript_include_inputs" do

    it "should include the necessary files" do
      javascript_include_inputs.gsub(/([0-9?])/,'').should eql("<script src=\"/javascripts/maskedinput.js\" type=\"text/javascript\"></script>\n<script src=\"/javascripts/price.js\" type=\"text/javascript\"></script>")
    end

  end

  describe "method masked_text_field" do

    it "should return text_field mask format for mobile" do
      masked_text_field(:user, :phone, :mask => '(99)9999-9999').should eql("<input id=\"user_phone\" name=\"user[phone]\" size=\"30\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_phone').mask('(99)9999-9999');\n//]]>\n</script>")
    end

    it "should return text_field mask format for date" do
      masked_text_field(:user, :birth, :mask => '99/99/9999').should eql("<input id=\"user_birth\" name=\"user[birth]\" size=\"30\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_birth').mask('99/99/9999');\n//]]>\n</script>")
    end

    it "should return text_field mask in date format and size 10" do
      masked_text_field(:user, :birth, :size => 10, :mask => '99/99/9999').should eql("<input id=\"user_birth\" name=\"user[birth]\" size=\"10\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#user_birth').mask('99/99/9999');\n//]]>\n</script>")
    end

    it "should return text_field default if no parameter mask" do
      masked_text_field(:user, :birth).should eql("<input id=\"user_birth\" name=\"user[birth]\" size=\"30\" type=\"text\" />")
    end

  end

  describe "predefined methods" do

    it "should return text_field mask to price us" do
      price_us_text_field(:product, :price, :size => 10).should eql("<input id=\"product_price\" name=\"product[price]\" size=\"10\" type=\"text\" /><script type=\"text/javascript\">\n//<![CDATA[\n$('#product_price').priceFormat();\n//]]>\n</script>")
    end

  end

end
