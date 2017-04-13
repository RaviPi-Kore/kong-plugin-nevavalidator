local responses = require "kong.tools.responses"
local BasePlugin = require "kong.plugins.base_plugin"
local http = require"socket.http"
local ltn12 = require"ltn12"
local utils = require "kong.tools.utils"
local constants = require "kong.constants"
local responses = require "kong.tools.responses"

local get_headers = ngx.req.get_headers

local NevaValidatorHandler = BasePlugin:extend()

NevaValidatorHandler.PRIORITY = 900

function NevaValidatorHandler:new()
  NevaValidatorHandler.super.new(self, "nevavalidator")
end
function NevaValidatorHandler:access(conf)
  NevaValidatorHandler.super.access(self)
  
  --local get_url = 'https://api-dev.aineva.com/webconsole/v1/1/models/incidents'
  local model_id =ngx.var.uri:match("^.+/models/(.+)$"):match("[^/]*")

  local org_id=ngx.req.get_headers()["X-Consumer-Custom-ID"]  

  local response_body = { }
    
  local res, code, response_headers, status = http.request
  {
    url = 'http://api-dev.aineva.com/webconsole/v1/'..org_id..'/models/'..model_id,
    method = "GET",
    headers =
    {
      ["Content-Type"] = "application/json"      
    },
     sink = ltn12.sink.table(response_body)
  }

 
  if code == 200 then
  ngx.header["model_data"]=response_body;
  ngx.header["model_validation_success"] = 'true';
  else

  responses.send_HTTP_FORBIDDEN("Unknown model")
  end
  
end

return NevaValidatorHandler