---
title: API response samples
description: API response samples
---

current (empty) calendar - first call to calendar/events:

```json
{
  "kind": "calendar#events",
  "etag": "\"p32oan0ltpa38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:10:43.438Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CLCrgr3KhoUDELCrgr3KhoUDGAUgnOOFpgIonOOFpgI=",
  "items": []
}
```

event created

```json
{
  "kind": "calendar#events",
  "etag": "\"p32sfjgfnpa38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:12:46.115Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CLj5wffKhoUDELj5wffKhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422132730590000\"",
      "id": "1vk76ch9q0e0b4v13ku0rklsnr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=MXZrNzZjaDlxMGUwYjR2MTNrdTBya2xzbnIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:12:45.000Z",
      "updated": "2024-03-22T00:12:45.295Z",
      "summary": "event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:00:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:00:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "1vk76ch9q0e0b4v13ku0rklsnr@google.com",
      "sequence": 0,
      "reminders": {
        "useDefault": true
      },
      "eventType": "default"
    }
  ]
}
```

event cancelled

```json
{
  "kind": "calendar#events",
  "etag": "\"p33cf11ktpe38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:14:04.839Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CNjwhp3LhoUDENjwhp3LhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422132889678000\"",
      "id": "1vk76ch9q0e0b4v13ku0rklsnr",
      "status": "cancelled"
    }
  ]
}
```

another event created

```json
{
  "kind": "calendar#events",
  "etag": "\"p33cdr26mpe38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:16:04.407Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CNjdiNbLhoUDENjdiNbLhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133128814000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:16:04.407Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 0,
      "reminders": {
        "useDefault": true
      },
      "eventType": "default"
    }
  ]
}
```

edit start instant

```json
{
  "kind": "calendar#events",
  "etag": "\"p32kbji7upe38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:17:29.337Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CKi5yP7LhoUDEKi5yP7LhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133298674000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:17:29.337Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "reminders": {
        "useDefault": true
      },
      "eventType": "default"
    }
  ]
}
```

edit end instant

```json
{
  "kind": "calendar#events",
  "etag": "\"p338eptt8pi38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:18:58.194Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CNDs96jMhoUDENDs96jMhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133476388000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:18:58.194Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "reminders": {
        "useDefault": true
      },
      "eventType": "default"
    }
  ]
}
```

add a reminder

```json
{
  "kind": "calendar#events",
  "etag": "\"p3389p268pi38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:20:03.474Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CNCciMjMhoUDENCciMjMhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133541668000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:18:58.194Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          },
          {
            "method": "popup",
            "minutes": 30
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

remove reminder

```json
{
  "kind": "calendar#events",
  "etag": "\"p320c9rv5pi38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:21:05.984Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CIDE7-XMhoUDEIDE7-XMhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133604178000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:18:58.194Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

add an attendee

```json
{
  "kind": "calendar#events",
  "etag": "\"p32ge35cvpm38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:23:06.148Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CKDhlZ_NhoUDEKDhlZ_NhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133852132000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:23:06.148Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        },
        {
          "email": "sergio.anger@gmail.com",
          "responseStatus": "needsAction"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

sergio.anger@gmail.com accepts invite

```json
{
  "kind": "calendar#events",
  "etag": "\"p33kdpm6cpm38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:24:41.617Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "COjc2MzNhoUDEOjc2MzNhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422133947601000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:24:41.617Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        },
        {
          "email": "sergio.anger@gmail.com",
          "responseStatus": "accepted"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

remove attendee

```json
{
  "kind": "calendar#events",
  "etag": "\"p32ccb5fvpm38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:26:27.471Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CJjFlf_NhoUDEJjFlf_NhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422134053455000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:26:27.471Z",
      "summary": "another event created",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

add a description

```json
{
  "kind": "calendar#events",
  "etag": "\"p33odnut6pq38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:27:50.934Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CPDb-6bOhoUDEPDb-6bOhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422134136918000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:27:50.934Z",
      "summary": "another event created",
      "description": "this is a testing description",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

edit title

```json
{
  "kind": "calendar#events",
  "etag": "\"p33oah6mcpq38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:29:09.030Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 30
    }
  ],
  "nextSyncToken": "CPComszOhoUDEPComszOhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422134215014000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:29:09.030Z",
      "summary": "another event created - EDITED",
      "description": "this is a testing description",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

edit default reminders

```json
{
  "kind": "calendar#events",
  "etag": "\"p32o9t2khpu38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:31:33.470Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 600
    }
  ],
  "nextSyncToken": "CLCeipHPhoUDELCeipHPhoUDGAUgnOOFpgIonOOFpgI=",
  "items": []
}
```

edit default reminders again

```json
{
  "kind": "calendar#events",
  "etag": "\"p32cb53lopu38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:32:55.327Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 10
    },
    {
      "method": "popup",
      "minutes": 600
    }
  ],
  "nextSyncToken": "CJiyjrjPhoUDEJiyjrjPhoUDGAUgnOOFpgIonOOFpgI=",
  "items": []
}
```

add another event

```json
{
  "kind": "calendar#events",
  "etag": "\"p32obn9f6pu38a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:34:32.174Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 10
    },
    {
      "method": "popup",
      "minutes": 600
    }
  ],
  "nextSyncToken": "CLC7pebPhoUDELC7pebPhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422135344348000\"",
      "id": "0bh194rq84hjoi5p0p13ea7pfp",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=MGJoMTk0cnE4NGhqb2k1cDBwMTNlYTdwZnAgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:34:32.000Z",
      "updated": "2024-03-22T00:34:32.174Z",
      "summary": "a third event",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T05:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T06:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "0bh194rq84hjoi5p0p13ea7pfp@google.com",
      "sequence": 0,
      "reminders": {
        "useDefault": true
      },
      "eventType": "default"
    }
  ]
}
```

edit something(add a location) from existing event to see if calendar reminder settings get propagated

```json
{
  "kind": "calendar#events",
  "etag": "\"p33o959d9q238a0o\"",
  "summary": "notifycal@gmail.com",
  "description": "",
  "updated": "2024-03-22T00:36:52.678Z",
  "timeZone": "Europe/Madrid",
  "accessRole": "owner",
  "defaultReminders": [
    {
      "method": "popup",
      "minutes": 10
    },
    {
      "method": "popup",
      "minutes": 600
    }
  ],
  "nextSyncToken": "CPCSpanQhoUDEPCSpanQhoUDGAUgnOOFpgIonOOFpgI=",
  "items": [
    {
      "kind": "calendar#event",
      "etag": "\"3422134678662000\"",
      "id": "7asffd5h6eqdbvcijdqk84icmr",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=N2FzZmZkNWg2ZXFkYnZjaWpkcWs4NGljbXIgbm90aWZ5Y2FsQG0",
      "created": "2024-03-22T00:16:04.000Z",
      "updated": "2024-03-22T00:36:52.678Z",
      "summary": "another event created - EDITED",
      "description": "this is a testing description",
      "location": "Av. de Leganés, 54, 28923 Alcorcón, Madrid, Spain",
      "creator": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "organizer": {
        "email": "notifycal@gmail.com",
        "self": true
      },
      "start": {
        "dateTime": "2024-03-22T02:45:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "end": {
        "dateTime": "2024-03-22T03:30:00+01:00",
        "timeZone": "Europe/Madrid"
      },
      "iCalUID": "7asffd5h6eqdbvcijdqk84icmr@google.com",
      "sequence": 1,
      "attendees": [
        {
          "email": "notifycal@gmail.com",
          "organizer": true,
          "self": true,
          "responseStatus": "accepted"
        }
      ],
      "hangoutLink": "https://meet.google.com/xxe-wiev-ikn",
      "conferenceData": {
        "entryPoints": [
          {
            "entryPointType": "video",
            "uri": "https://meet.google.com/xxe-wiev-ikn",
            "label": "meet.google.com/xxe-wiev-ikn"
          }
        ],
        "conferenceSolution": {
          "key": {
            "type": "hangoutsMeet"
          },
          "name": "Google Meet",
          "iconUri": "https://fonts.gstatic.com/s/i/productlogos/meet_2020q4/v6/web-512dp/logo_meet_2020q4_color_2x_web_512dp.png"
        },
        "conferenceId": "xxe-wiev-ikn"
      },
      "reminders": {
        "useDefault": false,
        "overrides": [
          {
            "method": "email",
            "minutes": 600
          }
        ]
      },
      "eventType": "default"
    }
  ]
}
```

TODO: explore recurring events
