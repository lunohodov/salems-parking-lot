class VacancyController < ApiController
  def show
    v = Vacancy.current
    render json: { free_spaces: v.free_spaces }
  end
end
