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
    @pet = Pet.create(name: params[:pet_name])
    if params["owner"]
      @owner = Owner.find_by_id(params["owner"])
      @pet.owner = @owner
      @pet.save
    elsif !params["owner_name"].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:owner_id]
      @pet.update(owner: Owner.find_by_id(params[:owner_id]))
    end
    if !params[:owner_name].empty?
      @pet.update(owner: Owner.create(name: params[:owner_name]))
    end
    redirect to "pets/#{@pet.id}"
  end
end