class QUERY{  
  static String contactCreateQuery  = "CREATE TABLE Contact (id INTEGER PRIMARY KEY ,name TEXT,phone_number TEXT)";
  static String blockedContactCreateQuery  = "CREATE TABLE blocked_Contact (id INTEGER PRIMARY KEY ,name TEXT,phone_number TEXT)";
 static String userAccountProfileCreateQuery  = "CREATE TABLE user_Account_Profile (id INTEGER PRIMARY KEY ,name TEXT,phone_number TEXT,country_code TEXT,email TEXT,location TEXT, status TEXT,whatIDo TEXT,interest TEXT,image_local TEXT,image_remote TEXT)";
}