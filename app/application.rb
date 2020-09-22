# class Application

#   @@items = ["Apples","Carrots","Pears"]

#   def call(env)
#     resp = Rack::Response.new
#     req = Rack::Request.new(env)

#     if req.path.match(/items/)
#       @@items.each do |item|
#         resp.write "#{item}\n"
#       end
#     elsif req.path.match(/search/)
#       search_term = req.params["q"]
#       resp.write handle_search(search_term)
#     else
#       resp.write "Path Not Found"
#     end

#     resp.finish
#   end

#   def handle_search(search_term)
#     if @@items.include?(search_term)
#       return "#{search_term} is one of our items"
#     else
#       return "Couldn't find #{search_term}"
#     end
#   end
# end


class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples", "Oranges"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

########### ITEMS PATH ###########
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
########### CART PATH ###########
    elsif req.path.match(/cart/)
      if @@cart.size == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |c|
          resp.write "#{c}\n"
        end
      end
########### ADD PATH ###########
    elsif req.path.match(/add/)
      if @@items.include?(req.params.values.join(""))
        @@items.each do |item|
          @@cart << item
          resp.write "added #{item}"
        end
      else
        resp.write "We don't have that item"
      end
      
########### NO PATH FOUND ###########
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      if req.path.match(/add/)
        return "We don't have that item"
      end
      return "Couldn't find #{search_term}"
    end
  end
end
