package = "kong-plugin-nevavalidator"
version = "1.0.1-0"
supported_platforms = {"linux", "macosx"}
source = {
  url = "https://github.com/pindipoluravikumar/kong-plugin-nevavalidator.git"
}
description = {
  summary = "Kong Plugin for validating the neva request"  
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
   ["kong.plugins.nevavalidator.handler"] = "kong/plugins/nevavalidator/handler.lua",
   ["kong.plugins.nevavalidator.schema"] = "kong/plugins/nevavalidator/schema.lua"
  }
}
