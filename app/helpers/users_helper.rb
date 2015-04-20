module UsersHelper
  def job_title_icon(title)
    case title
    when "Developer"
      "<i class='fa fa-code'></i>"
    when "Entrepreneur"
      "<i class='fa fa-lightbulb-o'></i>"
    when "Investor"
      "<i class='fa fa-money'></i>"
    else 
      "<i class='fa fa-question'></i>"
    end
  end
end