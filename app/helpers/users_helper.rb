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

  def format(item)
    # empty temp variables
    arr = []
    str = ""
    # converts a :symbol_like_this into ["Symbol", "Like", "This"]
    item.to_s.split('_').each { |s| arr << s.capitalize }
    # concatenates the string "Symbol Like This "
    arr.each {|s| str += s + ' '}
    # returns the string "Symbol Like This:"
    str.rstrip + ':'
  end
end