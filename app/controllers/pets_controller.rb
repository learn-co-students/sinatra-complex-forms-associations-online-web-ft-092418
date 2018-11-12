class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
   #binding.pry
    @pet = Pet.create(params[:pet])
  #  binding.pry
    if !params["pet"]["owner_id"]
    #  binding.pry
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get "/pets/:id/edit" do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    #binding.pry
    erb :"/pets/edit"
  end

  patch '/pets/:id' do
    # if !params[:pet].keys.include?("owner_id")
    #   params[:pet]["owner_id"] = []
    # end
    #######
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name], owner_id: params[:pet][:owner_id])

  # binding.pry
    if params["owner"]["name"] != ""
      #binding.pry
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
