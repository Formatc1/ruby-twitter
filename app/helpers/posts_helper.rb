module PostsHelper
  def render_with_hashtags(content)
    content.gsub(/(?<tag>#\w+)/) { hashtag_link(Regexp.last_match[:tag]) }
  end

  def hashtag_link(tag)
    link_to html_escape(tag), tag_path(tag[1..-1])
  end

  def display_date(date)
    now = Time.now.utc
    case
    when date.day == now.utc.day
      return "#{time_ago_in_words(date)} ago"
    when date.year == now.year
      return date.strftime('%B %e %k:%M')
    else
      return date.strftime('%B %e, %y')
    end
  end
end
