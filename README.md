# INFO 201 BE6
Project Proposal
INFO 201 BE	 Group BE6
Group Members: Cheng Gong, Yingrui Jia, Elizabeth Lin and Colton M Hagan

1 Project Description
1.1 Background and datasets

The major theme that this project will be exploring is social security in Seattle. There are two sets of data that our group will be working with, Fire Data and Crime Data. The first one is the collection of data from Fire 911 Last 24 Hours. This data is found in the Public Safety section of Seattle Open Data Portal. It provides us with 7 aspects of relevant information including address, type of fire call, date and time, Latitude, Longitude, report location and Incident number. The Crime Data represents crime reported to Seattle Police Department. This data is also found in Seattle Open Data Portal. The Crime Data consists of information regarding to Report Number, occured data, occured time, reported data, reported time, Crime Subcategory and Primary Offense Description. 

1.2 Target audience
This project focuses on people who are concerned about their safety in Seattle. It gives people a visualization of frequency that crimes occur differentiates in different neighborhoods in Seattle, especially for those who intend to avoid living in the district where crime happens frequently.
The questions that the project will answer for audiences are below:

	•	Based on the time of the day, can we detect what kind of fire call will be more prevalent?
	
	•	What is the common neighborhood/areas for crime in Seattle?
	
	•	What are the top common crimes in Seattle?
	
	•	What are the common times that crimes occur the most (range of time)?
	
	•	Yearly
	
	•	What season has what type of crimes the most/least?
	
	•	Amount of each type of crime each year?
	
	•	Visualization of Maps of Fire Calls



2 Technical Description

2.1 Format of product 

The format of our final product will be an HTML page with visuals and a detailed description of our analysis with our dataset. We will use simple HTML and CSS to present our graphs (as pictures) and include text that guides the audience to relevant information and explain our methodology in parsing and presenting the data.
2.2 Methods of reading data
We will be reading in our data in a static “.csv” file downloaded from the City of Seattle dataset website.
2.3 Types of data-wrangling
Our data wrangling will involve reformatting the gathered data by filtering out the data we will not be using to reduce the size of the data. We will also further reduce the size of the bulk data by only selecting relevant columns.  
2.4 Major libraries 
The major libraries that we will be using to program our project are “ggplot2” for the graphing elements, “tidyr” to make it easier to work with the data, and “mapproj” to help manipulate the map size.
2.5 Statistical analysis or machine learning
We are not planning to use either statistical analysis or machine learning in our project.
2.6 Challenges 
There are several major challenges that we will be facing. The first will be manipulating the data to get it into a format that is both easy to transform into our charts and maps, and also doesn’t carry unnecessary bulk. The biggest challenge will be making our charts and graphs interactive. We will need to be able to have the user change the year, be able to hover over a data grouping to see the statistics from it, and be able to change what data is shown in the charts.
