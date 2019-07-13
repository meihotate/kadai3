class UsersController < ApplicationController

before_action :authenticate_user!

  def show
		@book_new = Book.new
		@user = User.find(params[:id])
		@books = @user.books
  end

  def create
		@book = Book.new(book_params)
      if @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to books_path
      end
  end

  def edit
  		@user = User.find(params[:id])
        if @user != current_user
        redirect_to user_path(current_user.id)
        end
  end

  def update
  		@user = User.find(params[:id])
  		# if @user.update(user_params)
      #   flash[:notice] = "User information was successfully updated."
    		# redirect_to user_path(@user.id)
      # else
      #   flash[:notice] = "information shall be within 50 letters."
      #   redirect_to edit_user_path(@user.id)
      # end

      if @user.update(user_params)
          flash[:notice] = "User information was successfully updated."
          redirect_to user_path(@user.id)
      else
            render :edit
      end
  end

  def index
      @book_new = Book.new
      @users = User.all
  end

  private
    def book_params
        params.require(:book).permit(:title, :body)
    end

    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
