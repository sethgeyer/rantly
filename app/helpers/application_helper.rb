module ApplicationHelper

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(content)
  end

  def make_hashtag_searchable(content)
    array = content.split(" ")
    linked_array = array.map do |word|
      if word[0] == "#"
        "<a href='/rants?search=%23#{word[1..word.length]}'>#{word}</a>"
      else
        word
      end
    end
    linked_array.join(" ").html_safe
  end



end
