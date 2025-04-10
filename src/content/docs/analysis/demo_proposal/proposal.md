---
title: Demo Proposal
description: A page defining how to demo/show off Notifycal
---

Two type of demos cause we are doing face-to-face cold sells too and results rather difficult to fure them into one as actors and situations are very different. Therefore, in order to foster conversion rate we desire to be especific.

## 1. Face-to-face demo.

A face-to-face demo. This demo is meant to help sell promotors with selling the service.

### Requirements:
 - needs to happen in a 1-2 minute time span.
 - needs to be end-to-end, meaning, it needs to represent what notifycal does i.e. reading on some of your calendar and sending SMS to people to remind them about their appointments.
 - needs to minimize down to zero the error probabilities.[promotor on their own device]
Non-functional requirements:
 - avoid adding unnecessary scopes/permissions

### Decisions in favour of ticking off requirements:
 - using our own device/tablet where we have all set up minimizing the probability for surprises.
 - switching tabs is ok because we know our stuff.
 - a real event is created on calendar integration and an SMS needs to arrive to person being demoed.

### User experience:

 - check into private[sells?|qa?|prod?].notifycal.com where user can see good-looking stuff with the corner of their eye.
 - click on face-to-face demo. Button only present on this environment or rendered if certain feature-flag is enabled (consider permissions perspective). Perhaps this button could live on the dashboard where user has already logged in and has certain permissions based on who you are.
 - [depending on previous step] login with some Notifycal google account. 
 - ask for phone number of the person in front of you. (this number can be useful to chase them in the future)
 - create event by clicking on premade URL that takes you to Google Calendar so you only have to click on Save.
 - click on send reminder and wait for wow-moment.
 - display feature pages and payment plans - presumably static-landing.
 - discuss and persuade! If positive reaction we can help them out with real onboarding on their devices.

### Implementation:
 - frontend. Some other wizard accessible only by sell promotor or equivalent with a 3 steps: step1) it asks for phone number, and shows a "Create Event" button that takes you to Google Calendar to create the event. step2) shows reminder type step. Perhaps we can append promotional information to message step3) Displays "Send reminder" button.
 - backend. Some endpoint that queues an event on lambda 3. Only callable by sell promoter or equivalent. It could be an ActionableEventFound event or some other event type processable by lambda3. Identifying commercial events from bau events is a nice-to-have.
 - new environment?


## 2. A client self-demo. 

This demo is meant to convince notifycal.com visitors they should buy us.

### Requirements:
 - needs to happen in under 3 minute time span.
 - needs to show-off how easy configuring notifycal is. All real.
 - needs to be end-to-end, meaning, it needs to present what notifycal does i.e. reading on some of your calendar and sending SMS to people to remind them about their appointments.
Non-functional requirements:
 - avoid adding unnecessary scopes/permissions

### Decisions in favour of ticking off requirements:
 - using potential client device.
 - switching tabs is not ok because people are clumbsy/idiotic.
 - a real event is created on calendar integration and an SMS needs to arrive to person being demoed.

### User experience:

[Alternative 1 - no mock data]
 - check into private[prod].notifycal.com
 - click on Demo button that takes user to log in and onboarding wizard."Demo" is only a trap to get them relaxed thinking they aren't incurring charges(cause they are not).
 - Display "reminders to be send in the next 24h" component. Allow clicking in one and sending a reminder for it. SMS arrives to provided phone number. (who is the receiver here?)(what happens if they integrate with a calendar with no events? if so, switching tabs? adding write permissions does not feel right)
 - display feature pages and payment plans - billing page?. Allow them escape so they can still navigate around playing with app although app will look half-empty?

[Alternative 2 - using mock data]
 - check into private[prod].notifycal.com
 - click on Demo button that takes user to log in.
 - show private section with mock data.
 - Display "reminders to be send in the next 24h" component. Allow clicking in one and sending a reminder for it by proving a phone number, choosing reminder type. SMS arrives to provided phone number.
 - display feature pages and payment plans - billing page?. Allow them escape so they can still navigate around playing with app using mock data.

### Implementation:
[Alternative 1]
 - implement a way of *hard* limiting the number of messages to be sent on demo
 - frontend: "reminder to be sent in the next 24h" component
 - backend: endpoint that queues an event in lambda 3

[Alternative 2]
 - implement a way of *hard* limiting the number of messages to be sent on demo
 - frontend: "reminder to be sent in the next 24h" component
 - frontend: "fake APIs" based on query string or some flag setup when clicking on "Demo button".
 - backend: endpoint that queues an event in lambda 3
