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
  * TabBarController(ONE, TWO, THREE):
    * SearchByCountyViewController(Initial)(ONE):
      1. SearchByCountyView(1): send County to ResultListView
      2. ResultListView(2): ViewCell(Photo, Name, HourRate, Review), Request_Button
      3. CleaningPersonProfileView(3): Photo, Name, HourRate, Review, Request_Button, Introduction
      4. Request_Button -> ReqeustAlertAction: "Request for info and your contact info will be sent to CleaningPerson.Name if CleaningPerson.Name agree to your Request"
          -> OK-> Request_for_contact_info_flow and screen goTo CustomerRequestTableView(4)
          -> Cancel -> go backTo CleaningPersonProfileView(3)
    * CustomerRequestViewController(TWO):
      1. CustomerRequestTableView(4): In cell
        * Cell:
            * Photo, Name, HourRate
            * StateOfRequest: switch(AuthorizationFromCP: Bool)
              -> True: "Request Sent, Wait for Response"
              -> False: "Contact Info Received, Contact Cell.Name" + PhoneIcon
        * Tap Cell/PhoneIcon -> CleaningPersonCellDetailView(5)

      2. CleaningPersonCellDetailView(5):
        * CleaningPerson.Photo, .Name, .HourRate, .Introduction, .Reviews
        * Switch(Authorization: Bool):
          * True:  CleaningPerson.ContactMethod shown bottom, while ReviewCP button on rightBarButton and the bottom of view( tapped -> ReviewView(6)
          * False: N/A, a backTo(4)BarButton

      3. ReviewView(6):
        * BarTitle: Review CleaningPerson.Name
        * CancelBarButton
        * SubmitBarButton
        * View:
          * Star Rating
          * Description of service
    * CustomerSettingViewController(THREE):
      * FunctionTableView(7):
         * HelpCell: DetailView(8)
         * FlaggedContent: DetailView(8)
         * Profile & Contact Info: CustomerProfileEditView(9)
         * Log Out
      * DetailView(8):
         * From Help Cell: show tutorial ?
         * FromFlaggedContetn: show FlaggedContent?
      * CustomerProfileEditView(9):
         * Photo: -> ImagePickerController
         * View and Edit Name, County, ContactMethod(Phone -> PhoneVerification, Email),AvailableTimeToContact
         * UpdateButton -> Refresh the ProfileEditView(9)
         * BackBarButton -> FunctionTableView(7)

* CleaningPersonSide:
  * TabBarController(ONE-1, TWO-1, THREE-1)
    * ProfileViewController(ONE-1):
      1. PreviewView(10):
        * View Photo, Name, County, ContactMethod, AvailableTimeToContact
        * Edit/UpdateButton -> CPProfileEditView(11)
      2. CPProfileEditView(11):
        * Edit .........
        * UpdateButton -> PreviewView(10)
        * CancelBarButton -> FunctionTableView(10)
    * RequestViewController(TWO-1):
      * RequestTableView(12):
        * Cell:
            * Customer.Photo, .Name
            * StateOfRequest: switch(Authorized: Bool)
              -> True: "Contact \(Customer.name) to provide your service"
              -> False: "\(Customer.name) sent a request for your contact!" + ReplyButton(tapped goto CustomerProfileView(13) )
            * TapCell -> CustomerProfileView(13) sent with StateOfRequest
      * CustomerProfileView(13):
        * Customer.Name, .Photo
        * Switch(StateOfRequest)
           * True: show Customer.Email, .Phone
           * False: ReplyButton shown(Tapped -> CustomerProfileView update )

    * SettingViewController(THREE-1):
      * FunctionTableView(13):
        * Help:
        * FlaggedContent:  -> some View
        * Log Out

* Request for contact info flow:
  1. Customer sent a Request for contact info to CleaningPerson
  2. CleaningPerson.RequestViewController received Request, push notification
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
