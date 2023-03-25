require 'json'

class CareersController < ApplicationController
  def index
    @user = current_user
    @careers = @user.careers
    nodes = [
      {
        "id": "id1",
        "name": @user.first_name,
        "val": "1"
      }
    ] + @careers.each_with_index.map do |career, index|
      {
        "id": "id#{index + 2}",
        "name": career.name,
        "val": (index + 2).to_s
      }
    end

    links = Array(2..(@careers.length + 1)).map do |i|
      {
        "source": "id#{i}",
        "target": "id1"
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
