# TDPNYC: Taxi Demand Prediction for yellow-taxi cabs in New York City. 

## Project background and Overview

The New York City Taxi and Limousine Commission (TLC), established in 1971, is a government agency that regulates and licenses the taxi and for-hire transportation industry of the city.

This government agency produces significant amounts of yearly data on its trip origins and destinations, travel times, distances, passenger counts, fare structures, payment methods, and tipping behaviour that has previously been underutilised. This project thoroughly analyses and synthesises this data in order to discover critical insights that will improve the ability of TLC to model and subsequently predict the demand for their services throughout NYC.

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
