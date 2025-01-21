# GoodCabs - Performance Analysis & SQL Insights

<b>Live Dashboard Link: [Power Bi Link](https://app.powerbi.com/view?r=eyJrIjoiNjgwY2RkZGQtOGY4Ni00MDZkLTgzMzctNWQ2ZmEyNDM4MmZkIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9&pageName=ReportSection152489641e004e0b39e5)</b>

##
The objective of this analysis is to evaluate Goodcabs' performance across critical metrics such as trip volume, passenger satisfaction, repeat passenger rate, trip distribution, and the balance of new vs. repeat passengers. This will help identify actionable insights to support the 2024 growth and service enhancement goals. 

## Datasets

- dim_city: Contains city details like ID and name.
- dim_date: Provides time-based information, including date, year, month, and quarter.
- dim_repeat_trip_distribution: Represents the frequency of repeat rides taken by customers.
- fact_passenger_summary: Aggregates key passenger metrics such as ride count, total spend, and average ride details.
- fact_trips: Tracks individual trip data, including city, passenger, location, distance, duration, fare, and trip type.
- monthly_target_trips: Specifies monthly targets for the number of trips to be completed.
- monthly_target_new_passenger: Sets monthly targets for acquiring new passengers.
- city_target_passenger_rating: Defines target and actual passenger ratings for each city.

I modeled the data using a Snowflake Schema and gathered additional information about City Type

<center>
  <h3>Here's the Data Model</h3>
</center>


![image](https://github.com/user-attachments/assets/3c42afae-086c-48fe-88d4-b17a3ac8f8ba)


## Dashboard Overview
<b>Home Page</b> - Upon their first login, users will be directed to this page, from which they can navigate to various other sections


![image](https://github.com/user-attachments/assets/b080dd27-478d-4577-b009-da9c79cdc0a4)


<b>Overview Page</b> - Shows key metrics like total trips, fare, and new passenger acquisition for 2024, along with city ratings, month-on-month revenue growth, and the best/worst performing months

![image](https://github.com/user-attachments/assets/92f9ae79-eb71-45e8-a45a-362be4384830)

![image](https://github.com/user-attachments/assets/345b5ef3-1792-4902-b60c-7e0b4447b76c)

<b>Trip Report Page</b> - Displays key trip metrics such as min/max trip distance, average fare per trip, and trip distribution by city type

![image](https://github.com/user-attachments/assets/8baa1159-7459-43b3-bc31-5381c375d8d6)

<b>Passenger Report</b> - Displays key metrics like total passengers, repeat passengers, repeat passenger rate, and actual vs. target new passengers

![image](https://github.com/user-attachments/assets/8033adb3-b3d0-4b52-872d-b54f6c18cb30)


## Business Questions
Business questions and ad hoc requests were addressed, with answers available in the 'goodcabs_ad-hoc.pdf' and 'goodcabs_report.pdf'

## Insights

- Jaipur, accounting for 18% of total trips, is the best-performing city, while Mysore, with only 4% of total trips, is the worst-performing city in terms of trip volume
- The average fare per kilometer is 25% higher (₹10) in tourism-focused cities compared to business-focused cities
- The passenger rating is 1.3 points lower for repeat passengers
- June is the worst-performing month, while April is the best-performing month in terms of total trips
- Tourism-focused cities have a 6% higher proportion of weekend trips
- Business-focused cities have a higher number of passengers taking repeat trips
- Business-focused cities are meeting their targets in terms of new passengers, while tourism-focused cities are performing well in terms of ratings and trips
- June is the only month where the Repeat Passenger Rate (RPR) decreased from the previous month, dropping by 3.5%

## Recommendations

- <b>Quality of Service</b>: Since GoodCabs employs local drivers, providing them with training and performance-based incentives (e.g., bonuses linked to customer ratings) can improve service quality and boost repeat passenger rates.
- <b>Socioeconomics and Pricing</b>: Offering bikes, cabs, and rickshaws in Tier 2 cities provides a range of options to meet the needs of the large middle-class population, offering flexible pricing and greater convenience, which can enhance customer satisfaction and drive repeat business.
- <b>Building Loyalty for Repeat Business</b>: Personalizing services, offering loyalty programs, and providing amenities like air-conditioning, easy booking, and in-vehicle chargers can improve customer satisfaction and drive higher repeat passenger rates.


## END






