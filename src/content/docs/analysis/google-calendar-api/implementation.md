This is going to be fun.

# Arquitecture

 - A lambda that calls Calendar watch after user pays and let us know what calendar they want us to integrate with and what message they want to sent to their customers. Somehow this will be fed by some event coming off a SNS/SQS (not sure at this time).
 - A lambda for Google to callback
 - A lambda to fetch events from Google Calendar API and store them when above lambda is invoked by Google. This can be probably the same as above. As Google gives a whistle we call Google and store the events in some persistance unit.
 - TBD. As we get the events and store them we have to determine if we need to send a reminder. This needs to be background processing because no notification is sent down the channel to indicate a reminder is being triggered. This makes me thing if it is really worthy the watch business... Compute time vs complexity

# Calendar/event data to store

Since the end goal here is to send notifications to people based on calendar events I believe we can stablish a 1 to N relationship (1 event N reminders) and focus on reminders.

[When brain isn't boiling I will put here my idea]

These are about all the data we are interested in:
## Calendar
```
etag - this changes as some event gets modified in the calendar.
updated - same as above
timeZone
defaultReminders
nextPageToken
nextSyncToken
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
etag - this changes as event gets modified.
created
updated
summary(optional)
description(optional)
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