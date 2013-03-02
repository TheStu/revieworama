module ApplicationHelper

  def full_title(page_title) #Returns the full title on a per-page basis.
    base_title = "Revieworama"
    if page_title.empty?
      base_title
    elsif page_title == "home"
      "#{base_title} | Write Reviews, Answers Questions, Make Money"
    else
      "#{page_title} | #{base_title}"
    end
  end

  def meta_desc(desc) #Returns the full title on a per-page basis.
    if desc.empty?
      "Write reviews of your favorite products and get a commission when other people buy those products"
    else
      desc
    end
  end

  def pretty_date(date)
    date = date.to_date
    new_date = date.strftime("%b #{date.day.ordinalize}, %Y")
  end

  def flash_class(level) #change rails alerts in to bootstrap alerts (associated partial and application.html code)
   case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}.png"
  end

  def pic_res(url, res)
    url.gsub('.jpg', "._SL#{res}_.jpg")
  end

  def parent_asin(result)
    result.asin == result.raw.ParentASIN ? result.asin : result.raw.ParentASIN
  end

  def plural_name(name)
    name.ends_with?('s') ? "#{name}'" : "#{name}'s"
  end
end
