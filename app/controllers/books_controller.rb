class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  #def new
    #@book = Book.new #空のインスタンスを生成
  #end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end


  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book =  Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

private

def book_params
  params.require(:book).permit(:title, :body)
end

def is_matching_login_user
  book = Book.find(params[:id])
  unless book.id == current_user.id
    redirect_to books_path
  end
end
end