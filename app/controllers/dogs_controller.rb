class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    if current_user
      @dogs = Dog.for_owner(current_user.id)
    else
      @dogs = Dog.all
    end



  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.owner = current_user
    respond_to do |format|
      if @dog.save!
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.owner != current_user
        @dog.errors.add(:base, "Cannot update a dog that does not belong to you.")
        format.html { redirect_to @dog, notice: @dog.errors.full_messages.join(',') }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      elsif @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    if @dog.owner != current_user
      respond_to do |format|
        @dog.errors.add(:base, "Cannot delete a dog that does not belong to you.")
        format.html { redirect_to @dog, notice: @dog.errors.full_messages.join(',') }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
    end

    else
      @dog.destroy
      respond_to do |format|
        format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, :images => [])
    end
end
