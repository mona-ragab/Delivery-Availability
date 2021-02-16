Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'delivery_supported', to: 'delivery_availability#delivery_supported'
  get '/', to: 'delivery_availability#home'

end
