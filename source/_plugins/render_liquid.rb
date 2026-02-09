module Jekyll
  module RenderLiquidFilter
    def render_liquid(input)
      template = Liquid::Template.parse(input)
      template.render(@context)
    end
    
    def absolutify_images(input)
      return input if input.nil? || input.empty?
      site_url = @context.registers[:site].config['url']
      # Convert relative image src to absolute URLs
      input.gsub(/src="\/assets\//, "src=\"#{site_url}/assets/")
          .gsub(/src='\/assets\//, "src='#{site_url}/assets/")
    end
  end
end

Liquid::Template.register_filter(Jekyll::RenderLiquidFilter)
