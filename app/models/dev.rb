class Dev < ActiveRecord::Base
    has_many :freebies
    has_many :companies, through: :freebies

    def received_one?(item_name)
        target_item = self.freebies.find_by(item_name: item_name)
        target_item != nil 
    end

    def give_away(dev, freebie)
        if self.received_one?(freebie.item_name) == true
            Freebie.create(item_name: freebie.item_name, value: freebie.value, company_id: freebie.company_id, dev: dev)
            delete_freebie = self.freebies.find(freebie.id)
            delete_freebie.destroy
            self.reload
            dev.reload
        else
            "This Dev does not own the freebie to give it away"
        end
    end

    # Extra features not on the deliverables
    def freebies_total_value
        self.freebies.sum{|freeb| freeb.value}
    end

    def richer_dev(dev)
        self.freebies_total_value > dev.freebies_total_value ? self.name : dev.name
    end

    def self.richest_dev
        target_total = self.all.map{|dev| dev.freebies_total_value}.max
        self.all.select{|dev| dev.freebies_total_value == target_total}
    end

end
