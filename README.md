## Setup

In order for the **Check for new enquiries** button to work, you first need to create some sample enquiries. Do that by running this generator as many times as you want:

        $ rails generate enquiry amdirect

or:

        $ rails generate enquiry carsforsale

NOTE: Every time you parse new enquiries by pushing said button on the interface, those enquiries will get archived, which means if you click the button again there won't be any new enquiries to parse, thus you'll need to run the generator again.


## Area Motors Customer Enquiries

Area Motors is a used car dealership. They advertise their used cars on two websites (AMDirect and CarsForSale). Prospective customers complete a contact form on these websites to enquire about the vehicle they’re interested in and those websites send an email to Area Motors email account.

Area Motors has a few employees and they find it difficult to keep track of all these customer enquiry emails and the owner is concerned that customer enquiries are not being dealt with by his employees as quickly as he would like. The owner wants a tool to keep track of all these customer enquiries in one place so that he can keep an eye on things.

You will build an app for Area Motors that:

- Allow employees to click “check for new enquiries” which checks if there are any new enquiries available (note: sample email enquiries provided for parsing in /public).
- Parses the sample email enquiries into a standard and structured format which at a minimum includes the following:
  - Name
  - Email Address
  - Message
  - Source (e.g. AMDirect or CarsForSale)
- Allow employees to see these customer enquiries in the new standardised format so they can quickly see the relevant information.
- Allows an employee to mark the customer enquiry as “done” once they’ve dealt with the enquiry so it is not dealt with more than once.

Area Motors has asked if you could provide some of the following optional functionality, which is not required, but would be useful for them:

- Be able to search for a particular customer enquiry if they are looking for an enquiry from a specific customer.
- Mark a customer enquiry as “invalid” if it has an invalid email address so that his employees don’t waste time on customer enquiries they can’t contact.
- Introduce other “states” that a customer enquiry can be in other than “done” and “invalid” so that they can have a better idea of what needs to be done.

Please ensure the following:

- You use Git for revision control and regularly commit your work to show your thinking and your progress. Please clone (not fork) this repository to your Github account.
- Your work includes an adequate level of testing that would ensure Area Motors will have minimal bugs or issues.

### System Requirements

- Ruby 2.4.0
- Bundler 1.16.1
- PostgreSQL 10.1
