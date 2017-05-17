# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require lodash
#= require bootstrap
#= require adminlte/adminlte
#= require vue
#= require_directory .
#= require_self

$(document).on "turbolinks:load" , ->
  if $('#apitest_show').length == 1
    $('body').addClass('sidebar-collapse')
    vm = new Vue
      el : '#apitest_show'
      data : 
        apitest_tab_show : 'api_test'
        root_url      : null
        apis          : null
        ws            : null
        output_area   : null
        current_group : ''
        current_api   : ''
        token         : ''
        token_type    : ''
        token_set     : {}
        token_get     : []
        headers       : {}
      mounted : ->
        @apis         = $('#data').data('apis')
        @token_set    = $('#data').data('token-set')
        @token_get    = $('#data').data('token-get')
        @token_type   = @token_set[0]
        @output_area  = $('#server-logs-output')
        @root_url     = $('#data').data('root-url')
        @get_log()
        @set_token(localStorage.apitest_token)
        # @token_set()

      methods : 
        set_token : (token) ->
          @token = token
          localStorage.apitest_token = token
          @set_header_token() if @token_set[0] == 'header'
            
        set_header_token : ->
          @headers[@token_set[1]] = @token

        fetch_token : (params) ->
          token = eval 'params["' + @token_get.join('"]["') + '"]'
          @set_token(token) if token

        group_select : (name) ->
          @current_group  = name
          @current_api    = ''

        api_select : (name) ->
          @current_api    = name

        api_submit : (e) ->
          elm         = $(e.target).parents('.api')
          result      = elm.find('.result')
          result_pre  = elm.find('.result_pre')
          path        = elm.find('.path').val().replace ':id' , elm.find('.params[name=":id"]').val()
          method      = elm.find('.method').text()
          postData    = {}

          elm.find('.params').each ->
            postData[$(this).attr('name')] = $(this).val() unless $(this).attr('name').indexOf(':id') >= 0

          $.ajax 
            url       : path
            type      : method
            data      : postData
            headers   : @headers
            success   : (data) =>
              result_pre.jsonViewer(data)
              @fetch_token(data)
            error     : (data) =>
              try
                result_pre.jsonViewer(JSON.parse(data.responseText))
              catch e
                result_pre.text(data.responseText)
              
              

        clear_result  : (e) ->
          $(e.target).parents('.api').find('.result_pre').html('')

        log_scroll : ->
          $('#server-logs-output').scrollTop document.getElementById("server-logs-output").scrollHeight

        get_log : (e) ->
          unless @ws 
            @ws = new WebSocket($('#data').data('ws-url')) 
            @ws.onmessage = (evt) => 
              $("<div>" + evt.data   + "<div>").appendTo(@output_area)
              @log_scroll()

          $('#server-logs-output').height $('.api-wrap').height() - 104

        clear_log : ->
          $('#server-logs-output').html('')


        show_api_test : ->
          @apitest_tab_show = 'api_test'
        show_server_log : ->
          @apitest_tab_show = 'server_log'
          @get_log()
  $.AdminLTE.layout.fix() if $.AdminLTE.layout
  
 








