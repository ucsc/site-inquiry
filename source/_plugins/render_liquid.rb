module Jekyll
  module RenderLiquidFilter
    def render_liquid(input)
      return input if input.nil? || input.empty?

      # Remove include_relative tags that cause issues in feed context (multi-line aware)
      cleaned_input = input.gsub(/\{%\s*include_relative\s+[^%]*%\}/m, '')

      begin
        template = Liquid::Template.parse(cleaned_input)
        template.render(@context)
      rescue => e
        Jekyll.logger.warn "Render Liquid", "Error rendering liquid: #{e.message}"
        cleaned_input
      end
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
