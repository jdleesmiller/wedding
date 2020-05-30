# Rails App for Weddings and Similar Events

![CI status](https://github.com/jdleesmiller/wedding/workflows/CI/badge.svg)

So you're getting married :tada:

This is a simple rails app for distributing wedding information and managing the guest list. You will probably decide to build your own (like me&hellip;) but if you like you can start with this one. It's been through at least one wedding successfully!

## Is it any good?

> THIS WEBSITE IS AWESOME! Best wedding invite ever.
> &mdash; One of our guests

## Features

- Guests can RSVP, including dietary requirements and plus ones
- Guests can manage their own RSVPs using a secret link in an email (no user name / password needed)
- Responsive design on home page and RSVP pages
- Customizable [styling and wording](#customization)
- [Active Admin](https://activeadmin.info/) interface to manage the attendee list
- Optional invisible [reCAPTCHA](https://www.google.com/recaptcha) integration to avoid spam
- Sets headers to avoid being indexed by search engines

## Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents** _generated with [DocToc](https://github.com/thlorenz/doctoc)_

- [Rails App for Weddings and Similar Events](#rails-app-for-weddings-and-similar-events)
  - [Is it any good?](#is-it-any-good)
  - [Features](#features)
  - [What does it look like?](#what-does-it-look-like)
  - [How does it work?](#how-does-it-work)
  - [Development](#development)
    - [Initial Setup](#initial-setup)
    - [Running the App](#running-the-app)
  - [Customization](#customization)
    - [Content](#content)
    - [Styling](#styling)
  - [Environment Variables](#environment-variables)
    - [Sending Email](#sending-email)
    - [ReCAPTCHA](#recaptcha)
  - [Deployment](#deployment)
  - [License](#license)
  - [Credits](#credits)
    - [Design](#design)
    - [Photos](#photos)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What does it look like?

![Screenshot of the home page](docs/homepage_big.jpg)

## How does it work?

Here's a map of all the flows through the app, from the home page to the RSVP flow and also some of the separate admin interface. [Click here to expand the image.](http://jdlm.info/wedding/wedding_flow.jpg) And [here is a higher resolution PDF version](http://jdlm.info/wedding/wedding_flow.pdf).

![Flow chart showing the application states.](docs/wedding_flow.jpg)

## Development

### Initial Setup

The simplest way to get started is to use [Docker](https://www.docker.com/).

```
git clone https://github.com/jdleesmiller/wedding.git
cd wedding
cp development.env.template development.env
docker-compose build
docker-compose up -d db
docker-compose run --rm web bash -lc 'bin/rails db:create db:migrate'
docker-compose run --rm web bash -lc 'bin/rails db:seed'
```

Watch the output of `db:seed` for the default admin credentials:

```
Admin user email: admin@example.com
Admin user password: (random string)
```

### Running the App

```
docker-compose up -d
docker-compose logs -f
```

By default, the app will run on http://localhost:3000

The admin interface is on http://localhost:3000/admin. Once you are logged into the admin, you can go to Admin Users, find the default admin user, and change its email address, if you like (you will need to re-enter the password).

To access the database:

```
docker-compose exec db psql wedding_development postgres
```

To get a shell:

```
docker-compose exec web bash
```

Once you have a shell in the container, you can run rails commands as normal.

```
bin/rails console
bin/rails test
```

## Customization

You can of course customize everything by changing the code, but here are some useful places to start:

### Content

- [`config/locales/en.yml`](config/locales/en.yml) &mdash; key strings

  ```yml
  wedding_name: "Jack & Jill's Wedding"
  wedding_couple_names: 'Jack & Jill'
  wedding_date: 'Saturday, 1 January 2000'
  wedding_location: 'South Pole'
  photo_credits: 'Photo Credits: Pexels'
  ```

- [`app/views/application`](app/views/application) &mdash; the address on the home page and the addresses in the emails

- [`app/views/welcome`](app/views/welcome) &mdash; the home page content

- [`development.env`](development.env.template) &mdash; [environment variables](#environment-variables) in development

  - set emails and other secrets that should not be checked in

- [`public/wedding.ics`](public/wedding.ics) &mdash; the calendar invite

  - this is just a sample file; you probably want to [generate one](https://apps.marudot.com/ical/)

### Styling

- [`app/assets/images`](app/assets/images) &mdash; the images

  - `jumbo.jpg` is the title image at the top of the home page
  - `rsvp.jpg` is the title image at the top of the RSVP pages

- [`app/assets/stylesheets/application.scss`](app/assets/stylesheets/application.scss) &mdash; theme colors and bootstrap customization

  ```sass
  $font-family-sans-serif: Montserrat, Helvetica, Arial, sans-serif;
  $font-family-serif: Arvo, Georgia, "Times New Roman", Times, serif;

  $font-family-base: $font-family-serif;
  $headings-font-family: $font-family-sans-serif;

  $body-color: rgba(28, 13, 10, 0.7);
  $headings-color: rgba(28, 13, 10, 0.7);

  $theme-colors: (
    "primary": #ff745c
  );

  $enable-rounded: false;
  ```

## Environment Variables

- `CANONICAL_URL` &mdash; your website's domain, e.g. `www.mywedding.com`
- `CONTACT_EMAIL` &mdash; the email address that users can use to contact you, e.g. `info@mywedding.com`
- `FROM_EMAIL` &mdash; the email address that confirmations emails will come from

### Sending Email

There are environment variables that correspond to each [`smtp_settings`](https://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration) key in the ActionMailer config.

- `SMTP_ADDRESS` &mdash; name of the SMTP server
- `SMTP_PORT` &mdash; port the SMTP server listens on (default `587`)
- `SMTP_DOMAIN` &mdash; HELO domain, if required
- `SMTP_USER_NAME` &mdash; user name for SMTP server
- `SMTP_PASSWORD` &mdash; password for SMTP server
- `SMTP_AUTHENTICATION` &mdash; authentication type (default `plain`)
- `SMTP_ENABLE_STARTTLS_AUTO` &mdash; automatically detect if STARTTLS is enabled and use it if so (default `true`)

### ReCAPTCHA

If set, the website will use an invisible reCAPTCHA to prevent spam. You can get these from [Google reCAPTCHA's admin page](https://www.google.com/recaptcha/admin). Be sure to choose "Invisible" for the type.

- `RECAPTCHA_SITE_KEY` &mdash; the `data-sitekey` for the Client side integration
- `RECAPTCHA_SECRET_KEY` &mdash; the `secret` for the Server side integration

## Deployment

Heroku makes it easy to deploy rails apps like this one. The free postgres database is enough, unless you have &gt; 10k guests! You can set up a Heroku app and connect it to your GitHub repo.

You must set the canonical host and email addresses in order to be able to send email:

```
heroku config:set \
  CANONICAL_HOST=www.mywedding.com \
  CONTACT_EMAIL='Example Name <example@example.com>' \
  FROM_EMAIL='Example Name <example@example.com>'
```

You will also need to set up SMTP by setting the config variables above. One way to do this is to use your [Google Mail account's SMTP server](https://www.digitalocean.com/community/tutorials/how-to-use-google-s-smtp-server).

Then you can get up and running with:

```
heroku run rails db:migrate db:seed
```

Watch the output of `db:seed` for the default admin credentials, like in development. The admin console will be available on `/admin`.

If you like, you can also turn on reCAPTCHA, as above.

```
heroku config:set \
  RECAPTCHA_SITE_KEY=... \
  RECAPTCHA_SECRET_KEY=...
```

## License

[BSD License](LICENSE.md)

## Related Projects

I'm not the first rails developer to build a wedding website:

- https://github.com/adambutler/wedding-on-rails
- https://github.com/agoln/wedding
- https://github.com/andxyz/rails-rwedding

## Credits

Thanks to [@Hopet](https://github.com/Hopet) for help with design and copy.

### Design

The default design is based on https://naomi-demo.squarespace.com/ .

### Photos

The photos for the demo are from [Pexels](https://www.pexels.com/):

- https://www.pexels.com/photo/selective-focus-photography-of-two-penguins-689784/
- https://www.pexels.com/photo/cold-glacier-iceberg-melting-48178/
- https://www.pexels.com/photo/flock-of-penguins-1036155/
- https://www.pexels.com/photo/beautiful-flowers-bloom-blooming-blossom-548389/
