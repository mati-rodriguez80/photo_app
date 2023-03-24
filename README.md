# Photo App

This web application was built while doing "The Complete Ruby on Rails Developer Course" on Udemy. Users can share their images, photos, etc. after signing up to the app and making a unique payment for one of the two plans available.

The goal with this app was to learn some of the next topics which are different from previous apps:

* Use and customize Devise in order to ensure that when a user signs up, their email address is verified
* Extend a Devise controller to add the ability to accept payments when the user signs up
* Built a custom payment functionality using Stripe so users can only sign up if they pay an amount of money
* Use JavaScript for some of the features of the app both adding a js file in the javascript folder and within script elements
* Add image upload functionality using CarrierWave and MiniMagick

## Clone Repository

If you are going to clone this repository, remember to execute these steps before you run the app locally:

* yarn add bootstrap@4.6.1 jquery popper.js
* bundle install
* rails db:migrate
* ImageMagick or GraphicsMagick command-line tool has to be installed

### General Information

* Ruby version: 2.7.5
* Rails version: 6.1.7
* Bootstrap version: 4.6.1
* Status: Completed
