# Clinic appointments

LIVE SITE URL: [CLINIC](https://clinic-appointments.onrender.com/)

## Overview

Scheduling appointments app build with Rails, Postgresql, ViewComponents and TailwindCSS, utilizing Hotwire stack

### Functionalities

- Import patients via csv file
- Patients index view with search, filtering and sorting using turbo and stimulus
- New appointments creation/editing with dynamic form
- All appoiontments and patients appointmens index view
- Patients data dashboard chart with stimulus.js and ApexChart

## Requirements

- ruby 3.2.2
- rails 7.0.6
- postgresql 14.5
- redis

## Setup

```
bundle install
rails db:create
rails db:migrate
```

### Seed

```
rake db:seed:all
```

### Patients import

```
rake v import:patients
```

### lefthook

Lefthook is set up as a pre-commit hook which runs rubocop and

```
lefthook install
```
