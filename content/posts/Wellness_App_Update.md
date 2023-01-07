Title: Wellness App Update
Author: Jack DesCombes
Date: 2022-04-18

Over the past 3 weeks, I’ve really focused in on my wellness app project, consistently adding features bit by bit. I started out by using the Oura API to output my sleep metrics into a page with radio selectors to track my energy levels, mood, and focus on a given day. 

From there, I implemented a calendar page using fullcalendar. It was a bit arduous implementing date-click functionality, whereby a user can click on any date on the calendar page and be redirected to the individual day’s page. The reason I initially struggled here is largely due to the fact that fullcalendar boilerplate is in javascript, so changing a calendar’s functionality requires a bit of tinkering in javascript. In order to send the clicked date string to the back end, I learned how to use ajax to send a post request for use as a python variable.

After improving the calendar to my liking, I’ve added a workout module to my tracker to log the intensity of workouts/soreness level, upload my workouts and take notes on them each time I work out. For my weightlifting workouts, I keep track of my progress in google sheets in a template with 4 different workouts that I cycle through. I am currently working on implementing a feature that will automatically upload the workout from google sheets into my app when I select weightlifting as my workout for the day. To do so, I’ve been working with the Google Sheets API to extract the data given whichever workout is next in the template. 

I’ve really enjoyed working in depth on this project, where I am continually adapting to new challenges. To highlight, I’ve made big strides in the following areas:

•	Working with databases (SQLite--to be transferred to MySQL or Postrgres)<br />
•	Using API’s (Google Sheets, Oura) <br />
•	Improved ability to work within the contexts of web requests w/ Flask <br />
•	Some Javascript—using jquery/AJAX to send post requests to front end <br />
•	Managing a project’s growing complexity<br />
•	Unit-testing in pytest  <br />
•	Experience working with the wide array of Python standard and non-standard libraries  <br />
•	Project management with Git  <br />
•	Debugging practice  <br />

**Project To-Do’s:**

•	Finish Google Sheets workout upload functionality  <br />
•	Add forward and back buttons for each day  <br />
•	Amend workout data functionality from app—changes carried over to google sheets  <br />
•	Tags for each day and an insights page to show averages for days with a certain tag, etc..  <br />
•	Add/edit calendar events manually  <br />
•	Improve testing suite  <br />
•	Refactor code   <br />
•	Deploy with Ansibel  <br />
