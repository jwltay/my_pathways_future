require 'json'

class CareersController < ApplicationController
  def index
    @user = current_user
    @careers = @user.careers
    generate_graph_json
  end

  def show
    @career = Career.find(params[:id])
  end

  private

  def graph_nodes
    [{
        "id": @user.first_name.capitalize,
        "name": "id1",
        "val": "1"
    }] + @careers.each_with_index.map do |career, index|
      { "id": career.name.titleize,
        "name": "id#{index + 2}",
        "val": "1" }
    end
  end

  def graph_links
    @careers.map do |career|
      {
        "source": @user.first_name.capitalize,
        "target": career.name.titleize
      }
    end
  end

  def generate_graph_json
    graph_data = {
      "nodes": graph_nodes,
      "links": graph_links
    }

    File.open('public/graph.json', "wb") do |file|
      file.write(JSON.generate(graph_data))
    end
  end
end
