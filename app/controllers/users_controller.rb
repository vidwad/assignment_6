class UsersController < ApplicationController
              

    def new
    @user = User.new
    end
    
    def create
    @user = User.new user_params
    if @user.save
    session[:user_id] = @user.id
    redirect_to root_path
    else
    render :new
    end
    end

              def edit
                @user = User.find(params[:id])
                # @user = current_user
               
                # puts @user
              end


              def update
                @user = User.find(params[:id])
               
                  if @user.update user_params
                    flash[:success] = "Successfully updated User"
                    render :edit
                    # redirect_to @user
                  else
                    flash.now[:alert] = @post.errors.full_messages.join(", ")
                    render :edit
                  end
                end


                def show
                  @user = User.find(params[:id])
                end


                def updatepswd
                  @user = User.find(params[:id])

                
                    if (params[:current_password] == current_user.password) && (@user.update user_params)
                      flash[:success] = "Successfully updated User Password"
                      render :edit
                     
                    else
                      flash.now[:alert] = @post.errors.full_messages.join(", ")
                      render :edit
                    end
                  end
  
    
    private
    
    def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :old_password)
    end
         

end
