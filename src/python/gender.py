import requests

# api-endpoint
URL = "http://api.genderize.io"

# location given here
firstname = "sylvain"

# defining a params dict for the parameters to be sent to the API
PARAMS = {'name':firstname}

# sending get request and saving the response as response object
r = requests.get(url = URL, params = PARAMS)

# extracting data in json format
data = r.json()


# extracting latitude, longitude and formatted address 
# of the first matching location
name = data['name']
gender = data['gender']
probability = data['probability']
count = data['count']

# printing the output
print(" name:%s\n gender:%s\n probability:%s\ncount:%s"
    %(name, gender,probability, count))