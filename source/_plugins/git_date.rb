module Jekyll
  class GitDateGenerator < Generator
    safe true
    priority :highest

    def generate(site)
      Jekyll.logger.info "Git Date Plugin", "Processing #{site.collections['articles'].docs.length} articles"
      
      count = 0
      site.collections['articles'].docs.each do |doc|
        relative_path = doc.relative_path
        git_date = `git log --diff-filter=A --format='%aI' -- #{relative_path} 2>/dev/null`.strip.split("\n").first
        
        if git_date && !git_date.empty? && git_date =~ /^\d{4}-/
          doc.data['date'] = Time.parse(git_date.strip)
          count += 1
          Jekyll.logger.info "Git Date", "#{doc.data['title']}: #{doc.data['date'].strftime('%Y-%m-%d')}" if count <= 3
        elsif doc.data['issue']
          year = doc.data['issue'].to_i
          doc.data['date'] = Time.parse("#{year}-07-01 12:00:00")
          Jekyll.logger.info "Issue Year", "#{doc.data['title']}: #{year}-07-01" if count <= 3
        else
          doc.data['date'] = File.mtime(doc.path)
        end
      end
      
      Jekyll.logger.info "Git Date Plugin", "Set dates for #{count} articles from git"
    end
  end
end
