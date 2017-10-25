# README

Your Client is a French Coworking space that rents workstations to freelancers. When someone is accepted into the coworking space, he signs a contract that is renewed automatically every month. Because of the high demand, the Client needs to put in place a waiting list in order to keep track of people wanting to join the coworking.
The main features that the Client has specified:
* A public accessible form to collect incoming requests (name, email, phone number, a brief biography about the freelancer). Each field must be validated in order to have data as accurate as possible.
* Email addresses must be confirmed (requests with emails that have not been confirmed should not be taken into account by the waiting list).
* The requests will be accepted on a first-come, first served principle
* The requests in the waiting list must be reconfirmed every 3 months: an email should be sent to the people in the waiting list, informing them of their order in the waiting list and asking for confirmation that they are still interested, otherwise their request will be removed from the waiting list (aka expired).
For the scope of this test, an administration interface is not required. However, you need to provide methods that the Client could use in rails console :
* request.accept! - method that will allow accepting a request (request being an instance of the class Request)
* list the requests by their status using class methods or scopes
 ** Request.unconfirmed - requests for which the email address has not been confirmed
** Request.confirmed - requests in the waiting list
** Request.accepted - requests that have been accepted by the client
** Request.expired - requests that have not been reconfirmed
The app should be hosted on a free Heroku hosting plan.


https://claire-waitlist.herokuapp.com/
