class EventStat < ApplicationRecord
  before_save :actualizar_stats_sold
  private
    def actualizar_stats_sold
      stat = self.ticket_type.event.event_stat
      stat.attendance +=1
      stat.tickets_sold +=1
      stat.save
    end
  after_destroy :actualizar_stats_unsold
  private
    def actualizar_stats_unsold
      stat = self.ticket_type.event.event_stat
      stat.attendance -=1
      stat.tickets_sold -=1
      stat.save
    end
  before_create :max_capacidad
  private
   def max_capacidad
     stat = self.ticket_type.event.event_stat
     sold = stat.ticket_sold
     capacity = self.ticket_type.event.event_venue.capacity
     if sold >= capacity
       puts "ERROR BECAUSE THE TICKETS_SOLD WOULD BE BIGGER THAN THE CAPACITY OF THE VENUE"
       throw :abort
     end
   end
  belongs_to :event
end
