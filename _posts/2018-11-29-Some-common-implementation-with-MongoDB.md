---
layout: post
title: Some common implementation with MongoDB
bigimg: /img/path.jpg
tags: [NoSQL, MongoDB]
---

MongoDB is the most compatible tool in NoSQL for Node.js. Because in Node.js, it use the JSON object to exchange data among the component. And Javascript also supports many things for JSON object.
To begin with MongoDB, you have to learn some basic instructions in MongoDB, especially on command line.

## Open command line in the path of MongoDB
When installing the MongoDB application, the default path of it can be "C:\Program Files\MongoDB\Server\4.0\bin". 

At this folder, you can open with cmd or "Open with VS code".


## Start the MongoDB
To start this application, you can use command.

```Javascript
mongod
```


## Type command at the Terminal / Cmd Windows
After the above step, you will press the command "mongo" to initialize the mongo shell. 

```Javascript
mongo
```

It helps you to press command directly at the cmd or Terminal of Visual Studio Code. 


## Show the possible database 
If you want to know which databases is used in MongoDB, you will need to use the below command. 

```Javascript
showdbs
```


## Use the database / Create new database 
With the command "use name_db", you will make the database new if the "name_db" does not exist, or if it exists, you will use this database.

```Javascript
use name_db
```

Notice: When using this command "use name_db", you have to insert the information into this "name_db" database. If not, the application will not detect it.


## Display all collections in database 

```Javascript
show collections
```

## Make the new collection in the database 

```Javascript
db.createCollection('table1');
```

## Delete the database 

```Javascript
db.dropDatabase();
```

Before deleting this database, you have to type the command "use name_db" to determine which database will be used. 


## Insert data into the collection of database 
The command "db.createCollection('name_collection')" will make the new collection into the database that is using. But now, you want to update data into this collection "name_collection", you can use the below command:

```Javascript
db.name_collection.insert(json_string);
```

Notice: json_string is the string of json object that you have to make it. 


## Display all of object in collection in one line

```Javascript
db.name_collection.find();
```

## Display all of object in collection in many lines

```Javascript
db.name_collection.find().pretty();
```


Thanks for your reading. 
