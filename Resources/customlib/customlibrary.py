import json
import requests
from requests.auth import HTTPBasicAuth
from variables import SITE_URL, USER_NAME, LAST_NAME

class customlibrary:
   ROBOT_LIBRARY_SCOPE = 'TEST CASE'

   @staticmethod
   def access_token(name, pwd):
      url =  SITE_URL + 'api/auth/token'
      headers={"content-type": "application/json"}
      try:
         response = requests.get(url, auth=HTTPBasicAuth(name, pwd))
         return json.loads(response.text)['token']
      except Exception as error:
         return 'Unable to reach URL due to {}'.format(error)    

   @staticmethod
   def update_user(token):
      url = SITE_URL + 'api/users/api_new_user'
      payload = json.dumps({"firstname": "firstname_updated"})
      headers={"content-type": "application/json", "token": token}
      try:
         response = requests.put(url, headers=headers, data=payload)
         return response.text   
      except Exception as error:
         return 'Unable to reach URL due to {}'.format(error)    

   @staticmethod
   def register_user(user, pwd, firstname, lastname, phone):
      URL= SITE_URL + 'api/users'
      headers={"content-type": "application/json"}
      data=json.dumps({"username": user, "password": pwd, "firstname": firstname, "lastname": lastname, "phone": phone})
      try:
         response = requests.post(URL, headers=headers, data=data)
         status_code, message = response.status_code, response.json().get('message')
         if status_code == 201 and message == 'Created':
            return 'User created successfully'
         if status_code == 400 and message == 'User exists':
            return 'User already exists'
      except Exception as error:
         return 'Unable to reach URL due to {}'.format(error)

   @staticmethod
   def get_registered_users(token):
      url = SITE_URL + 'api/users'
      headers={"content-type": "application/json", "token": token}
      try:
         response = requests.get(url, headers=headers)
         users_list = json.loads(response.text)['payload']
         return users_list
      except Exception as error:
         return 'Unable to reach URL due to {}'.format(error)   

   @staticmethod
   def review_registered_users(token):
      registered_users = customlibrary.get_registered_users(token)
      if USER_NAME in registered_users:
         return "User is reviewed"
      else:
         return "User is not reviewed"    

   @staticmethod
   def get_user_information(token):
      url = SITE_URL + 'api/users/api_new_user'
      headers={"content-type": "application/json", "token": token}
      response = requests.get(url, headers=headers)
      user_information = json.loads(response.text)['payload']
      if LAST_NAME in [user_information].__str__():
         return "User personal information is reviewed"
      else:
         return "User personal informarion is not reviewed"