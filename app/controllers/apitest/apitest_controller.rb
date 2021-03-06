require_dependency "apitest/application_controller"

module Apitest
  class ApitestController < ApplicationController
    before_action :get_doc ,:root_url
    def initialize
      super
      @apidocs    = {}
      @headers    = Apitest::set_headers
      @token_set =  Apitest::token_setting[:set]
      @token_get =  Apitest::token_setting[:get]
    end
    def index
      respond_to do |format|
        format.json { render json: @apidocs}
        format.html 
      end
    end

    def show
      respond_to do |format|
        format.html 
        format.json { render json: @apidocs[params[:id]]}
      end
    end
  
    private  
    def root_url
      @root_url = main_app.root_url[0,main_app.root_url.length - 1]
    end  

    def get_doc(path_root = nil)
      path_root ||= "app/controllers/#{Apitest.api_dir}/"
      Dir.glob("#{path_root}*").each do |path|
        @apidocs[path.gsub("#{path_root}" , '')] =  get_version_doc "#{path}" if File.directory?(path) && !path.gsub("#{path_root}" , '').blank?
      end
    end

    def get_version_doc(path_root , docs = {})
      docs = Apitest::default_types.clone if docs.blank?
      Dir.glob("#{path_root}/*").each do |path|
        if File.directory?(path)
          docs = docs.merge get_version_doc(path , docs)
        else
          class_match      = File.open(path).read.match(/class (.*) </)
          controller_class = class_match[1].constantize if class_match && class_match[1]
          if defined? controller_class::APIDOC
            doc         = controller_class::APIDOC 
            doc[:sort]  = 99 if doc[:sort].blank?
            doc[:apis].each do |k,v|
              d = doc[:apis][k]
              d = public_required d                               unless Apitest::public_required.blank? 
              d[:params]  = {':id' => { required: true }}.merge d[:params]  if d[:path].include? ':id'
            end 
            
            docs[doc[:type]] = [] if docs[doc[:type]].blank?
            docs[doc[:type]].push doc
          end
        end
      end
      return docs
    end
    def public_required(api)
      Apitest::public_required.reverse.each do |need|
        api[:params] = need.merge api[:params] if api[need.keys.first.to_sym] != false
      end 
      return api
    end
  end
end
