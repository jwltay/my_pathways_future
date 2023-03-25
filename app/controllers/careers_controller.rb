require 'json'

class CareersController < ApplicationController
  def index
    @user = current_user
    @careers = @user.careers
    nodes = [
      {
        "id": "1",
        "name": @user.first_name,
        "val": @user.first_name
      }
    ] + @careers.each_with_index.map do |career, index|
      {
        "id": (index + 2).to_s,
        "name": career.name,
        "val": career.name
      }
    end

    links = [
      [2..@careers.length].map do |i|
        {
          "source:": i.to_s,
          "target": "1"
        }
      end
    ]

    graph_data = {
      "nodes": nodes,
      "links": links
     }

    File.open("app/views/careers/graph.json", "wb") do |file|
      file.write(JSON.generate(graph_data))
    end
  end

  def show
    @career = Career.find(params[:id])
  end

  # def new
  #   @career = Career.new
  # end

  # def create
  #   @career = Career.new(career_params)
  #   @career.user = current_user
  #   if @career.save
  #     redirect_to career_path(@career)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def edit
  #   @career = Career.find(params[:id])
  # end

  # def update
  #   @careere = Career.find(params[:id])
  #   @career.update!(career_params)
  #   redirect to career_path(current_user)
  # end

  # private

  # def career_params
  #   params.require(:career).permit(:average_salary, :description, :name, :summary)
  # end
end
