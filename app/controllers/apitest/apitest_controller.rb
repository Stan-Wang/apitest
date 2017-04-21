require_dependency "apitest/application_controller"

module Apitest
  class ApitestController < ApplicationController
    before_action :get_doc ,:root_url
    def initialize
      super
      @apidocs = {}
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

    def docs_base 
      {
        '业务API' => [] ,
        '工具API' => [] ,
        '辅助API' => []
      }
    end
    def get_doc(path_root = nil)
      path_root ||= "app/controllers/#{Apitest.api_dir}/"
      Dir.glob("#{path_root}*").each do |path|
        @apidocs[path.gsub("#{path_root}" , '')] =  get_version_doc "#{path}/" if File.directory?(path) && !path.gsub("#{path_root}" , '').blank?
      end
    end

    def get_version_doc(path_root)
      docs = docs_base
      Dir.glob("#{path_root}/*").each do |path|
        if File.directory?(path)
          docs = docs.merge get_version_doc(path)
        else
          class_match      = File.open(path).read.match(/class (.*) </)
          controller_class = class_match[1].constantize if class_match && class_match[1]
          if defined? controller_class::APIDOC
            token_need = {
              token: {
                text: 'token' ,
                required: true ,
              }
            } 
            doc = controller_class::APIDOC 
            doc[:sort] = 99 if doc[:sort].blank?
            doc[:apis].each do |k,v|
              doc[:apis][k][:params] = token_need.merge doc[:apis][k][:params] unless v[:token] == false
            end 
            docs[doc[:type]] = [] if docs[doc[:type]].blank?
            docs[doc[:type]].push doc
          end
        end
      end
      docs
    end
  end
end
