class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    if options[:site_name]
      @site_name = options[:site_name]
    else
      @site_name = fetch_title(url)
    end
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    return [format_description(@description), format_name]
  end

  private
  def fetch_title(url)
    # This function fetches the HTML title text from internet
    html_page = Nokogiri::HTML(open(url))
    title = html_page.css('title').text
    return title
  end
end
