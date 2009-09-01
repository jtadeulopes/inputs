require File.dirname(__FILE__) + '/spec_helper'

describe Inputs do

  include Inputs
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::AssetTagHelper

  describe "method javascript_include_inputs" do

    it "should include the necessary files" do
      javascript_include_inputs.gsub(/([0-9?])/,'').should eql("<script src=\"/javascripts/jquery.meio.mask.min.js\" type=\"text/javascript\"></script><script type=\"text/javascript\">\n//<![CDATA[\n(function($){$(function(){$('input:text').setMask();});})(jQuery);\n//]]>\n</script>")
    end

  end

  describe "method masked_text_field" do

    it "should return text_field mask format for mobile" do
      masked_text_field(:user, :phone, :mask => '(99)9999-9999').should eql("<input alt=\"(99)9999-9999\" id=\"user_phone\" name=\"user[phone]\" size=\"30\" type=\"text\" />")
    end

    it "should return text_field mask format for date" do
      masked_text_field(:user, :birth, :mask => '99/99/9999').should eql("<input alt=\"99\/99\/9999\" id=\"user_birth\" name=\"user[birth]\" size=\"30\" type=\"text\" />")
    end

    it "should return text_field mask in date format and size 10" do
      masked_text_field(:user, :birth, :size => 10, :mask => '99/99/9999').should eql("<input alt=\"99\/99\/9999\" id=\"user_birth\" name=\"user[birth]\" size=\"10\" type=\"text\" />")
    end

    it "should return text_field default if no parameter mask" do
      masked_text_field(:user, :birth).should eql("<input id=\"user_birth\" name=\"user[birth]\" size=\"30\" type=\"text\" />")
    end

    it "should return text_field mask format for cep" do
      masked_text_field(:purchase, :cep, :mask => '9999-999').should eql("<input alt=\"9999-999\" id=\"purchase_cep\" name=\"purchase[cep]\" size=\"30\" type=\"text\" />")
    end

    it "should return text_field mask format for cep and alt='Enter Zip'" do
      masked_text_field(:purchase, :cep, :mask => '9999-999', :alt => 'Enter Zip').should eql("<input alt=\"9999-999\" id=\"purchase_cep\" name=\"purchase[cep]\" size=\"30\" title=\"Enter Zip\" type=\"text\" />")
    end

    it "should return text_field mask format for cep and title='Enter Zip'" do
      masked_text_field(:purchase, :cep, :mask => '9999-999', :title => 'Enter Zip').should eql("<input alt=\"9999-999\" id=\"purchase_cep\" name=\"purchase[cep]\" size=\"30\" title=\"Enter Zip\" type=\"text\" />")
    end

  end

  describe "method price_us_text_field (deprecated)" do

    it "should return text_field mask to price us" do
      lambda do
        price_us_text_field(:product, :price, :size => 10)
      end.should raise_error
    end

  end

end
