module PostsHelper
  def render_with_hashtags(content)
    content.gsub(/(?<tag>#\w+)/) { hashtag_link(Regexp.last_match[:tag]) }
  end

  def hashtag_link(tag)
    link_to html_escape(tag), tag_path(tag[1..-1])
  end
end
