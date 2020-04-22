module ApplicationHelper
  # check user role
  # return boolean
  def is_super_admin?
    has_role?("1")
  end

  def is_manager?
    has_role?("2")
  end

  def is_admin?
    has_role?("3")
  end

  def is_user?
    has_role?("4")
  end

  def is_company_owner?(id)
    Company.find(id).user_id == current_user.id ? true : false
  end

  def has_role?(role_id)
    return current_user && current_user.role_id.split(",").include?(role_id)
  end

  def user_has_role?(user, role_id)
    return user.role_id.split(",").include?(role_id)
  end

  def has_company?
    Company.find_by(user_id: current_user.id) ? true : false
  end

  # remove http,www, form url
  def strip_url(target_url)
    target_url.to_s.downcase.gsub("http://", "")
    .to_s.downcase.gsub("https://", "")
    .to_s.downcase.gsub("www.", "")
  end

  def page_heading(title)
    content_for(:title){ title }
  end

  def meta_keywords(keywords)
    if keywords.present?
      content_for(:keywords){ keywords }
    else
      content_for?(:keywords) ? yield(:keywords) : ''
    end
  end

  def meta_description(description)
    if description.present?
      content_for(:description){ description }
    else
      content_for?(:description) ? yield(:description) : ''
    end
  end
end
