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


### Decisions in favour of ticking off requirements:

- using our own device/tablet where we have all set up minimizing the probability for surprises.
- switching tabs is ok because we know our stuff.
- a real event is created on calendar integration and an SMS needs to arrive to person being demoed.

### User experience:

- Ask potential customer for their phone number
- Open our demo Google Calendar and create an event for tomorrow with their phone number. Said event must start in between 23:30 and 24 hours (not included). We could even tweak the time window to avoid having to make calculations (even though it could just be, the exact same hour - 20 mins).
- Wait for the background process, maybe showing the customer the private area (private[env].notifycal.com).
- Reminder arrives to potential customer phone number. Maybe we can use this reminder to our advantage (link to site?).
- TADA!


### Implementation:

Drift from current/day-to-day implementation:

- Use a non-prod environment for this. Could be qa/non-prod or a bespoken demo env.
- Need to be able to trigger the background-processing on-demand. Could probably do it from the AWS console in the phone, with a custom event. Update: the fact that we're invoking the first lambda now from eventbridge might complicate this a bit.
- Might want to customize the time window to avoid doing any calculations in the spot.


## 2. A client self-demo/functionality show-off.

This "demo" is to convince clients to pay for Notifycal. They have gone through the onboarding process, given us their business info, and now it's time to send them an example message, so they're more likely to pay us in the next step.

### Requirements:

- Needs to keep the user in our page, so they don't lose focus. Probably this means no calendar integration as we don't want to request write access to their calendar.
- Needs to display our functionality to the best of our ability, so the user is "pressured" to pay (hey, this works!).


### User experience:

- User logs into Notifycal.
- User is shown the onboarding wizard.
- User provides the business/reminder details.
- User is shown a page with an explanation and a button: "Receive sample message".
- Upon click, the user receives a "fake"/test reminder on the number they've provided (with fake interpolated data).


### Implementation:

frontend:
- new step in the onboarding wizard that displays an explanation, a "Receive sample message" button and upon click calls a /test-reminder endpoint.

backend:
- new endpoint that posts a message in the 3rd lambda fanout/queue.
