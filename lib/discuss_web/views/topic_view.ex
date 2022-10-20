defmodule DiscussWeb.TopicView do
  use DiscussWeb, :view # this is using the discuss_web module and use the view function
  # when the app is compiled, this module creates a function called render in the bg
  # the function then can be called with what template name to render (in the folder with the same name under templates)
  # it will then render the markup for that templates
  # When compiled, we get functions added and render gets called to render the view out the box to show something
  # - render/1
  # - render/2
  # - template_not_found/2
  # - __resource__/0
  # this is for all View modules
end
