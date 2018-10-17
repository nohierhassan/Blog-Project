module ApplicationHelper
  def gravatar_for(user, options={size: 100})
    size = options[:size]
    begin
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.username, class: "img-circle")  
    rescue 
      image_tag("/home/non/Documents/RailsProjects/BlogProject/app/assets/images/no-avatar.png", class:"img-circle")
    end
    
  end

end
