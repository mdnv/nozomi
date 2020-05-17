Rails.application.routes.draw do
  devise_for :staffs, only: [:sessions, :passwords], controllers: { sessions: 'staffs/sessions',
                                                                    passwords: 'staffs/passwords' }
  devise_for :supervising_organizations, only: [:sessions], controllers: { sessions: 'organizations/sessions' }

  namespace :api, format: :json do
    namespace :v1 do
      namespace :secure do
        resources :job_recruitments, only: [:show]
        resources :supervising_organizations, only: [] do
          member do
            get 'available_company_ids'
          end
        end
      end
    end
  end

  namespace :staffs, path: 'manage', as: 'manage' do
    resources :dashboard, only: [:index]
    resources :staffs
    resources :supervising_organizations
    resources :job_recruitments
    resources :companies
    resources :applicants do
      scope module: :applicants do
        resource :experiences_confirmation, only: [:edit, :update]
        resource :current_application, only: [:update, :destroy]
        resources :examination_results do
          collection do
            delete 'cancel'
            delete 'close'
          end
        end
        resources :studying_results do
          collection do
            delete 'cancel'
            delete 'close'
          end
        end
        resource :resumes, except: [:new]
      end
    end

    root 'dashboard#index'
  end

  namespace :organizations, path: 'supervise', as: 'supervise'  do
    resources :home, only: [:index]
    resources :job_recruitments

    root 'home#index'
  end

  # Frontend
  resources :home

  root 'home#index'
end
