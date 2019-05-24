class QuotesController < ApplicationController
  def index
    @quotes = Quote.all
    authorize @quote
  end
end
