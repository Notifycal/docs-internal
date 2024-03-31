---
title: Overview
description: Docs, links, and notes to work out how to create a stream of events from Google Calendar API
---

Google Calendar is a product that allows people to manage an agenda. The intention here is to create an stream of events/notifications to react to them and provide some sort of notification service that Google does not provide.

# Arquitecture

- An scheduled lambda that fetches active users' calendars and puts an event on a queue for each one of them
- An lambda that pops items from the queue fetches actionable events from Google Calendar API and works out if a reminder needs to be sent based on a fixed distance to the start time of the event.

# Implementation

Although Google Calendar has sort sort of on change notification API - the calendar watch endpoint - we have decided not to use it for now until there is a real need to cut down on costs. There is also a way of [syncronizing resources efficiently](https://developers.google.com/calendar/api/guides/sync) - which watch implementation approach relies on as well - we are not gonna use for now for the sake of getting something out quickly. At this point, we really think there are 3 factors that make it not worthy:

- low cost of compute time and the existance of a wide free tier.
- an avoidable way of needing some background processing - at least for a PoC.
- complexity

Therefore, we are gonna go with a simple implementation based on polling to [calendar events list](https://developers.google.com/calendar/api/v3/reference/events/list) passing some parameters that cut down the amount of data to fetch and, as a result, it provides actionable events without requiring any persistance unit.

Because of the nature of the reminder, i.e. urging somebody to attend some appointment, the schedule can be somehow relaxed and make the sliding window be something like 30 minutes or even 1h. It really doesn't make a difference to send a reminder 23h or 23.5h before the appointment. Note: Although we are gonna use this simplistic approach, chances are the number of result retrieved by this endpoint is larger than maxResults upper limit(2500). In this scenario, we need to iterate over `pageToken` as many times as required.

## Important Calendar/event data to act upon

Since the end goal here is to send notifications to people based on calendar events we can stablish a 1 to 1 relationship (1 calendar event 1 reminder). This decision is based on the design decision of using a fixed reminder time of 24h. It all really translates into is that 1 calendar N Notifycal events.

These are about all the data we are interested in:

## Calendar

```
timeZone
defaultReminders
items - see below section.
```

```json
{
  "kind": "calendar#events",
  "etag": etag,
  "summary": string,
  "description": string,
  "updated": datetime,
  "timeZone": string,
  "accessRole": string,
  "defaultReminders": [
    {
      "method": string,
      "minutes": integer
    }
  ],
  "nextPageToken": string,
  "nextSyncToken": string,
  "items": [
    events Resource
  ]
}
```

## Event

```
id
summary(optional - it depends how the phone number is obtained)
description(optional - it depends how the phone number is obtained)
start
recurrence
originalStartTime
atendees
reminders
```

extracted from below:

```json
{
  "kind": "calendar#event",
  "etag": etag,
  "id": string,
  "status": string,
  "htmlLink": string,
  "created": datetime,
  "updated": datetime,
  "summary": string,
  "description": string,
  "location": string,
  "colorId": string,
  "creator": {
    "id": string,
    "email": string,
    "displayName": string,
    "self": boolean
  },
  "organizer": {
    "id": string,
    "email": string,
    "displayName": string,
    "self": boolean
  },
  "start": {
    "date": date,
    "dateTime": datetime,
    "timeZone": string
  },
  "end": {
    "date": date,
    "dateTime": datetime,
    "timeZone": string
  },
  "endTimeUnspecified": boolean,
  "recurrence": [
    string
  ],
  "recurringEventId": string,
  "originalStartTime": {
    "date": date,
    "dateTime": datetime,
    "timeZone": string
  },
  "transparency": string,
  "visibility": string,
  "iCalUID": string,
  "sequence": integer,
  "attendees": [
    {
      "id": string,
      "email": string,
      "displayName": string,
      "organizer": boolean,
      "self": boolean,
      "resource": boolean,
      "optional": boolean,
      "responseStatus": string,
      "comment": string,
      "additionalGuests": integer
    }
  ],
  "attendeesOmitted": boolean,
  "extendedProperties": {
    "private": {
      (key): string
    },
    "shared": {
      (key): string
    }
  },
  "hangoutLink": string,
  "conferenceData": {
    "createRequest": {
      "requestId": string,
      "conferenceSolutionKey": {
        "type": string
      },
      "status": {
        "statusCode": string
      }
    },
    "entryPoints": [
      {
        "entryPointType": string,
        "uri": string,
        "label": string,
        "pin": string,
        "accessCode": string,
        "meetingCode": string,
        "passcode": string,
        "password": string
      }
    ],
    "conferenceSolution": {
      "key": {
        "type": string
      },
      "name": string,
      "iconUri": string
    },
    "conferenceId": string,
    "signature": string,
    "notes": string,
  },
  "gadget": {
    "type": string,
    "title": string,
    "link": string,
    "iconLink": string,
    "width": integer,
    "height": integer,
    "display": string,
    "preferences": {
      (key): string
    }
  },
  "anyoneCanAddSelf": boolean,
  "guestsCanInviteOthers": boolean,
  "guestsCanModify": boolean,
  "guestsCanSeeOtherGuests": boolean,
  "privateCopy": boolean,
  "locked": boolean,
  "reminders": {
    "useDefault": boolean,
    "overrides": [
      {
        "method": string,
        "minutes": integer
      }
    ]
  },
  "source": {
    "url": string,
    "title": string
  },
  "workingLocationProperties": {
    "type": string,
    "homeOffice": (value),
    "customLocation": {
      "label": string
    },
    "officeLocation": {
      "buildingId": string,
      "floorId": string,
      "floorSectionId": string,
      "deskId": string,
      "label": string
    }
  },
  "outOfOfficeProperties": {
    "autoDeclineMode": string,
    "declineMessage": string
  },
  "focusTimeProperties": {
    "autoDeclineMode": string,
    "declineMessage": string,
    "chatStatus": string
  },
  "attachments": [
    {
      "fileUrl": string,
      "title": string,
      "mimeType": string,
      "iconLink": string,
      "fileId": string
    }
  ],
  "eventType": string
}
```
