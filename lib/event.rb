class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    if @start_date && @end_date && (@start_date > @end_date)
      raise UdaciListErrors::EventPeriodError, "start date should be before end date!"
    end
  end
  def format_date
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" unless dates
    return dates
  end
  def details
    format_description(@description) + "event dates: " + format_date
  end
end
