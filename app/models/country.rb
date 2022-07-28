class Country < ApplicationRecord
    has_many :traceips
    belongs_to :currency, optional: true

    validates :name, presence: true

    def get_languages
      lista =" "
      self.languages.each do |hash|  
        lista =  lista + ", #{hash["native"]} (#{hash["code"]})" if lista != ""
        lista = "#{hash["native"]} (#{hash["code"]})" if lista == ""
      end
      lista
    end

end
