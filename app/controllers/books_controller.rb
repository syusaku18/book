class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @books = Book.all
    @book = Book.new
  end
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  def edit

    @book = Book.find(params[:id])

  end
  def update

    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end



  def show
    @book_deteil= Book.find(params[:id])
    @book=Book.new
    @user = @book_deteil.user
    @book_comment = BookComment.new
  end
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    book_deteil= Book.find(params[:id])
    user = book_deteil.user
    unless user.id == current_user.id
      redirect_to  books_path
    end
  end
end
