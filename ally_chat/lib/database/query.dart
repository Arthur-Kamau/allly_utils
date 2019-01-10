class Query {
  static String contactListTableSql = """
CREATE TABLE contacts (
  id INTEGER PRIMARY KEY  AUTOINCREMENT,
  user_name TEXT,
  user_phone_number TEXT,
  statusContactHasApp INTEGER ,
    createdAt TEXT ,
    updatedAt TEXT
);
""";

  static String usersTable = """
	CREATE TABLE IF NOT EXISTS users_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,

		UserId   varchar(100),
		PhoneNumber varchar(30),
		UserName varchar(50),
		PublicName varchar(50),
 
		UserAvatar varchar(100),
		WhatIDo varchar(50),
		UserInterest text,
		UserGender INTEGER DEFAULT 3,
		UserLatLong varchar(50), 
		UserLocation varchar(50), 
		
    createdAt TEXT ,
    updatedAt TEXT
	)""";

  static String groupsTable = """
	CREATE TABLE IF NOT EXISTS groups_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,
		
		GroupId   varchar(100),
		GroupName varchar(30),
		GroupStatus varchar(30),
		GroupType INTEGER,
		GroupAvatar varchar(100),
		GroupInterest text,
		GroupMembers text,
		GroupAdmin text,

  createdAt TEXT ,
    updatedAt TEXT
	)""";

 static String blockedTable = """
CREATE TABLE IF NOT EXISTS user_contacts_blocked (
		id serial PRIMARY KEY,

	    userBlocking  varchar(100),
		name varchar(100),
		phoneNumber varchar(100) NOT NULL,
		email varchar(100),
		has_app INTEGER,

  createdAt TEXT ,
    updatedAt TEXT
	)
 """;

  static String mailTable = """
	CREATE TABLE IF NOT EXISTS mail_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,

		Userid  varchar(100),
		ViewLink text NOT NULL,
		StatusType INTEGER,

  createdAt TEXT ,
    updatedAt TEXT

	)""";

  static String styleTable = """
	CREATE TABLE IF NOT EXISTS style_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,

		Font varchar(15),
		Color varchar(15),
		Theme INTEGER,

  createdAt TEXT ,
    updatedAt TEXT
	)""";

  static String statusTable = """
	CREATE TABLE IF NOT EXISTS  status_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,


		UserId  varchar(100),
		IsDeleted bool ,

		StatusId varchar(100),
		ContentType INTEGER,
		ContentLink text,

		UsersViewed text,
		UsersLiked text,

 createdAt TEXT ,
    updatedAt TEXT
	)""";

  static String userStatusTable = """
	CREATE TABLE IF NOT EXISTS  user_status_table (
		id INTEGER PRIMARY KEY   AUTOINCREMENT,

		UserId  varchar(100),
		UserPublicName varchar(100),

		UserAvatar varchar(100),
 
		ViewPolicy INTEGER,
		StatusId   varchar(100),
		UsersBlocked text,
		UserAllowedToView text,

 createdAt TEXT ,
    updatedAt TEXT
	)""";



  static String chatsP2PTable = """
CREATE TABLE IF NOT EXISTS chat_p2p_table (
		id serial PRIMARY KEY,

		ChatId varchar(100),
		RecepientId  varchar(100),
		SenderId varchar(100),

		ChatStatusType INTEGER,
		MessageStatus  INTEGER,
		ContentType INTEGER,
		Content TEXT,

 createdAt TEXT ,
    updatedAt TEXT


	)""";

  static String chatsPoketable = """
CREATE TABLE IF NOT EXISTS chat_poke_table (
		id serial PRIMARY KEY,

		ChatType INTEGER,
		ChatCategory INTEGER,
		RecepientId  varchar(100),
		SenderId varchar(100),

		ChatStatusType INTEGER,
		MessageStatus  INTEGER,
		ContentType INTEGER,
		Content TEXT,

	

 createdAt TEXT ,
    updatedAt TEXT

	)""";
  static String chatsP2GTable = """
CREATE TABLE IF NOT EXISTS chat_p2g_table (
		id serial PRIMARY KEY,

   senderPhoneNumber varchar(100),
   senderPublicName varchar(100),
   senderId varchar(100),
   groupId varchar(100),

   statusType INTEGER,
   messageStatus INTEGER,
   contentType INTEGER,
   content TEXT,
  
 createdAt TEXT ,
    updatedAt TEXT

	)""";

  static String channelsTable = """
CREATE TABLE IF NOT EXISTS channel_table (
		id serial PRIMARY KEY,

		ChannelId  varchar(100),
		ChannelName varchar(100),
		ChannelAvatar text,
		ChannelInterest text,
		ChannelMembers text,
		ChannelCreator varchar(100), 
    	

 createdAt TEXT ,
    updatedAt TEXT

	)""";

//if users is currently loged in
//status if online/offline

  static String loggedInTable = """
	CREATE TABLE IF NOT EXISTS logged_in_table (
		id serial PRIMARY KEY,

		user_id   varchar(100),
		user_agent varchar(100),
		user_token varchar(100),
		user_agent_id varchar(100),
		user_state varchar(100),
		status varchar(100),


	

 createdAt TEXT ,
    updatedAt TEXT

	)""";
}
