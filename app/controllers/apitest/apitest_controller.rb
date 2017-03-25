require_dependency "apitest/application_controller"

module Apitest
  class ApitestController < ApplicationController
    before_action :get_doc
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
    def get_doc
      path_root = "app/controllers/api/"
      @apidocs = {}
      Dir.glob("#{path_root}*").map do |path|
        if File.directory?(path)
          @apidocs[path.gsub("#{path_root}" , '')] =  get_version_doc "#{path}/"
        end
      end
      @root_url = main_app.root_url[0,main_app.root_url.length - 1]
    end

    def get_version_doc(path_root)
      
      docs = {
        '业务API' => [] ,
        '工具API' => [] ,
        '辅助API' => []
      }
      dirs = []
      Dir.glob("#{path_root}*_controller.rb").each do |path|
        controller_name_base = path.gsub(path_root , '').gsub('.rb' , '').singularize.camelize
        controller_class = "Api::V1::#{controller_name_base}".constantize
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
      docs
    end
  end
end
