class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book)
    else
    @books = Book.all
    @user = current_user
    render 'index'
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments =BookComment.all
    @book_comment_user = current_user
  end

  def edit
   @book = Book.find(params[:id])
   @user = current_user
   if @user != @book.user
   redirect_to books_path
   
   end
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
    params.require(:book).permit(:title, :body)
  end

end
