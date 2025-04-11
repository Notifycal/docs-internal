---
title: Agreed design
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

- check into private.notifycal.com
- login with some Notifycal google account where there has been some usage.
- go through onboarding process
- fill last step where the user is presented with a "Send sample reminder" button and a message saying "Here is the sort of message your clients will receive".
- click on send reminder and wait for wow-moment.
- display feature pages and payment plans - presumably static-landing.
- discuss and persuade! If positive reaction we can help them out with real onboarding on their devices.
- [for looping over] navigate into private area / "user preferences" and click on "Cnfigure reminders"

### Implementation:

- frontend. Send sample reminder step.
- backend. Some endpoint that queues an event on lambda 3.
- "Configure reminder" so we can loop over

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

Same as face-to-face demo without needing to loop over as the client will be doing it on its own device and won;t have to reconfigure the reminder.

No message sending cap until Payment integration is done.
