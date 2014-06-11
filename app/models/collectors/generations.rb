class Collectors::Generations

  def initialize version
    @version = version
  end

  def generations
    Generation.joins(version: :model).where({versions: {model_id: @version.model_id}, models: {brand_id: @version.model.brand_id}})
  end
end