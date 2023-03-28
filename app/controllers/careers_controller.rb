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

  def graph_career_nodes
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

  def graph_programme_nodes
    arr = []
    @careers.each do |career|
      career.programmes.each do |programme|
        arr << { "id": programme.name.titleize, "name": career.name.titleize, "val": "1" }
      end
    end
    arr
  end

  def graph_career_links
    @careers.map do |career|
      {
        "source": @user.first_name.capitalize,
        "target": career.name.titleize
      }
    end
  end

  def graph_programme_links
    arr = []
    @careers.each do |career|
      career.programmes.each do |programme|
        arr << { "source": career.name.titleize, "target": programme.name.titleize }
      end
    end
    arr
  end

  def generate_graph_json
    graph_data = {
      "nodes": graph_career_nodes + graph_programme_nodes,
      "links": graph_career_links + graph_programme_links
    }

    File.open('public/graph.json', "wb") do |file|
      file.write(JSON.generate(graph_data))
    end
  end
end
