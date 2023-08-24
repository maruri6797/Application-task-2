class TagSearchesController < ApplicationController
  def search
    @model = Book
    @word = params[:tag]
    @books = Book.where("tag LIKE?", "%#{@word}%")
  end
end
