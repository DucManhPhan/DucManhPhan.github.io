---
layout: post
title: Refactoring with State Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Refactoring]
---



<br>

## Table of contents





<br>

## Given problem




![](../img/design-pattern/state-pattern/booking/event-booking-process-sample.png)

<br>

## Description for booking process

1. **New** state

    ![](../img/design-pattern/state-pattern/booking/new-state.png)

    With this state, we have some actions:
    - assign a booking ID.
    - display the status of the booking.
    - provide for data entry such as username, the number of tickets, ...

    From the New state, some states can turn such as:
    - Date Passed state

        The date for the event can pass at which point the booking is closed.

    - User Canceled
    
        The user can cancel, also resulting in the booking being closed.

    - Submit
    
        The user can submit their information for processing.

    When a booking is closed for any reason, we simply want to display the booking state and provide the user with a reason that the booking was closed.

2. Submit state

    Some actions used in this state:
    - update booking data
    - display status or state of the booking in the UI
    - submit booking for processing
    - handle response

3. Success state
4. Booked state
5. Closed state

    With this state, our application will do:
    - display the booking state
    - display the reason why the booking was closed

6. Date Passed state
7. User Canceled state

<br>

## Naive approach for Booking process

From the above images, we can find that buttons will consider our states such as New, Submit, Cancel, and Date Passed.

It means that when we click Cancel button, our booking event will be canceled, then the final state is closed. And clicking Date Passed button, our booking event will be Date Passed state, the final state is closed. Our code will look like:

```java
public void clickCancelBtn() {
    this.showState("Cancel");
    System.out.println("Canceled by user");
}

public void clickDatePassedBtn() {
    this.showState("Date passed");
    System.out.println("Booking expired");
}
```

The above implementation seems normal, but it exists issues such as a canceled booking can expire or even be re-canceled, and an expired booking can also be canceled or re-expired.

A common way to address these types of issues in the absence of the state pattern is to use a simple Boolean field.

```java
private boolean isNew = true;

public void clickCancelBtn() {
    if (this.isNew) {
        this.showState("Closed");
        System.out.println("Canceled by user");
        this.isNew = false;
    } else {
        System.out.println("Closed bookings cannot be canceled");
    }
}

public void clickDatePassedBtn() {
    if (this.isNew) {
        this.showState("Closed");
        System.out.println("Booking expired");
        this.isNew = false;
    } 
}
```

Now, we will continue with submit button.

```java
private String attendee;
private int ticketCount;
private Token cancelToken;

public void clickSubmitBtn(String attendee, int ticketCount) {
    if (this.isNew) {
        this.isNew = false;
        this.attendee = attendee;
        this.ticketCount = ticketCount;

        // async process booking
        processBooking();

        this.showState("Pending");
        System.out.println("Processing booking");
    }
}

public void processBooking(Booking booking, ProcessingResult result) {
    switch (result) {
        case ProcessingResult.Success:
            this.showState("Booked");
            System.out.println("Enjoy the event");
            break;

        case ProcessingResult.Fail:
            System.out.println("Error when processing booking")
            this.attendee = "";
            this.ticketCount = 0;

            this.bookingId = new Random().next();
            this.showState("New");
            this.currentState = BookingState.NEW;
            // show entry page

            break;

        case ProcessingResult.Cancel:
            this.showState("Closed");
            System.out.println("Processing Canceled");
            break;
    }
}
```

Only new booking can be submitted, at which point the booking is no longer New or Closed. It's been submitted for processing, and we're kind of on hold pending a response. So we have a new state call it as Pending.

If the response is successful, the booking is considered booked. If it fails, the process starts over and we're back in the New state. While pending, the user can cancel the booking resulting in it being closed.

To make sure that only a new booking can be submitted, we can check the value of the isNew field, and only if it is true, we will submit the information.

```java
private BookingState isPending;

public void clickSubmitBtn(String attendee, int ticketCount) {
    if (this.isNew) {
        this.isNew = false;
        this.isPending = true;

        // the same as the above code
    }    
}

public void clickCancelBtn() {
    if (this.isNew) {
        this.showState("Closed");
        System.out.println("Canceled by user");
        this.isNew = false;
    } else if (this.isPending) {
        // cancel
    } else {
        System.out.println("Closed bookings cannot be canceled");
    }
}

public void processBooking(Booking booking, ProcessingResult result) {
    this.isPending = false;
    switch (result) {
        case ProcessingResult.Success:
            this.showState("Booked");
            System.out.println("Enjoy the event");
            break;

        case ProcessingResult.Fail:
            System.out.println("Error when processing booking")
            this.attendee = "";
            this.ticketCount = 0;

            this.isNew = true;      // if processing booking fail happens, mark isNew field
            this.bookingId = new Random().next();
            this.showState("New");
            // show entry page

            break;

        case ProcessingResult.Cancel:
            this.showState("Closed");
            System.out.println("Processing Canceled")
            break;
    }
}
```

Then, the processing booking is successful, we have no way to know that the event has been booked. So we will create a boolean isBooked field.

```java
private boolean isBooked;

public void processBooking(Booking booking, ProcessingResult result) {
    this.isPending = false;
    switch (result) {
        case ProcessingResult.Success:
            this.isBooked = true;
            this.showState("Booked");
            System.out.println("Enjoy the event");
            break;

        case ProcessingResult.Fail:
            System.out.println("Error when processing booking")
            this.attendee = "";
            this.ticketCount = 0;

            this.isNew = true;      // if processing booking fail happens, mark isNew field
            this.bookingId = new Random().next();
            this.showState("New");
            // show entry page

            break;

        case ProcessingResult.Cancel:
            this.showState("Closed");
            System.out.println("Processing Canceled")
            break;
    }
}

public void clickDatePassedBtn() {
    if (this.isNew) {
        this.showState("Closed");
        System.out.println("Booking expired");
        this.isNew = false;
    } else if (this.isBooked) {
        this.showState("Closed");
        this.isBooked = false;
    }
}

public void clickCancelBtn() {
    if (this.isNew) {
        this.showState("Closed");
        System.out.println("Canceled by user");
        this.isNew = false;
    } else if (this.isPending) {
        // cancel
    } else if (this.isBooked) {
        this.showState("Closed");
        System.out.println("Booking canceled: Expect a refund");
        this.isBooked = false;
    } else {
        System.out.println("Closed Bookings cannot be canceled");
    }
}
```

The drawbacks of the naive approach:
- Interdependent logic
- Time lost managing fields
- Difficult to extend
- Harder to debug and manage

<br>

## Using State pattern

![](../img/design-pattern/state-pattern/booking/booking-process-state-pattern.png)

- With Context

    ```java
    public class BookingContext {
        private String attendee;
        private int ticketCount;
        private int bookingID;

        private BookingState currentState;

        public void transitionToState(BookingState state) {
            this.currentState = state;
            this.currentState.enterState(this);
        } 

        public BookingContext() {
            this.transitionToState(new NewState());
        }

        public void clickSubmitBtn(String attendee, int ticketCount) {
            this.currentState.enterDetails(this, attendee, ticketCount);
        }

        public void clickCancelBtn() {
            this.currentState.cancel(this);
        }

        public void clickDatePassedBtn() {
            this.currentState.datePassed(this);
        }
    }
    ```

- With Abstract State

    ```java
    public abstract class BookingState {
        public abstract void enterState(BookingContext booking);
        public abstract void cancel(BookingContext booking);
        public abstract void datePassed(BookingContext booking);
        public abstract void enterDetails(BookingContext booking, String attendee, int ticketCount);
    }
    ```

- With Concrete state

    ```java
    public class NewState extends BookingState {
        public void enterState(BookingContext booking) {
            booking.bookingID = new Random().next();
            booking.showState("New");
        }

        public void cancel(BookingContext booking) {
            booking.transitionToState(new ClosedState("Booking Canceled"));
        }

        public void datePassed(BookingContext booking) {
            booking.transitionToState(new ClosedState("Booking Expired"));
        }

        public void enterDetails(BookingContext booking, String attendee, int ticketCount) {
            booking.attendee = attendee;
            booking.ticketCount = ticketCount;
            booking.transitionToState(new PendingState());
        }
    }

    public class PendingState extends BookingState {
        public void enterState(BookingContext booking) {

        }

        public void cancel(BookingContext booking) {

        }

        public void datePassed(BookingContext booking) {

        }

        public void enterDetails(BookingContext booking, String attendee, int ticketCount) {

        }
    }

    public class BookedState extends BookingState {
        public void enterState(BookingContext booking) {
            booking.showState("Booked");
        }

        public void cancel(BookingContext booking) {
            booking.transitionToState(new ClosedState("Booking Canceled: Expect a refund"));
        }

        public void datePassed(BookingContext booking) {
            booking.transitionToState(new ClosedState("We hope you enjoyed the event!"));
        }

        public void enterDetails(BookingContext booking, String attendee, int ticketCount) {

        }
    }

    public class ClosedState extends BookingState {
        private String reasonClosed;

        public ClosedState(String reasonClosed) {
            this.reasonClosed = reasonClosed;
        }

        public void enterState(BookingContext booking) {
            booking.showState("Closed");
            // show reason closed
        }

        public void cancel(BookingContext booking) {
            booking.showError("Invalid action for this state");
        }

        public void datePassed(BookingContext booking) {
            booking.showError("Invalid action for this state");
        }

        public void enterDetails(BookingContext booking, String attendee, int ticketCount) {
            booking.showError("Invalid action for this state");
        }
    }
    ```

<br>

## Benefits and Drawbacks of State pattern

1. Benefits

    - More modular
    - Easier to read and maintain
    - Less difficult to debug
    - More extensible

2. Drawbacks

    - Takes time to setup
    - More moving parts
    - Potentially less performant

<br>

## Wrapping up




<br>

Refer:

[]()