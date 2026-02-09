module Jekyll
  module RenderLiquidFilter
    def render_liquid(input)
      template = Liquid::Template.parse(input)
      template.render(@context)
    end

    def absolutify_images(input)
      return input if input.nil? || input.empty?
      site_config = @context.registers[:site].config
      site_url = site_config['url']
      # Convert relative image src to absolute URLs
      input.gsub(/src="\/assets\//, "src=\"#{site_url}/assets/")
          .gsub(/src='\/assets\//, "src='#{site_url}/assets/")
    end
  end
end

Liquid::Template.register_filter(Jekyll::RenderLiquidFilter)
