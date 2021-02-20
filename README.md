# modal_queue

Our server sends Modal Events, (modal events are of the form described below).

```yml
ModalEvent
    id: string
    title: string
    subtitle: string
    action:
        share: text
        deeplink: uri
```

This project shows how to queue this modals, such that the UI can control when and when not Modal Events are handled, and acknowledging that event has been handled.

### Use Case

While working on [Achieve App](https://theachieveproject.com/), we implemented Server Side Modal Events.

- We use this to prompt user of Achievements Unlocked by their payments.
  eg: User makes payment of Ghc1000.00, an achievement or a Combo-Equivalend could be unlocked.

- We wanted to isolate the business logic behind the Achievements from the Client.

  #### Client Side

  - Client receives a silent push notification that triggers a call to fetch in-app modals.

  - We load this modals into memory and queue in a smooth way that does not interrupt user navigation in the app.

    eg: We didn't want to interrupt user while in the process of making a deposit or withdrawal.

### Motivation

- The Idea is to make the `View` handle attaching & detaching Modal Event Listeners. Remember MVP pattern in Android? yeah, something similar.

- The `ModalProvider` should only care about Listeners being registered and relaying the events sequentially through them.

- The `View` has to acknowledge receipt of the event so we can remove it from the in-memory queue.

#### My Takes

I feel bad for using a `Do-While` to manage the state of the page. Am still figuring out how i can build an `OnResume` callback (not the typical onResume tied to the application lifecycle), I mean an `onResume` for a `Widget` that doesn't require changing lots of stuff around.

Aside the `Do-While` check, the Widget relies on the `onDispose` callback to detach a listener.
