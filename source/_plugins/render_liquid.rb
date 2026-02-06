module Jekyll
  module RenderLiquidFilter
    def render_liquid(input)
      template = Liquid::Template.parse(input)
      template.render(@context)
    end
  end
end

Liquid::Template.register_filter(Jekyll::RenderLiquidFilter)
