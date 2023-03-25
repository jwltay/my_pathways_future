require 'json'

class CareersController < ApplicationController
  def index
    @user = current_user
    @careers = @user.careers
    nodes = [
      {
        "id": @user.first_name.capitalize,
        "name": "id1",
        "val": "1"
      }
    ] + @careers.each_with_index.map do |career, index|
      {
        "id": career.name.titleize,
        "name": "id#{index + 2}",
        "val": "1"
      }
    end

    links = @careers.map do |career|
      {
        "source": career.name.titleize,
        "target": @user.first_name.capitalize
      }
    end


    graph_data = {
      "nodes": nodes,
      "links": links
    }

    File.open('public/graph.json', "wb") do |file|
      file.write(JSON.generate(graph_data))
    end
  end

  def show
    @career = Career.find(params[:id])
  end
end
