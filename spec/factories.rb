# encoding: utf-8

require 'rack/test/uploaded_file'

module FactoryGirl
  module FixtureFileUpload
    def file_upload(path, mime_type='image/jpeg', binary=false)
      Rack::Test::UploadedFile.new(
        File.join('spec', 'fixtures', 'files', path),
        mime_type,
        binary
      )
    end
  end
end

FactoryGirl.send(:extend, FactoryGirl::FixtureFileUpload)

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@mailinator.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:persistence_token) { |n| "persist#{n}" }
    country_code 'GB'
    locale 'en'

    trait :french do
      country_code 'FR'
      locale 'fr'
    end

    trait :english do
      country_code 'GB'
      locale 'en'
    end

    factory :english_user, traits: [:english]
    factory :french_user, traits: [:french]
  end

  factory :admin_user do
    sequence(:email) { |n| "admin_user#{n}@mailinator.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :vehicle do
    vehicle_type 'automobile'

    association :user
    association :version

    trait :easily_named do
      ignore do
        sequence(:brand_name) { |n| "Brand #{n}" }
        model_name 'Felicita'
      end

      version nil

      before(:create) do |vehicle, evaluator|
        vehicle.version = FactoryGirl.create :version, :easily_named, model_name: evaluator.model_name, brand_name: evaluator.brand_name
      end
    end

    trait :approved do
      after(:create) do |vehicle|
        vehicle.version.approve!
      end
    end

    trait :with_avatar do
      ignore do
        file_name 'test1.jpg'
      end
      avatar { FactoryGirl.file_upload file_name }
    end

    factory :easy_vehicle, traits: [:easily_named]
    factory :easy_approved_vehicle, traits: [:easily_named, :approved]
    factory :approved_vehicle, traits: [:approved]
    factory :vehicle_with_avatar, traits: [:with_avatar]
  end

  factory :vehicle_bookmark do
    association :user
    association :vehicle
  end

  factory :brand do
    sequence(:name) { |n| "brand_#{n}" }
    vehicle_types ['automobile', 'motorcycle']
  end

  trait :pending do
    pending true
  end

  trait :not_pending do
    pending false
  end

  trait :close_to_fixes do
    open_to_fixes false
  end

  trait :open_to_fixes do
    open_to_fixes true
  end

  trait :rejected do
    rejected true
  end

  factory :model do
    sequence(:name) { |n| "Model #{n}" }
    vehicle_type 'automobile'

    association :brand

    trait :easily_named do
      ignore do
        sequence(:brand_name) { |n| "Brand #{n}" }
      end

      before(:create) do |model, evaluator|
        model.brand = Brand.find_by_name(evaluator.brand_name) || FactoryGirl.create(:brand, name: evaluator.brand_name)
      end
    end

    factory :easy_model, traits: [:easily_named]
  end

  factory :version do
    sequence(:name) { |n| "version_#{n}" }
    sequence(:label_en) { |n| "Version name #{n}" }
    sequence(:label_fr) { |n| "Nom de version #{n}" }
    association :model

    trait :easily_named do
      ignore do
        sequence(:brand_name) { |n| "Brand #{n}" }
        model_name 'Felicita'
      end

      model nil

      before(:create) do |version, evaluator|
        version.model = FactoryGirl.create :model, :easily_named, name: evaluator.model_name, brand_name: evaluator.brand_name
      end
    end

    trait :with_length_property do
      ignore do
        length 3000
      end

      after(:create) do |version, evaluator|
        FactoryGirl.create :version_property, version: version, name: 'length', unit_type: 'length', value: evaluator.length
      end
    end

    trait :approved do
      after(:create) do |version|
        version.approve!
      end
    end

    factory :easy_version, traits: [:easily_named]
    factory :easy_length_version, traits: [:easily_named, :with_length_property]
    factory :easy_approved_length_version, traits: [:easily_named, :with_length_property, :approved]
    factory :approved_version, traits: [:approved]
    factory :easy_approved_version, traits: [:easily_named, :approved]
  end

  factory :side_view do
    association :version

    trait :image_upload do
      ignore do
        file_name 'test1.jpg'
        version nil
      end
      image { FactoryGirl.file_upload file_name }
      before :create do |side_view, evaluator|
        side_view.version = evaluator.version
        side_view.version_id = evaluator.version.id
      end
    end
    factory :uploaded_side_view, traits: [:image_upload]
  end

  factory :gallery do
    sequence(:title) { |n| "Gallery #{n}" }
    layout 'grid'

    association :vehicle

    trait :finished do
      finished true
    end
  end

  factory :album do
    sequence(:title) { |n| "Album #{n}" }

    association :user
  end

  factory :picture_base, class: Picture do
    sequence(:title) { |n| "Picture #{n}" }

    trait :image_upload do
      ignore do
        file_name 'test1.jpg'
      end
      image { FactoryGirl.file_upload file_name }
    end
  end

  factory :picture, class: Galleries::Picture, parent: :picture_base do
    association :gallery

    factory :uploaded_picture, traits: [:image_upload]
  end

  factory :profile_picture, class: Profiles::Picture, parent: :picture_base do
    association :profile, factory: :user
  end

  factory :part do
    sequence(:label_en) { |n| "Part #{n}" }
    sequence(:label_fr) { |n| "Part #{n}" }
    brand { FactoryGirl.create(:brand) }
  end

  factory :service do
    association :vendor
    factory :part_installation_service do
      duration_type '2'
      service_type  'part_installation'
    end
  end

  factory :vendor do
    sequence(:name) { |n| "Vendor #{n}" }
    country_code 'FR'
  end

  factory :modification do
    association :vehicle
    trait :with_part do
      ignore do
        part "spoiler"
        quantity 3
        price 1000
      end
      after :create do |modification, evaluator|
        part = FactoryGirl.create(:part, brand: modification.vehicle.brand, label_en: evaluator.part)
        modification.part_purchases << FactoryGirl.create(:part_purchase,
                                                          vehicle: evaluator.vehicle,
                                                          modification: modification,
                                                          quantity: evaluator.quantity,
                                                          part: part,
                                                          price: evaluator.price)
      end
    end

    trait :with_service do
      ignore do
        service 'part_installation'
        duration 3
        garage "Bob cleaner"
      end

      after :create do |modification, evaluator|
        vendor = FactoryGirl.create :vendor, name: evaluator.garage
        modification.services << FactoryGirl.create(:part_installation_service,
                                                    service_type: evaluator.service,
                                                    duration_type: evaluator.duration,
                                                    vendor: vendor)
      end
    end

    trait :with_part_purchase_and_service  do
      after :create do |modification, evaluator|
        FactoryGirl.create(:part_purchase, vehicle: evaluator.vehicle, modification: modification)
        modification.services << FactoryGirl.create(:part_installation_service)
      end
    end

    factory :service_modification, traits: [:with_service]
    factory :part_modification, traits: [:with_part]
  end

  factory :change_set do
    sequence(:name) {|n| "Change set #{n}"}
    association :vehicle
    trait :with_modifications do
      before :create do |change_set, evaluator|
        change_set.modifications = FactoryGirl.create_list :modification, 3, :with_part_purchase_and_service, vehicle: evaluator.vehicle
      end
    end
  end

  factory :part_purchase do
    main false
    quantity 4

    association :vendor
    association :part
    association :vehicle
    association :modification
  end

  factory :comment do
    sequence(:body) { |n| "Comment #{n}" }

    ignore do
      human_created_at 'now'
    end
    created_at { Chronic.parse human_created_at }

    association :user
    association :picture
  end

  factory :collage_base, class: Collage do
    active_layout 'sample-1'

    trait :with_sample_cutouts do
      after :create do |collage|
        [
          { row: 1, col: 1 },
          { row: 1, col: 2 },
          { row: 2, col: 2 }
        ].each do |coords|
          FactoryGirl.create :cutout, collage: collage, row: coords[:row], col: coords[:col]
        end
      end
    end
  end

  factory :collage, parent: :collage_base, class: GalleryCollage do
    association :gallery

    factory :sample_collage, traits: [ :with_sample_cutouts ]
  end

  factory :profile_collage, parent: :collage_base, class: ProfileCollage do
    association :profile, factory: :user
  end

  factory :cutout do
    layout 'sample-1'
    association :collage
    association :picture
    row 1
    col 1

    trait :uploaded_picture do
      crop { { x: 0, y: 0, w: 560, h: 380 } }
      picture { FactoryGirl.create :uploaded_picture }
      image { picture.image.big }
    end
  end
end
