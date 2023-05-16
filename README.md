[![pub package](https://img.shields.io/pub/v/daily_flutter.svg)](https://pub.dartlang.org/packages/daily_flutter)

# A video chat app using the Daily Client SDK for Flutter

This demo showcases a basic video chat app that uses Daily's [Flutter SDK](https://docs.daily.co/reference/flutter) library.

## Prerequisites

- [Sign up for a Daily account](https://dashboard.daily.co/signup).
- [Create a Daily room URL](https://help.daily.co/en/articles/4202139-creating-and-viewing-rooms) to test a video call quickly, and then enter that URL into the demo _(this is NOT recommended for production apps!)_.
- Set up your [Flutter environment](https://docs.flutter.dev/get-started/install).

## How the demo works

In the demo app, a user must enter a URL for a [Daily room](https://docs.daily.co/reference#rooms), then press Join.
The app will find the meeting room and join the call.

The app initializes a `CallClient`, which is the main entrypoint to the SDK. It provides an API for interacting
with the meeting and keeps track of important information about the meeting, like other participants (including
their audio and video tracks) and the things they do on the call (e.g., muting their mic or leaving).

Most of the client's internal state can be accessed synchronously through getters on the object, but updates can
also be received asynchronously by listening to the [client's event stream](https://pub.dev/documentation/daily_flutter/latest/daily_flutter/CallClient/events.html).

When the user leaves the meeting room, the `CallClient` remains and can be re-used for further calls. In this demo, it
is not destroyed until the application exits.

When testing or running this demo, you'll likely use a room you've manually created for calls. A production application
will likely need to use the [Daily REST API](https://docs.daily.co/reference/rest-api) to create rooms on the fly for
your users, which necessitates the use of a sensitive Daily API key. You likely don't want to embed this key in a
production app. We recommend running a web server and keeping sensitive things like API keys there instead.

This project is designed to work with rooms that have privacy set to public or private. When joining a private room,
you must provide a valid token to access the room. At the moment, knocking for access is not supported, meaning that
a token is always required when joining a private room.

## Running locally

1. Clone this repository locally, i.e.: `git clone git@github.com:daily-demos/daily-flutter-demo.git`
2. Open the `daily-flutter-demo`-directory in your favourite Flutter IDE/editor.
3. Run `flutter pub get`
4. Run the project with `flutter run`.
5. Connect to the room URL you are testing and, to see it work, connect again either in another simulator or device,
   or directly using a web browser.

   **Careful of mic feedback!** You may want to mute one or both sides' audio if they are close to each other.

