# :: Helpers
module Helpers

  def execute_query(sql_query) # string
    ActiveRecord::Base.connection.execute(sql_query) if sql_query.present?
  end

end
