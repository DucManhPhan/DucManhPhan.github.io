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

Ex: use tech_shops

Notice: When using this command "use name_db", you have to insert the information into this "name_db" database. If not, the application will not detect it.


## Display all collections in database 

```Javascript
show collections
```

## Make the new collection in the database 

```Javascript
db.createCollection('table1');
```

Ex: db.createCollection('listOfWebsite');

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

Ex: db.listOfWebsite.insert({
  "name": "tiki", 
  "link": "https://tiki.vn", 
  "products": [
    "mobile", "books"
  ]
});

Notice: json_string is the string of json object that you have to make it. 


## Display all of object in collection in one line

```Javascript
db.name_collection.find();
```

## Display all of object in collection in many lines

```Javascript
db.name_collection.find().pretty();
```


## Update data in the specific object in collection


```Javascript
db.name_collection.update(
  <condition>, 
  <update>,
  {multi: true}
)
```

Ex: db.listOfWebsite.update(
  {"name": "amazon"}, 
  {$set: {"incomes": "1 billions dollar"}}, 
  {upsert: true},
  {multi: true}
);

When "multi: true" property, it means many object that satifies the condition, will be updated. 

But multi property is false, it will update for one object that application finds the objects that is satified. 


Ex: db.listOfWebsite.update(
  {"name": "amazon", 
  {$unset: {"incomes": "1 billions dollar}},
  {multi: false}
)

When you see the field "unset", it means that when it satisfies the condition, it will delete the field "incomes: \"1 billion dollar\"" at the first object that it found. 

And "upsert" filed = update + insert. The default value of "upsert" is false. It means:
- upsert = true : If it does not find the other fields that satifies the condition, it will automatically insert this field into the object and set value for this field. 
- upsert = false : if the object has no field, it will ignore it. 


Thanks for your reading. 
