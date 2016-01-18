## Launch Calendar
[![Codeship Status for itiswicked/calendar](https://codeship.com/projects/c6995f40-a05e-0133-34ce-6af23f5d89a3/status?branch=master)](https://codeship.com/projects/128163)
[![Code Climate](https://codeclimate.com/github/itiswicked/calendar/badges/gpa.svg)](https://codeclimate.com/github/itiswicked/calendar)
[![Coverage Status](https://coveralls.io/repos/github/itiswicked/calendar/badge.svg?branch=make_some_html_happen)](https://coveralls.io/github/itiswicked/calendar?branch=make_some_html_happen)

This is my final project for Launch Academy.


### Use

To start this application

```
git clone <url>
cd calendar
bundle install
rails server
```
### To Do

This application is a work in progress, and as such does not have working features yet.


#### HMTL/CSS
- [x] Create basic table structure
- [ ] Table
  - [x] Event indicator filled and not filled
  - [x] Make each date cell look like a button
    - [x] Drop shadow
    - [x] rounded corners
  - [ ] Make button push 'animation'. Make it toggle for now
- [ ] Navigation
  - [ ] Finalize layout
  - [ ] Swap arrow brackets for arrow icons
- [ ] Event display pane
  - [ ] Stylize event cell like day cell
  - [ ] New event form
  - [ ] New event form cover (a cell that has giant plus sign.)
- [ ] Finalize color scheme

### Custom JS Calendar Library

This calendar library will be responsible for the following:

- Making asynchronous requests to the server
  - It should get events for an entire month being viewed, as well as the month prior and after. This will expedite loading of those months.
- Keeping the state, structure, and logic of the calendar at any given time.
- Have a clean exposable API for the application to query for information, as well as push it back to the server.
- Dependencies:
  - JQuery for for asynchronous callbacks to the server.
  - A JS DateTime Library for generic date and time information.
  - The usual suspects Underscore, lodash, etc.

### Server

- [ ] Setup database, schema, etc.
- [ ] Write controllers for handling sync and async requests.
- [ ] Figure out how rails does JSON. Do that thing.

### To Do List

- [ ] Finish to do list.

### Bonus Features

- Week and day 'pages'.
- Made events pain view event blocks like google calendar.
