class SearchController < ApplicationController
  def fetch_list
  	@results = Scrapper.new(params[:item]).start_process
  end
end
