Rails.application.routes.draw do


  resources :questions do
    post "add_comment"
    get "close"
  end
  resources :sections
  resources :agreements do
    get "vendor_feedback"
    get "approved"
    get "export_pdf"
    get "add_note"
    get "get_note"
  end

  resources :terms do
    resources :comments
    collection do
      post "add_comment"
    end
  end
  resources :draftsections

  resources :draftterms do
    resources :comments
  end
  resources :comments
  resources :draftagreements do
    get "updatestatus"
    get "feedback"
    get "setting_access"
    get "add_note"
    get "get_note"
    get "create_copy"
    collection do
      get "published_agreements"
      get "feedback_agreements"
    end
  end
  root to: 'visitors#index'
  get '/users/route' => 'users#route', as: :user_root # creates user_root_path
  get "/users/legal_dashboard" => "users#legal_dashboard"
  get "/users/user_dashboard" => "users#user_dashboard"
  get "/agreementtemplates/:id/in_use" => "agreementtemplates#in_use"
  get "/drafts/select_agreement_title" => "drafts#select_agreement_title"
  get "/agreementtemplates/get_agreement_titles" => "agreementtemplates#get_agreement_titles"
  get "/sectiontemplates/get_section_names" => "sectiontemplates#get_section_names"


  devise_for :users
  resources :users
  resources :demands do
    get "add_asset"
    collection do
      post "upload"
    end

  end
  resources :termtemplates
  resources :companies
  resources :sectiontemplates
  resources :agreementtemplates
end
