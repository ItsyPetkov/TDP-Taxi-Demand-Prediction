# TDPNYC: Taxi Demand Prediction for yellow-taxi cabs in New York City. 

## Project background and Overview

The New York City Taxi and Limousine Commission (TLC), established in 1971, is a government agency that regulates and licenses the taxi and for-hire transportation industry of the city.

This government agency produces significant amounts of yearly data on its trip origins and destinations, travel times, distances, passenger counts, fare structures, payment methods, and tipping behaviour that has previously been underutilised. This project thoroughly analyses and synthesises this data in order to discover critical insights that will improve the ability of TLC to model and subsequently predict the demand for their services throughout NYC.

Model-driven insights and actionable recommendations have been provided across the following key areas:

* **Data Importing and Preprocessing**: Combined monthly taxi trip datasets and implemented custom taxi zone segmentation functions to map trips into predefined service regions.
* **Exploratory Analysis and Data Cleaning**: Visualised and explored both continuous and discrete distributions to detect erroneous data, extreme outliers and class imbalance. Subsequently, a data cleaning algorithm was implemented to ensure that the predictive models are only trained using reasonable trips.
