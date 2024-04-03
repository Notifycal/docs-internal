---
title: Watch overview
description: Docs, links, and notes to work out how to create a more efficient stream of events from Google Calendar API
---

Google Calendar is a product that allows people to manage an agenda. The intention here is to create an stream of events/notifications to react to them and provide some sort of notification service that Google does not provide.

As you google it, one of the first things coming up is [Push Notification](https://developers.google.com/calendar/api/guides/push#overview). At the first glance it seems that's exactly what you are looking for although Google have more difficult plans for developers to integrate with it. All this API provides is a channel a [calendar watch endpoint](https://developers.google.com/calendar/api/v3/reference/events/watch) which accepts a callback to tap into by Google when something changes to the interrogated calendar. Whereas that is true, the events going through the channel don't have the granularity one would expect. Aside from the fact you have to make an initial request to fetch all the events, when Google notifies "something" has changed in the calendar one has to make another call to Google to receive the whole state of the event as opposed to the actual bit changing. This is as good as it gets in order to provide a stream of changes.

## Open channel and use it

At this point, it clear that we have to compute the stream of changes by ourselves. The plan so far is - leaving authentication/authorization aside:

1. Call Calendar watch API to create a channel of notifications. This channel has an configurable and limited expiration time. By default, it lasts about a week.
   Neither stopping a channel nor a channel expiring by itself make Google send a last notification - this has been tested.

Request example:

```
POST https://www.googleapis.com/calendar/v3/calendars/my_calendar@gmail.com/events/watch
Authorization: Bearer auth_token_for_current_user
Content-Type: application/json
```

```json
{
  "id": "01234567-89ab-cdef-0123456789ab", // Your made-up channel ID.
  "type": "web_hook",
  "address": "https://mydomain.com/notifications", // Your callback URL.
  //... (see Docs for further info)
  "token": "target=myApp-myCalendarChannelDest", // (Optional) Your channel token.
  "expiration": 1426325213000 // (Optional) Your requested channel expiration time.
}
```

Response example:

```json
{
  "kind": "api#channel",
  "id": "01234567-89ab-cdef-0123456789ab", // ID you specified for this channel.
  "resourceId": "o3hgv1538sdjfh", // ID of the watched resource.
  "resourceUri": "https://www.googleapis.com/calendar/v3/calendars/my_calendar@gmail.com/events", // Version-specific ID of the watched resource.
  "token": "target=myApp-myCalendarChannelDest", // Present only if one was provided.
  "expiration": 1426325213000 // Actual expiration time as Unix timestamp (in ms), if applicable.
}
```

2. As real world events happen in the calendar - i.e. Calendar user uses their calendar - Google will invoke the callback specified in 1).

Request example:

```
POST https://mydomain.com/notifications // Your callback URL.
Headers:
X-Goog-Channel-ID: channel-ID-value // Your made-up channel ID from 1)
X-Goog-Channel-Token: channel-token-value // Not sure what this is for yet. This is necessary for closing the channel. See section Stop notifications.
X-Goog-Channel-Expiration: expiration-date-and-time // In human-readable format. Present only if the channel expires.
X-Goog-Resource-ID: identifier-for-the-watched-resource // This is necessary for closing the channel. See section Stop notifications.
X-Goog-Resource-URI: version-specific-URI-of-the-watched-resource // Keep this one safe, it will be used in 3)
X-Goog-Resource-State: sync // There are 3 types as per Docs state: sync (only to indicate the channel has opened), exist (something changed) and not_exist (not sure yet)
X-Goog-Message-Number: 1
```

3. Call ${X-Goog-Resource-URI}, which is basically the [event list endpoint](https://developers.google.com/calendar/api/v3/reference/events/list) to fetch all the events from the target calendar. It is a necessary initial call so that later you can fetch only events that have actually changed. Whether or not we receive `X-Goog-Resource-State: sync` we need to make this call.

Request example:

```
GET https://www.googleapis.com/calendar/v3/calendars/calendarId/events
Authorization: Bearer auth_token_for_current_user
Content-Type: application/json
```

Note: I have read [online](https://stackoverflow.com/questions/78030802/google-calendar-watch-doesnt-send-notifications-after-the-initial-sync-notifica) that it is necessary to pass [eventTypes](https://developers.google.com/calendar/api/v3/reference/events/list?#:~:text=Deprecated%20and%20ignored.-,eventTypes,-string) =default parameter because Google devs are mentally impaired.

Response example:

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

Here is the reference anyway:

- [Calendar](https://developers.google.com/calendar/api/v3/reference/events/list?#response)
- [Event](https://developers.google.com/calendar/api/v3/reference/events#resource)

To be able to fetch changed events, it is necessary to keep `.nextSyncToken` for 4). When the amount of fetched events is to large [the API provides pagination](https://developers.google.com/calendar/api/guides/sync#incremental_sync). This means you have to make subsequent request passing `pageToken` as well as `syncToken` until server doesn't return a `pageToken` anymore. Max number of results can be 2500, however, by default the value is 250.
Keep reading, we are "almost" there.

Note: past events get also fetched. Maybe timeMin parameter could help.
Note2: there is an orderBy and it accepts: "startTime" and "updated" values.
Note3: there are options around recurring events. I reckon the way it works by default is that you don't get a recurring event but instead you get all the instances of it.

4. On next notification from channel - same as in 2) -, which presumably `X-Goog-Resource-State` will contain `exist` as a value this time, we need to repeat 3) passing the inmmeditate and previous `nextSyncToken` received so that we get a delta instead.

## Stop channel

Although the channel has an inherent expiration time, you can choose to stop it manually by calling this API.

```
POST https://www.googleapis.com/calendar/v3/channels/stop
Authorization: Bearer CURRENT_USER_AUTH_TOKEN
Content-Type: application/json
```

```json
{
  "id": "4ba78bf0-6a47-11e2-bcfd-0800200c9a66", // See headers from request in 2)
  "resourceId": "ret08u3rv24htgh289g" // See headers from request in 2). I suspect this id is not stable and it changes as things flow through the channel.
}
```

## Reference

[This](https://stackoverflow.com/questions/31932239/how-to-handle-google-calendar-api-push-notifications) helped to connect the dots.
