require 'rails_helper'

RSpec.describe Traceip, type: :model do
  subject { Traceip.create_with( {"ip"=>"83.44.196.93", "type"=>"ipv4", "continent_code"=>"EU", "continent_name"=>"Europe",
                                  "country_code"=>"ES", "country_name"=>"Spain", "region_code"=>"CT", "region_name"=>"Catalonia", 
                                  "city"=>"Vic", "zip"=>"08500", "latitude"=>41.93029022216797, "longitude"=>2.254349946975708, 
                                  "location"=>{"geoname_id"=>3106050, "capital"=>"Madrid", "languages"=>[{"code"=>"es", 
                                  "name"=>"Spanish", "native"=>"Español"}, {"code"=>"eu", "name"=>"Basque", "native"=>"Euskara"},
                                  {"code"=>"ca", "name"=>"Catalan", "native"=>"Català"}, {"code"=>"gl", "name"=>"Galician", "native"=>"Galego"},
                                  {"code"=>"oc", "name"=>"Occitan", "native"=>"Occitan"}], "country_flag"=>"https://assets.ipstack.com/flags/es.svg",
                                  "country_flag_emoji"=>"🇪🇸", "country_flag_emoji_unicode"=>"U+1F1EA U+1F1F8", "calling_code"=>"34", "is_eu"=>true}})}


  it "create a country" do 
    expect(subject.country).to_not eq(nil)
  end

end