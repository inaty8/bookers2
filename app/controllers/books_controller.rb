class BooksController < ApplicationController
 before_action :authenticate_user!
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

    def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        redirect_to book_path(@book.id),notice: 'successfully.'
      else
        @books = Book.all
        @user = current_user
        render :index
      end
    end

  def show
    @new_book = Book.new
    @book_comment = BookComment.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id!=current_user.id
      redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book),notice:"successfully."
    else
      render :edit
    end
  end


    # 投稿データのストロングパラメータ
  private


  def book_params
    params.require(:book).permit(:title, :body)
  end


end
