class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def index
    @books = Book.page(params[:page]).reverse_order
    @book = Book.new

    
  end

  def create
    @book = Book.new(book_params)
    @books = Book.page(params[:page]).reverse_order
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book)
    else
    render 'index'
    end
  end

  def show
      @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
    redirect_to book_path(@book)
    flash[:notice] = "You have updated book successfully."
    else
    render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
