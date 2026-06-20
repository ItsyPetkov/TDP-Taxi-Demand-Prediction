# TDPNYC: Taxi Demand Prediction for yellow-taxi cabs in New York City. 

## Project background and Overview

The New York City Taxi and Limousine Commission (TLC), established in 1971, is a government agency that regulates and licenses the taxi and for-hire transportation industry of the city.

This government agency produces significant amounts of yearly data on its trip origins and destinations, travel times, distances, passenger counts, fare structures, payment methods, and tipping behaviour that has previously been underutilised. This project thoroughly analyses and synthesises this data in order to discover critical insights that will improve the ability of TLC to model and subsequently predict the demand for their services throughout NYC.

**Project goal**: Given taxi ride data in Manhattan, develop a prediction model to forecast demand (Low, Medium or High) for taxi rides in specific regions of interest (Lower Manhattan, Midtown, Upper West Side, Upper East Side, LaGuardia Airport and JFK Airport) throughout the city. 

<img width="475" height="356" alt="image" src="https://github.com/user-attachments/assets/88df8a27-def7-4827-a103-483ac45e38be" />

This project can be divided into the following workflow stages:

* **Data Importing and Preprocessing**: Combined monthly taxi trip datasets and implemented custom taxi zone segmentation functions to map trips into predefined service regions.
* **Exploratory Analysis and Data Cleaning**: Visualised and explored both continuous and discrete distributions to detect erroneous data, extreme outliers and class imbalance. Subsequently, a data cleaning algorithm was implemented based on the outcome of the EDA to ensure that the predictive models are only trained using reasonable trips.
* **Feature Engineering, Evaluation and Selection**: Obtained a feature set for training, optimising and testing machine learning models. Additionally, features were evaluated using visualisations and filter methods and selected or filtered out based on their importance.
* **Data Modelling, Predictive Analysis and Model Comparison**: i) Developed a baseline model that emphasises overall accuracy; ii) Applied feature selection, sensitivity analysis and hyper-parameter optimisation to discover the best settings for the machine learning task; iii) Conducted an ablation study using multiple models to deduce which model performs best for the task based on confusion matrix outputs; and iv) Used train-test split to accurately train and evaluate model performance.  
* **Result Reporting and Sharing**: A report has been produced to communicate model-driven insights and actionable recommendations to non-technical audiences.

A static but detailed report can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main).

An Exploratory Data Analysis script can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files).  

A Data Cleaning script can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files/Cleaning%20Functions).

Feature Engineering and Selection scripts can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main).

Machine Learning models (only baseline and best) can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files/Training%20Functions).

Evaluation functions can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files/Evaluation%20Functions).

Additional feature functions can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files/Feature%20Functions).

Individual metrics can be found [here](https://github.com/ItsyPetkov/TDP-Taxi-Demand-Prediction/tree/main/Code%20Files/Metrics%20Functions).

## Data Structure Overview

The primary data set for this project is a record of yellow taxi trips in New York City in 2015.  The data is collected by the NYC Taxi and Limousine Commission electronically through the Taxicab Passenger Enhancement Program (TPEP).  The data is made publicly available at [https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page).

The Taxi Data folder contains twelve csv-files, one for each month of the year. The data files provided are only 2% of the total data available, sampled at random. The full dataset for the year is over 20 GB.  Since processing this amount of data requires a significant amount of time and computational resources, the standard procedure of using a smaller sample, representative of the entire dataset is employed. 

Below is a table that lists the original variable names in the csv-files, the variable names used in this course when loaded into MATLAB, the data types, and descriptions of the variables.  This is adapted from the website linked above and is referred to as the data dictionary.  

| **Original Name** | **New Name** | **Data Type** | **Description** |
|-------------------|--------------|---------------|-----------------|
| VendorID          | Vendor       | categorical   | A code indicating the TPEP provider that provided the record: 1= Creative Mobile Technologies, LLC 2= VeriFone Inc. |
| tpep_pickup_datetime | PickupTime | datetime     | Start time of taxi trip |
| tpep_dropoff_datetime | DropoffTime | datetime   | End time of taxi trip |
| passenger_count | Passengers | double | Number of passengers during trip |
| trip_distance | Distance | double | Distance of trip (in miles) |
| pickup_longitude | PickupLon | double | Longitude of pickup location |
| pickup_latitude | PickupLat | double | Latitude of pickup location |
| RateCodeID | RateCode | categorical | The final rate code in effect at the end of the trip: 1= Standard rate 2=JFK 3=Newark 4=Nassau or Westchester 5=Negotiated fare 6=Group ride |
| store_and_fwd_flag | HeldFlag | categorical | Y/N flag that indicates if trip data was transmitted immediately or transmitted later |
| dropoff_longitude | DropoffLon | double | Longitude of drop off location |
| dropoff_latitude | DropoffLat | double | Latitude of drop off location |
| payment_type | PayType | categorical | A numeric code signifying how the passenger paid for the trip: 1= Credit card 2= Cash 3= No charge 4= Dispute 5= Unknown 6= Voided trip |
| fare_amount | Fare | double | Time and distance fare calculated by the meter |
| extra | ExtraCharge | double | Extra surcharges | 
| mta_tax | Tax | double | MTA tax |
| tip_amount | Tip | double | Tip amount for credit card purchases (cash tips are not included) |
| tolls_amount | Tolls | double | Tolls paid on the trip |
| improvement_surcharge | ImpSurcharge | double | Improvement surcharge |
| total_amount | TotalCharge | double | Total charge to customers (excluding cash tips) |

## Results and Evaluation Overview

The modelling of the data and the subsequent predictions were a part of the classification problem described above, and different models were tried using the 
Classification Learner App. Through trial and error, it was found that the Wide Neural Network model was the most appropriate, with an overall accuracy of around 76%. Two scenarios were considered: one to maximise overall accuracy (Scenario 1) and another to modify the cost matrix to minimise the misclassification of low 
demand, explore the effect of feature selection and hyper-parameter optimisation (Scenario 2).  In reality, both scenarios did not perform to the same degree, the first introduced significant overfitting, which was rectified in the second scenario, leading to an improved ability to generalise to unseen data.

### Scenario 1 - Baseline model

The baseline model used in this scenario is the Random Forest Classifier (Bagging Ensamble Method) in order to establish a general sense of model accuracy and feature importance for the machine learning algorithm described in Scenario 2. This particular model achieved an accuracy of 74.44% with K-fold validation (K=5) and no custom cost matrix.

<img width="970" height="409" alt="image" src="https://github.com/user-attachments/assets/1a4ae85b-0d6e-45bd-8e34-0df2e409f2aa" />

<img width="2651" height="1008" alt="image" src="https://github.com/user-attachments/assets/8a94a204-b88d-416a-ace8-6feac0634963" />

In the images directly above, the model on the left is the baseline validated on training data, and the one on the right is the same model evaluated on test data.

**Key findings**:
* Several alternative approaches were discarded. Linear models (such as Multiclass Logistic Regression) consistently showed poor performance (accuracy below 70%), confirming that the relationships between the predictors and the response variable Demand are inherently nonlinear.
* Categorical features offered little contribution to the final outcome, indicating that the prediction process is mainly governed by continuous data.
* The baseline model is prone to overfitting as suggested by the large discrepancy in accuracy scores between train and test data evaluations.

### Scenario 2 - Machine learning model ablation study 

In this scenario, all of the machine learning models available in the Classification Learner App were applied to the prediction problem highlighted above and subsequently evaluated. A sensitivity analysis is conducted on the model with the highest accuracy to explore the effect of applying cost penalties for missclassifying different classes associated with the response variable.

<img width="970" height="409" alt="image" src="https://github.com/user-attachments/assets/67a92a7a-b0e6-4557-87ab-3195c9a5ed07" />

<img width="2651" height="1008" alt="image" src="https://github.com/user-attachments/assets/6d4f9e24-35da-4647-948a-8f833021e8aa" />

In the images directly above, the model on the left is the best approach validated on training data, and the one on the right is the same model evaluated on test data.

**Key findings**:
* Applying an extreme cost penalty (such as 100) caused a severe and unacceptable reduction in overall accuracy.
* Falsely identifying High demand or Medium demand regions as Low demand is not as much of an issue, hence the penalty is set to 5 instead of 1. This modified model achieved a lower accuracy of 66.6%. However, it significantly reduced the false negative counts for the Low class from 31.8% to 15%.
* Hyperparameter optimisation failed to produce any meaningful improvement, with the model achieving only slight fluctuations (less than 1% difference) in terms of accuracy.
