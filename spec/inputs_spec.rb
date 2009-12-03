require File.dirname(__FILE__) + '/spec_helper'

describe Inputs, :type => :view do

  include InputSpecHelper

  describe "#javascript_include_inputs" do

    it "should include the necessary files js" do
      javascript_include_inputs.gsub(/([0-9?])/,'').should \
        have_tag("script[src=/javascripts/jquery.meio.mask.min.js]")
    end

    it "should call setMask function on the document.ready event" do
      javascript_include_inputs.should \
        have_tag("script+script", :text => %(\n//\n(function($){$(function(){$('input:text').setMask();});})(jQuery);\n//\n))
    end

  end

  describe "#masked_text_field" do

    it "should return text_field mask format for mobile" do
      masked_text_field(:user, :phone, :mask => '(99)9999-9999').should \
        have_tag("input[id=user_phone][type=text][size=30][alt='(99)9999-9999']")
    end

    it "should return text_field mask format for date" do
      masked_text_field(:user, :birth, :mask => '99/99/9999').should \
        have_tag("input[alt='99/99/9999'][id=user_birth][size=30][type=text]")
    end

    it "should return text_field mask in date format and size 10" do
      masked_text_field(:user, :birth, :size => 10, :mask => '99/99/9999').should \
        have_tag("input[alt='99/99/9999'][id=user_birth][size=10][type=text]")
    end

    it "should return text_field default if no parameter mask" do
      masked_text_field(:user, :birth).should \
        have_tag("input[id=user_birth][size=30][type=text]")
    end

    it "should return text_field mask format for cep" do
      masked_text_field(:purchase, :cep, :mask => '9999-999').should \
        have_tag("input[alt='9999-999'][id=purchase_cep][size=30][type=text]")
    end

    it "should return text_field mask format for cep and alt='Enter Zip'" do
      masked_text_field(:purchase, :cep, :mask => '9999-999', :alt => 'Enter Zip').should \
        have_tag("input[alt='9999-999'][id=purchase_cep][size=30][title='Enter Zip'][type=text]")
    end

    it "should return text_field mask format for cep and title='Enter Zip'" do
      masked_text_field(:purchase, :cep, :mask => '9999-999', :title => 'Enter Zip').should \
        have_tag("input[alt='9999-999'][id=purchase_cep][size=30][title='Enter Zip'][type=text]")
    end

  end

  describe "method price_us_text_field (deprecated)" do

    it "should return text_field mask to price us" do
      lambda do
        price_us_text_field(:product, :price, :size => 10)
      end.should raise_error
    end

  end

  describe "#formtastic" do

    include Inputs::Formtastic
    include Formtastic::SemanticFormHelper

    before :each do
      @output_buffer = ''

      @project = mock_model(Project)
      @project.stub!(:class).and_return(::Project)
      @project.stub!(:id).and_return(nil)
      @project.stub!(:name).and_return(nil)
      @project.stub!(:new_record?).and_return(true)
      @project.stub!(:errors).and_return(mock('errors', :[] => nil))

      def projects_path; "/projects"; end
    end

    it "should have an input with mask for cpf" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => :cpf))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt='cpf']")
    end

    it "should have an input with mask for cnpj" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => :cnpj))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt='cnpj']")
    end

    it "should have an input with mask for phone and size 15" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => :phone, :input_html => {:size => '15'}))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt='phone'][size=15]")
    end

    it "should have an input with mask for phone-us " do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => 'phone-us'))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt='phone-us']")
    end

    it "should have an input with mask for decimal and class price" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => :decimal, :input_html => {:class => 'price'}))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt=decimal][class='price']")
    end

    it "should have an input with custom mask (999)9999-9999" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name, :mask => '(999)9999-9999'))
      end
      output_buffer.should have_tag("input[id=project_name][type=text][alt='(999)9999-9999']")
    end

    it "should have an input default if no mask" do
      semantic_form_for(@project) do |form|
        concat(form.input(:name))
      end
      output_buffer.should have_tag("input[id=project_name][type=text]")
    end

  end

end
