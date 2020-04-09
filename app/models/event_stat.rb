class EventStat < ApplicationRecord
  before_save :actualizar_stats_sold
  private
    def actualizar_stats_sold
      stat = self.ticket_type.event.event_stat
      stat.attendance +=1
      stat.tickets_sold +=1
      stat.save!
    end
  after_destroy :actualizar_stats_unsold
  private
    def actualizar_stats_unsold
      stat = self.ticket_type.event.event_stat
      stat.attendance -=1
      stat.ticket_sold -=1
      stat.save!
    end
  before_save :max_capacidad
  private
   def max_capacidad
     stat = self.ticket_type.event.event_stat
     sold = stat.ticket_sold
     capacity = self.ticket_type.event.event_venue.capacity
     validates :sold, numericality: {less_than_or_equal_to: capacity}
   end
  belongs_to :event
end
