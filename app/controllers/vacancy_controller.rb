class VacancyController < ApiController
  def show
    render json: Vacancy.current
  end
end
