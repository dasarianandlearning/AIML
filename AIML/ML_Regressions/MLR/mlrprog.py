# -*- coding: utf-8 -*-
"""
Created on Thu Sep 12 19:58:19 2024

@author: dasar
"""

import numpy as np    
import matplotlib.pyplot as plt
import pandas as pd    


from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
import pickle


dataset = pd.read_csv(r'C:\GRC\Training\Full Stack DataScienceAI\Work_Details\Sep_2024\12thSep_MLR\Investment.csv')

# Split the data into independent and dependent variables
X = dataset.iloc[:, :-1]
y = dataset.iloc[:, 4]

X = pd.get_dummies(X, dtype=int)

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# LinearRegression meaning Algorithm
from sklearn.linear_model import LinearRegression

# Regressor meaning model
regressor = LinearRegression()
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)


# MLR
m = regressor.coef_
print(m)

c = regressor.intercept_
print(c)



X = np.append(arr = np.ones((50,1)).astype(int), values=X, axis=1)


import statsmodels.api as sm
X_opt = X[:,[0,1,2,3,4,5]]

#Ordinary Least Square
regressor_OLS = sm.OLS(endog = y, exog=X_opt).fit()
regressor_OLS.summary() 


#4 has high p_value. So we need to remove this from the dataset
import statsmodels.api as sm
X_opt = X[:,[0,1,2,3,5]]

#Ordinary Least Square
regressor_OLS = sm.OLS(endog = y, exog=X_opt).fit()
regressor_OLS.summary() 
















