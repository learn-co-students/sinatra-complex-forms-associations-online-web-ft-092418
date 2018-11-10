class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all

    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
      @pet = Pet.create(params[:pet])
      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
      end
      @pet.save
      redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      @owners = Owner.all
      erb :"pets/edit"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    #binding.pry
    pet = Pet.find_by_id(params[:pet][:id])
    if params[:owner][:name] != ""
      pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
    else
      pet.owner = Owner.find_by(params[:owner][:id])
    end
    pet.update(params[:pet])
    redirect to "pets/#{pet.id}"
  end
end
