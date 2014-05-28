class ItemSearch < Searchlight::Search

  search_on Item

  searches :title, :description, :category

  def initialize(options = {})
  	super
  	self.title ||= " "
  	self.description ||= " "
  	self.category ||= " "
  end

  def search_title
  	search.by_title(title)
  end

  def search_description
  	search.by_description(description)
  end

  def search_category
  	search.by_category(category)
  end
end