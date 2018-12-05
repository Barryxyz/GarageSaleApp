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

Final Project Documentation

Platform Justification - What are the benefits to the platform you chose?
We ultimately decided to build an iOS app using Swift and xCode due to a number of reasons.  One of them was our enjoyment of using xCode and Swift when building our iOS mini app.  Both of us found the Storyboard a much more intuitive way to understand the views of our app and how they all relate, and we also found that making layouts on xCode was a far more enjoyable process when compared to Android Studio and its XML layouts.   Another major reason that played a factor is convenience; both of us had apple computers so making the switch to building an iOS app made sense for us.  However, the biggest benefits were definitely how much easier and comfortable it was for us to make layouts.  Ultimately, there are a lot of similarities programmatically between iOS and android, so it came down to some of the smaller details.  

Major Features/Screens - Include short descriptions of each (at least 3 of these)

Our app can really be summarized into having 5 major features:

User login/signup/logout features
We tried to make the login, signup, and logout process for the user as smooth as possible, and did a lot of testing in ensuring that logging in, signing up, and logging out all worked as intended, in terms of providing relevant error messages and also in terms of authenticating users properly.

Item Map Screen
The Item map screen has a lot of features within that should be noted.  First is that the user is first brought to their current location, where they can view the items that are on sale around them.  If they want, they can also move to a different location, and again, to make this simpler for the user, we added autocomplete (via google’s places API) so the user doesn’t have to type in a full address to search for it.  Different items are placed with markers depending on category (question mark for “Other”, clothes sign for “clothes”, couch sign for “furniture”, and books sign for “school”).  Annotations are also available providing more item details, when the item is clicked on.

Item List Screen
The item list screen shows all the items that are available to the user in a clean list format, with the item name, price, and image showing up first in each cell.  When clicking on a particular item, the user is brought to an item information view which shows all the item details they need, along with the ability to contact the seller directly, via a variety of different methods (e.g. text message or call).  The user can also filter using the segmented control the category of item that they want to scroll through.

Sell Item Screen/s
The Sell item process is broken into chunks since we thought it would have been overwhelming if the user were to have to go through the whole process at once.  First, the user enters basic item details (such as price, name, etc.), second, they are told to attach an image for their item, and last, a location. After clicking on post, the item will be added to the list and map accordingly.

My Profile Screen
The user can manage all their information here, and save the changes they make and log out as well.  Another important feature here is that the user can also see the items that they have posted.  When swiping these items (right to left), they are prompted with edit and delete options. When clicking on edit, the user can edit their item and save the changes they make to each individual item from the edit item view.  When deleting the item, the item is removed from the item list and the user’s own list.

Optional Features - Include specific directions on how to test/demo each feature and declare the exact set that adds up to ~60 pts
15 pts - GPS / Location-awareness (includes using Google or Apple Maps) 
- The item map screen displays the user’s current location, and uses this to show items (if any) that are on sale that are near them.  The app also allows users to search a desired location and see items in those areas as well.  Annotations are placed to mark out where each item is relative to the user so the user can better visualize how far these items are from them.
15 pts - Camera 
- The app allows users to either take a picture or take a picture from their camera roll to display for their item.  This image is used in the item list and item information pages to show the user what that item looks like.  The images are saved into Firebase Storage upon creation, and loaded to the item list and information pages as needed using the image’s download URL which are saved in Firebase Database for each item.  
15 pts - Build and consume your own web service using a third-party platform (i.e Firebase) 
-  We used firebase extensively for this app.  We first used firebase to handle authentication for our app.  Login, signup, and logout all handle users for our app.  We also used the firebase real time database for our items and users.  This information was retrieved for the My Profile, Item Map, and Item List tabs.  When a user added an item to sell, this was added to the maps and lists accordingly.   Similarly, when an item was deleted or edited by a user, all these changes were tracked in firebase database.  We also use firebase storage to handle how we stored images, and this was used to save/load the images for our items.
10 pts - Consume a pre-built web service 
- Google Maps offers a very powerful Places API, a ready-made web service which allowed us to give the user the ability to autocomplete their searches on the Item Map tab.  This is especially useful as we know most users would not want to type in a whole address, and doing so also leads to a greater chance for a typing error and also greater frustration for the user.  The autocomplete API we utilized allowed us to suggest addresses based on what the user entered, which we found to be a very powerful addition to our app.
5 pts - Open shared activity / features (i.e. Create an email to send, share with a text message, etc.) 
- In order to contact the seller, when an item is clicked on from the item list page, the user has a couple options, among them the ability to message the seller of their interest via text message or call, along with email.  The seller’s preferred contact method is listed so the user knows the best way to reach him/her.  All three of these open shared activity/features between the buyer and seller.

Testing Methodologies - What did you do to test the app?
	To test the app, we did a number of things.  The first thing is that we put print statements throughout our code, validating the data that we expected to receive in order to ensure our app was doing what we intended for it.  Another crucial part of our testing was anticipating any potential errors the user would potentially run into (e.g. entering passwords that do not match during signup).  We wanted to test our app to anticipate all these different scenarios and respond to them accordingly. Another important part of our testing, especially since Firebase was such a large component of our app, was ensuring that everything in the Firebase database was being updated accordingly.  This meant that we would constantly have the Firebase console open as we made changes, making sure that when changes are being made, these are being reflected in firebase as expected.  Lastly, we went through what we viewed as typical user experiences of our app.  This went from logging in to signing up to forgetting passwords, to entering the app, viewing items, buying items, and being able to manage their own settings/items in profile.  
  
Usage - Include any special info we need to run the app (username/passwords, etc.)

- As discussed in the proposal, we have designed our app for iPhone 8 on iOS.  For best user experience and design, please use the iPhone 8 simulator or an actual iPhone 8.  
- the formal xCode project for our application is within the directory "FinalProjectiOS". From the git clone of this project, please cd into that directory in order to run the application.
- Depending on the size of the list, the initial loading of images from firebase may take a bit of time (possibly, at worst, a couple minutes, depending on how many images there are).  This is expected.  Since we are caching the images, loading images after this initial load, however, is very quick.
- In order to start using the app, please sign up.  We have also provided a demo account with the following sign in credentials in case you wanted to test the app quickly and forgo the signup process.
 Username: cy4bv@virginia.edu
 Password: password
- Camera does not work well in simulator, as well as location since the simulator is defaulted in San Francisco, whereas most items we post are in the UVA area.  
- A good starting point to see items is to move to Jefferson Park Avenue, Charlottesville, VA, since the majority of our test items were placed around there.  

Lessons Learned - What did you learn about mobile development through this process?

Wireframing is an extremely good use of time when designing an app.  One thing that is unique about mobile app wireframing is better visualizing the screen by screen user flow.  When mapping this out in the storyboard when developing the app, this kind of wireframing is extremely valuable.  
Understand the design limitations of your platform.  For example, there were times when we spent hours figuring out why a navigation or tab bar item disappeared, and this was due to not designing our flow based on common design principles in iOS (for example, having the initial controller for each tab bar item be a navigation controller, and only then, will the view controllers following have the desired tab bar item).  Small things like this make a big difference to the user experience and can take a lot of time to figure out if one does not understand some of these design constraints.
Screen square footage matters significantly more when it comes to mobile development.  With the screen being much smaller, design decisions carry greater weight, since each decision takes up more space.  This is actually one of the reasons we decided to have a step-by-step sell item process instead of having it all on one view.





