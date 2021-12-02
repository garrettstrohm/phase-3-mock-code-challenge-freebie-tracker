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
        else
            "This Dev does not own the freebie to give it away"
        end
    end

end
