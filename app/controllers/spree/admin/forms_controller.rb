require 'yaml'

class Spree::Admin::FormsController < Spree::Admin::BaseController
  before_filter :find_form ,:only=>[:edit,:form_lang_edit,:form_lang_update]

 def index
    @forms = Form.all

    respond_to do |format|
      format.html 
      format.json { render json: @forms }
    end
  end

  def show
      @form = Form.find(params[:id])
      # @form_booking_german = YAML.load_file"../BoxConcept/config/locales/de.yml"
      # @form_booking_english = YAML.load_file"../BoxConcept/config/locales/en.yml"

      respond_to do |format|
        format.html 
        format.js
        format.json { render json: @form }
      end
    end

  
  
  def new
    @form = Form.new
   
    respond_to do |format|
      format.html 
      format.json { render json: @form }
    end
  end

  
   
  def create
    @form = Form.new(params[:form])


    respond_to do |format|
      if @form.save
        format.html { redirect_to [:admin,@form], notice: 'Form was successfully created.' }
        format.json { render json: [:admin,@form], status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @form = Form.find(params[:id])

    respond_to do |format|
      if @form.update_attributes(params[:form])
        format.html {redirect_to [:admin,@form], notice: 'Form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    respond_to do |format|
      format.html { redirect_to forms_url }
      format.json { head :no_content }
    end
  end

  def fetch_yml

    if params["lang"] == "de"
      @yml_obj = YAML.load_file(Rails.root + "config/locales/de.yml")
      @yml_obj = @yml_obj["de"]
    else
      @yml_obj = YAML.load_file(Rails.root + "config/locales/en.yml")
      @yml_obj = @yml_obj["en"]
    end
  end
  

  def form_lang_update
    self.fetch_yml 
    
    @yml_obj[@form.form_name].keys.each do |key|
      @yml_obj[@form.form_name][key] = params[key]  
    end
    
    lang = {}
    
    if params["lang"] == "de"
      lang["de"] = @yml_obj
      File.open(Rails.root + "config/locales/de.yml","w") { |f| YAML.dump(lang, f) }

    else
      lang["en"] = @yml_obj
      File.open(Rails.root + "config/locales/en.yml","w") { |f| YAML.dump(lang, f) }
    end


    respond_to do |format|
      format.html {redirect_to [:admin,@form] ,:url=> form_lang_update_admin_form_path, notice: 'Form was successfully updated.' }
      format.json { head :no_content }
    end
  end


  def form_lang_edit
    self.fetch_yml 
    @yml_values = @yml_obj[@form.form_name.to_s]   

  end  


  private
    def find_form
       @form = Form.find(params[:id])
    end  
end
