# Salem's Parking Lot

[![Build
Status](https://travis-ci.org/lunohodov/salems-parking-lot.svg?branch=master)](https://travis-ci.org/lunohodov/salems-parking-lot)

If Stephen King was a programmer, how would he solve the parking lot [problem in Salem](https://en.wikipedia.org/wiki/%27Salem%27s_Lot)?

Well, with lots of [coding horror](https://blog.codinghorror.com/) minced and spiced the
Rails way and [served](https://salems-parking-lot.herokuapp.com/api/free-spaces) by a terrifying Heroku dyno(saurian).

## Requirements

* Ruby v2.4.2 or newer
* Rails v5.1.4 or newer

## Usage

### General rules

* API responses are in JSON format. There is no support for JSONP
* The `Content-Type` header is always set to `application/json`

### Error handling

There are two types of errors the API returns

* The client did something wrong i.e client error
* The API did something wrong i.e server error

Error responses are wrapped in a common response object. The HTTP status will
differ depending on type of error.

Code                         | HTTP Status                    | Message
---------------------------- | -----------------------------  | -------
*invalid_request*            | 400 (Bad Request)              | The request has a missing parameter or an invalid parameter value
*resource_not_found*         | 404 (Not Found)                | The specified resource does not exist
*vacant_place_not_found*     | 404 (Not Found)                | No vacant parking places available
*internal_error*             | 500 (Internal Server Error)    | The server encountered internal error

An error is described by the following properties

Property          | Description
----------------- | -----------
*error_code*      | The code identifying the error
*error_status*    | The corresponding HTTP status code
*error_message*   | A verbose plain language description of the problem with hints about how to fix it

## Endpoints

Verb | URI Pattern                    | Use case
---- | ------------------------------ | --------
POST | /api/tickets                   | [Issue new ticket](#issue-a-ticket)
GET  | /api/tickets/:barcode          | [Ticket due amount](#ticket-due-amount)
POST | /api/tickets/:barcode/payments | [Pay ticket](#pay-ticket)
GET  | /api/tickets/:barcode/state    | [Ticket state](#ticket-state)
GET  | /api/free-spaces               | [Vacancy information](#vacancy-information)

#### Issue a ticket

    POST /api/tickets

The API will respond with the following response

Property          | Description
----------------- | -----------
*barcode*         | Ticket's barcode
*issued_at*       | The time when the ticket has been issued

In case there are no free spaces, an `vacant_place_not_found` error will be returned.

#### Ticket due amount

    GET /api/tickets/:barcode

API responds with amount due for the specified ticket barcode

Property          | Description
----------------- | -----------
*barcode*         | Ticket's barcode
*euros_due*       | Due amount in euros

If there is no ticket with the given barcode, an `resource_not_found` error will be returned.

#### Pay ticket

    POST /api/tickets/:barcode/payments

Pays the ticket with the specified barcode and payment option

Parameter             | Description
--------------------- | -----------
*payment_option*      | One of `cash`, `credit_card` or `debit_card`

API responds with amount paid

Property          | Description
----------------- | -----------
*euros_paid*      | Paid amount in euros

If there is no ticket with the given barcode, an `resource_not_found` error will be returned.

#### Ticket state

    GET /api/tickets/:barcode/state

Returns ticket's current state

Property     | Description
------------ | -----------
*barcode*    | Ticket's barcode
*state*      | `paid` when ticket is paid within last 15 minutes, otherwise `unpaid`

If there is no ticket with the given barcode, an `resource_not_found` error will be returned.

#### Vacancy information

    GET /api/free-spaces

Responds with the number of free spaces

Property          | Description
----------------- | -----------
*free_spaces*     | Number of free spaces

## FAQ

#### How long did the development take?

Way over the two-hour timeline. 

#### Why GitHub?

GitHub makes code reviews easier.

## Licence

This project is licensed under the MIT License - see the [license](LICENSE.md) file for details.
