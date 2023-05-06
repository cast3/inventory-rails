module ApplicationHelper
  include Pagy::Frontend

  def sort_link_to(name, column, **options)
    direction = if params[:sort] == column.to_s
                  params[:direction] == 'asc' ? 'desc' : 'asc'
                else
                  'asc'
                end
    up = 'fa-sharp fa-solid fa-arrow-up-wide-short text-primary-hover-500 pl-1'
    down = 'fa-sharp fa-solid fa-arrow-down-wide-short text-primary-hover-500 pl-1'
    icon_class = params[:sort] == column.to_s && params[:direction] == 'asc' ? up : down
    link_to request.params.merge(sort: column, direction:), **options do
      "#{name} <i class='#{icon_class}'></i>".html_safe
    end
  end

  def random_dark_color
    format('#%02x%02x%02x', rand(25..150), rand(25..110), rand(25..160))
  end
end
