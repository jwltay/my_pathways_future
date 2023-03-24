if @pathway.persisted?
  render(partial: 'pathways/unshortlist', formats: :html)
else
  render(partial: 'pathways/unshortlist', formats: :html)
end
