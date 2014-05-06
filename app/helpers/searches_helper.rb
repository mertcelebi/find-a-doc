module SearchesHelper

  def redirect_back_or(default)
   redirect_to(search[:return_to] || default)
   search.delete(:return_to)
 end
end
