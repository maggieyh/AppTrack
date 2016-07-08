## Table of Contents
  * [App Design](#app-design)
    * [Objective](#objective)
    * [Audience](#audience)
    * [Experience](#experience)
  * [Technical](#technical)
    * [Screens](#Screens)
    * [External services](#external-services)
    * [Views, View Controllers, and other Classes](#Views-View-Controllers-and-other-Classes)
  * [MVP Milestones](#mvp-milestones)
    * [Week 1](#week-1)
    * [Week 2](#week-2)
    * [Week 3](#week-3)
    * [Week 4](#week-4)
    * [Week 5](#week-5)
    * [Week 6](#week-6)

---
### Default Description about service:
  https://www.handy.com/cleaningchecklist

### App Design

#### Objective
[explain the goal of the app]
Immediately find a cleaning person with direct contacts and negotiable prices.
Be a part-time cleaning person and make extra money.
#### Audience
[who is this app targeting?]
Demand: Any person who needs a cheap and fast cleaning service, say: busy office employees
Supply: Anyone wants to be a part-time cleaning person , say: students
#### Experience
[how will your users interact with this app?]
* Users:
    * Demand:
        * As an office employee, I want a platform to find cleaning person and contact him or her directly so that I could have cleaning service during late night since I come home last.
        * As housewife, I want cheaper cleaning service so that I could save the money for the family.

   * Supply:
        * As a university student, I want to do some part-time cleaning person so that I could make more money than simply receiving lowest rate of salary as a clerk in convenience store.
        * As a high school student, I want to occasionally be a worker such as cleaning person so that I can make extra money myself with higher hour rate and rewarding job.
* Typical interaction on app:
   * Demand:
       * Setting up the account(including upload photo) and phone verification
       * Enter the app, set the county your house is in, see a result list of cleaning freelancers, send a request of contact info to the person you like, wait for the person respond your request, then contact each other on the platform you choose( such as FB, email, phone)
       * Receive the contact info, the app ask you whether you booked this person's service, then review ( stars ) to support this person.
   * Supply:
      * Setting up the account(including upload photo) and phone verification
      * Enter the app, set your profile(hour rate, location, description of oneself) and publish onto the platform, respond the request of info ie. give contact info to inquiring customer, then work for the customer
* Reference App:
   * 潔客幫
   * Maids App
[Back to top ^](#)

---

### Technical

#### Screens
* Registration:
  * Customer:
      1. Basic Info:
        * Email Registration: email, password, name -> save into User object / photo image picker
        * Facebook Registration:
          * Ask to Retrieve Email address, name, Photo, save into User object
      2. Phone verification: https://numverify.com/documentation
    //  3. Choose county you live in   

  * CleaningPerson:
      1. Basic Info:
        * Email Registration: email, password, name -> save into User object / photo image picker
        * Facebook Registration:
          * Ask to Retrieve Email address, name, Photo, save into User object
      2. HourRate
      3. Phone verification:
         * verify valid phone Number: https://numverify.com/documentation
      4. County in which CleaningPerson could provide his/her services

* Log In:
  0. LogIn with Last Account ??
  1. LogInView(1): choose kind of user, FB(2) or Email login
  2. FBLogin(2)

* CustomerSide:
  * SearchByCountyView(Initial)(1):
    1. SearchByCountyView(1)
    2. ResultListView(2): ViewCell(Photo, Name, HourRate, Review ), Request_Button
    3. CleaningPersonProfileView(3): Photo, Name, HourRate, Review, Request_Button
    4. Request_Button -> Request_for_contact_info_flow and CustomerRequestTableView(4)
  * CustomerRequestView(4):
    1. CustomerRequestTableView(4): In cell
      * Cell:
          * Photo, Name, HourRate
          * StateOfRequest: switch(AuthorizationFromCP: Bool)
            -> True: "Request Sent, Wait for Response"
            -> False: "Contact Info Received, Contact Cell.Name" + PhoneIcon
      * Tap Cell/PhoneIcon -> CleaningPersonCellDetailView(5)

    2. CleaningPersonCellDetailView(5):
      * Switch(Authorization: Bool):
        *

* CleaningPersonSide:


* Request for contact info flow:
  1. Customer sent a request for contact info to cleaning person with Customer's email, contact info , and go to the RequestView of Customer after sent
  2.
  3.
* Demand:
  * Search screen(Initial)
* Supply:

#### Data models
* [list all Parse data models your app will need]
* CleaningPerson Parse Class:
  * Name(String), Email(String), Phone(String), HourRate(Int), Photo(PFFile)
  *
* Customer


#### External services
* [list which APIs or external services will your app use?]
  * Chatroom & Online Message service APIs, i.e Message Feature:

  * Phone verification api ( just to verify one's identity)
  * Registration: ???
      * Facebook Registration


#### Views, View Controllers, and other Classes
* Font:
  *  ‎LL Brown font

* Views
  * [list all views you will need]
* View Controllers
  * [list all view controllers you will need]
* Other Classes
  * [list any other classes you will need]



#### Miscellaneous
* notification: push notification     https://www.raywenderlich.com/123862/push-notifications-tutorial

[Back to top ^](#)

---

### MVP Milestones
[The overall milestones of first usable build, core features, and polish are just suggestions, plan to finish earlier if possible. The last 20% of work tends to take about as much time as the first 80% so do not slack off on your milestones!]

#### Week 1
_planing your app_
* [goals for the week]

#### Week 2
_finishing a usable build_
* [goals for the week, should be finishing a usable app]

#### Week 3
* [goals for the week]

#### Week 4
* [goals for the week, should be finishing all core features]

#### Week 5
_starting the polish_
* [goals for the week]

#### Week 6
_submitting to the App Store_
* [goals for the week, should be finishing the polish -- demo day on Saturday!]

[Back to top ^](#)
