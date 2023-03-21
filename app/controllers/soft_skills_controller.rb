class SoftSkillsController < ApplicationController
  def index
    @soft_skills = Soft_Skill.all
  end

  def show
    @soft_skill = Soft_Skill.find(params[:id])
  end
end
