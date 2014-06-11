# encoding: utf-8
namespace :populate do
  desc "Populate test data."
  task test_data: :environment do
    french_user  = FactoryGirl.create :french_user, password: 'password', password_confirmation: 'password'
    english_user = FactoryGirl.create :english_user, password: 'password', password_confirmation: 'password'
    russian_user = FactoryGirl.create :user,  country_code: 'RU', locale: 'en'

    english_user.followings.create thing: french_user
    english_user.followings.create thing: russian_user

    renault = FactoryGirl.create :brand, name: 'Renault'
    megane  = FactoryGirl.create :model, name: 'Megane', vehicle_type: 'automobile', brand: renault
    megane_version = FactoryGirl.create :version, :approved, name: 'Coupe_2_0_T_265_RS', label_fr: 'Coupé 2.0 T 265 RS', label_en: 'Coupe 2.0 T 265 RS', model: megane

    {
      cylinders:            '4',
      displacement:         '1997',
      max_power:            '134.6',
      max_power_frequency:  '4400',
      max_torque:           '600',
      max_torque_frequency: '4400',
      length:               '4360',
      top_speed:            '188',
      accel_time_0_100_kph: '16.4',
      consumption_city:     '13.8',
      consumption_highway:  '9.4',
      consumption_mixed:    '11'
    }.each do |name, value|
      FactoryGirl.create :version_property, version: megane_version, name: name.to_s, value: value
    end
    megane_side_view = FactoryGirl.create :side_view, :image_upload, file_name: 'test1.jpg', version: megane_version

    peugeot = FactoryGirl.create :brand, name: 'peugeot'
    p206    = FactoryGirl.create :model, name: '206', vehicle_type: 'automobile', brand: peugeot
    p206_version = FactoryGirl.create :version, :approved, name: 'CC_2_0_16S', label_fr: 'CC 2.0 16S', label_en: 'CC 2.0 16S', model: p206

    {
      cylinders:            '4',
      displacement:         '1996',
      max_power:            '182',
      max_power_frequency:  '6000',
      max_torque:           '190',
      max_torque_frequency: '4100',
      length:               '4360',
      top_speed:            '210',
      accel_time_0_100_kph: '9.3',
      consumption_city:     '12.2',
      consumption_highway:  '7.3',
      consumption_mixed:    '8'
    }.each do |name, value|
      FactoryGirl.create :version_property, version: p206_version, name: name.to_s, value: value
    end

    bmw     = FactoryGirl.create :brand, name: 'BMW'
    s1000rr = FactoryGirl.create :model, name: 'S1000RR', vehicle_type: 'motorcycle', brand: bmw
    bmw_version = FactoryGirl.create :version, name: 'abs', label_fr: 'ABS', label_en: 'ABS', model: s1000rr

    FactoryGirl.create :version_property, version: bmw_version, name: "length", value: '3320'
    bmw_side_view = FactoryGirl.create :side_view, :image_upload, file_name: 'test4.jpg', version: bmw_version

    chevrolet = FactoryGirl.create :brand, name: 'chevrolet'
    niva      = FactoryGirl.create :model, name: 'niva', vehicle_type: 'automobile', brand: chevrolet
    niva_version = FactoryGirl.create :version, :approved, name: 'basic', label_fr: 'De base', label_en: 'Basic', model: niva

    french_megane  = FactoryGirl.create :vehicle, :with_avatar, user: french_user, version: megane_version, side_view: megane_side_view
    french_s1000rr = FactoryGirl.create :vehicle, :with_avatar, user: french_user, version: bmw_version, side_view: bmw_side_view
    english_206    = FactoryGirl.create :vehicle, user: english_user, version: p206_version
    russian_niva   = FactoryGirl.create :vehicle, :with_avatar, user: russian_user, version: niva_version

    FactoryGirl.create :change_set, :with_modifications, vehicle: english_206

    megane_gallery_1 = FactoryGirl.create :gallery, :finished, title: 'Gallery 1', vehicle: french_megane
    megane_pic_1 = FactoryGirl.create :picture, :image_upload, title: 'Picture 1', gallery: megane_gallery_1, file_name: 'test1.jpg'
    megane_pic_2 = FactoryGirl.create :picture, :image_upload, title: 'Picture 2', gallery: megane_gallery_1, file_name: 'test2.jpg'

    megane_pic_1.update_attributes :covered_gallery => megane_gallery_1

    megane_gallery_2 = FactoryGirl.create :gallery, :finished, title: 'Gallery 2', vehicle: french_megane
    megane_pic_3 = FactoryGirl.create :picture, :image_upload, title: 'Picture 3', gallery: megane_gallery_2, file_name: 'test3.jpg'

    megane_pic_3.update_attributes :covered_gallery => megane_gallery_2

    sample_1_collage = FactoryGirl.create :collage, gallery: megane_gallery_1, active_layout: 'sample-1'

    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_collage, layout: 'sample-1', row: 1, col: 1, crop: { x: 0, y: 0, w: 560, h: 390 }, picture: megane_pic_1
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_collage, layout: 'sample-1', row: 1, col: 2, crop: { x: 100, y: 100, w: 370, h: 185 }, picture: megane_pic_2
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_collage, layout: 'sample-1', row: 2, col: 2, crop: { x: 100, y: 100, w: 370, h: 195 }, picture: megane_pic_2

    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_collage, layout: 'sample-2', row: 1, col: 1, picture: megane_pic_1

    sample_2_collage = FactoryGirl.create :collage, gallery: megane_gallery_1, active_layout: 'sample-2'
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_2_collage, layout: 'sample-2', row: 1, col: 1, crop: { x: 100, y: 100, w: 370, h: 195 }, picture: megane_pic_1
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_2_collage, layout: 'sample-2', row: 2, col: 1, crop: { x: 100, y: 100, w: 370, h: 185 }, picture: megane_pic_1
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_2_collage, layout: 'sample-2', row: 1, col: 2, crop: { x: 0, y: 0, w: 560, h: 390 }, picture: megane_pic_2

    sample_1_profile_collage = FactoryGirl.create :profile_collage, profile: french_user, active_layout: 'sample-1'

    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_profile_collage, layout: 'sample-1', row: 1, col: 1, crop: { x: 0, y: 0, w: 560, h: 390 }, picture: megane_pic_3
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_profile_collage, layout: 'sample-1', row: 1, col: 2, crop: { x: 100, y: 100, w: 370, h: 185 }, picture: megane_pic_1
    FactoryGirl.create :cutout, :uploaded_picture, collage: sample_1_profile_collage, layout: 'sample-1', row: 2, col: 2, crop: { x: 100, y: 100, w: 370, h: 195 }, picture: megane_pic_2

    15.times do
      FactoryGirl.create :comment,
        picture: megane_pic_2,
        user: [french_user, english_user, russian_user].sample,
        body: Faker::Lorem.paragraph(1 + rand(1))
    end

    [].tap do |placeholder_galleries|
      placeholder_galleries << FactoryGirl.create(:gallery, vehicle: french_s1000rr)
      placeholder_galleries << FactoryGirl.create(:gallery, vehicle: english_206)
    end.each do |gallery|
      2.times { |n| FactoryGirl.create :picture, title: "Picture #{n+1}", gallery: gallery, image_big_width: 800, image_big_height: 600 }
    end
  end
end
