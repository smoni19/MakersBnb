require 'pg'

def reset_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE spaces;")
  connection.exec("TRUNCATE accounts;")
end