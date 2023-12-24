#!/usr/bin/env python
# coding: utf-8

# In[1]:


from bs4 import BeautifulSoup
import requests


# In[2]:


url ='https://pokemondb.net/pokedex/all'
page = requests.get(url)
soup = BeautifulSoup(page.text, 'html')


# In[4]:


initial_table = soup.find('div', class_ = 'resp-scroll')
#print(initial_table)


# In[5]:


attributes = initial_table.find_all('th')
print(attributes)


# In[9]:


clean_attributes = [attribute.text.strip() for attribute in attributes]
print(clean_attributes)


# In[10]:


import pandas as pd


# In[12]:


df = pd.DataFrame(columns = clean_attributes)
df


# In[14]:


records = initial_table.find_all('tr')
#print(records)


# In[17]:


for record in records[1:]:
    record_data = record.find_all('td')
    record_data_final = [record.text.strip() for record in record_data]
    #print(record_data_final)
    length = len(df)
    df.loc[length] = record_data_final


# In[18]:


df


# In[19]:


df.to_csv(r'C:\Users\user\Desktop\Pokemon2024.csv')


# In[ ]:




