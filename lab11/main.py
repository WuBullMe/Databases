from pymongo import MongoClient

#client = MongoClient("mongodb://hostname:port")
client = MongoClient("mongodb://localhost") # will connect to localhost and default port 27017

#client = MongoClient("mongodb://localhost:27017/")

db = client['local']
collect = db['startup_log']


def ex1_1():
    x = collect.find({ 'cuisine' : 'Irish' })
    x = [obj for obj in x]
    print(x)

def ex1_2():
    x = collect.find({ 'cuisine' : 'Irish' })
    y = collect.find({ 'cuisine' : 'Russian' })
    x = [obj for obj in x]
    print(x)
    y = [obj for obj in y]
    print(y)

def ex1_3():
    x = collect.find()
    for y in x:
        if (y['address']['street'] == 'Prospect Park West' 
            and y['address']['zipcode'] == '11215'
            and y['address']['building'] == '284'):
            print( y['name'])


def ex2():
    result = collect.insert_one({"address.street" : ": Sportivnaya", "address.building" : "126", "address.zipcode" : "420500", 
                                 "address.coord.0" : "-73.9557413", "address.coord.1" : "40.7720266", 
                                 "borough" : "Innopolis", "cuisine" : "Serbian", "name" : "The Best Restaurant", 
                                 "restaurant_id" : "41712354", "grades.0.grade" : "A", "grades.0.score" : "11"})
    print(result)

def ex3():
    x = collect.find_one({ 'borough' : 'Brooklyn' })
    res1 = collect.delete_one(x)
    print("Deleted : ", res1)
    x = collect.find({ 'cuisine' : 'Thai' })
    for y in x:
        res2 = collect.delete_one(y)
        print("Deleted : ", res2)


def ex4():
    x = collect.find({ "address.street" : "Prospect Park West" })
    Del = []
    add = []
    for y in x:
        grades = y['grades']
        if len([grade for grade in grades if grade['grade'] == 'A']) > 1:
            Del.append(y)
        else:
            add.append(y)
    for y in Del:
        res2 = collect.delete_one(y)
        print("Deleted : ", res2)
    
    for y in add:
        grades = y['grades']
        len = len([grade for grade in grades if grade['grade'] == 'A'])
        y['grades'][f'{len}']['grade'] = 'A'
        res2 = collect.insert_one(y)
        print("inserted : ", res2)
