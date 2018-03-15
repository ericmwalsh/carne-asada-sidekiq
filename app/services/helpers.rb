# :: Helpers
module Helpers

  def beginning_of_day(timestamp)
    Time.at(timestamp).utc.beginning_of_day.to_i
  end

  def execute_query(sql_query) # string
    ActiveRecord::Base.connection.execute(sql_query) if sql_query.present?
  end

end
