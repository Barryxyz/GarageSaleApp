# final-project-final-ios-chinyeung

Barry Chin (bxc2gn) and Christopher Yeung (cy4bv)

Special Instructions to Run Mobile Application

NOTE: the formal xCode project for our application is within the directory "FinalProjectiOS".  From the git clone of this project, please cd into that directory in order to run the application.  

Final Project Milestone Summary 

We wanted to summarize our progress as it relates to the following milestone checkpoints

The app loads and there is an obvious starting screen:

- Our app's landing screen is a user sign in screen, where the user can log in (if they have an account already), sign up (if they don't have an account yet), or retrieve their password if they have forgotten their password.  All authentication has been tested and is working as expected (authentication is done via Firebase).  Once the user signs in, there are a number of tabs in the tab controller.  Going to "My Profile" shows user data, and is also where the user can log out of the app.
  
There is solid evidence of progress towards at least one major feature:

- We have developed a couple of major features here, including user login, user signup, and good progress towards the user profile page (where the user also handles log out).  Thus, handling different users and that authentication process is handled properly by our application as of the milestone.
   
There is solid evidence of progress toward at least two optional features.

-  In terms of optional features, the two we focused on for our milestone revolve around using firebase and location.  We are using firebase as a third party service for authentication and database management for our mobile app.  This is how we are handling user authentication right now.  We are also storing user data in the database using the user's UID, and this will be used for displaying user data on the "My Profile" page.  We are also developing location using the user's location on our "Item Map" tab along with adding items, which will show up on the list.  Right now, we have captured the user location and plan to show the items near them on the map.  We have run into some hurdles in reading and writing this data onto Firebase, but once that is working, we can begin to display these items in the "Item List" and "Item Map" tabs.  This is contingent on getting "Add Item" working first, which is what we are working on currently, along with the camera feature for taking images of items.  Overall, significant progress has been made with using firebase, and progress is being made towards using user location in the "Item map" tab, though this is all contingent on reading and writing these items from "Add Item" to the database properly.


