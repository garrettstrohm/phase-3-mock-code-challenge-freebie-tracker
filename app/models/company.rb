class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies

    def give_freebie(dev, item_name, value)
        Freebie.create(item_name: item_name, value: value, company: self, dev: dev)
    end

    def self.oldest_company
        self.all.min{|a, b| a.founding_year <=> b.founding_year}
    end

    # Extra features not on the deliverables
    def self.youngest_company
        self.all.max{|a, b| a.founding_year <=> b.founding_year}
    end

end
