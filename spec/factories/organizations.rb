# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :organization, class: Organization do
    key 'key'
    initialize_with { Organization.first_or_create(key: :key)}      
  end  

  factory :helsinki_uni, class: Organization do
    name  'Helsingin yliopisto'
    key   'helsinki'
    #_id   '4f6b1edf91bc2b33d3010300'
    initialize_with { Organization.first_or_create(key: :key)}
  end

  factory :spartan_teknillinen_yliopisto, class: Organization do
    name  'Spartan Teknillinen Yliopisto'
    key   'sty'
    #_id   '4f6b1edf91bc2b33d3010000'
    initialize_with { Organization.first_or_create(key: :key)}
  end

  factory :luonnontieteellinen_tiedekunta, class: Organization do
    name  'Luonnontieteellinen tiedekunta'
    #_id   '4f6b1edf91bc2b33d3010100'
    parent { FactoryGirl.create(:spartan_teknillinen_yliopisto) }
    initialize_with { new(name: name)}
  end

  factory :kirjasto, class: Organization do
    name  'Kirjasto'
    #_id   '4f6b1edf91bc2b33d3010200'
    parent { FactoryGirl.create(:spartan_teknillinen_yliopisto) }
  end

  factory :kemian_laitos, class: Organization do
    name  'Kemian laitos'
    #_id   '4f6b1edf91bc2b33d3010101'
    #parent { FactoryGirl.create(:luonnontieteellinen_tiedekunta) }
    parent {
      unless Organization.where(name: 'Luonnontieteellinen tiedekunta').exists?
        FactoryGirl.create(:luonnontieteellinen_tiedekunta)
      else
        Organization.find_by(name: 'Luonnontieteellinen tiedekunta')
      end
    }
  end

  factory :fysiikan_laitos, class: Organization do
    name  'Fysiikan laitos'
    #_id   '4f6b1edf91bc2b33d3010102'
    # parent { FactoryGirl.create(:luonnontieteellinen_tiedekunta) }
    parent {
      unless Organization.where(name: 'Luonnontieteellinen tiedekunta').exists?
        FactoryGirl.create(:luonnontieteellinen_tiedekunta)
      else
        Organization.find_by(name: 'Luonnontieteellinen tiedekunta')
      end
    }
  end

  factory :akhaimenidien_yliopisto, class: Organization do
    name  'Akhaimenidien Yliopisto'
    key   'ay'
    #_id   '5e5c1edf91bc2b3300000000'
    initialize_with { Organization.first_or_create(key: :key)}
  end

  factory :akhaimenidien_kirjasto, class: Organization do
    name  'Akhaimenidien Kirjasto'
    #_id   '5e5c1edf91bc2b3302000000'
    parent { FactoryGirl.create(:akhaimenidien_yliopisto) }
  end

end
