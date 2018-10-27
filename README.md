# Rails App for Weddings and Events

This is a simple rails app for managing the guest list for a wedding (or similar event). It's intended to be easy to customize.

## Features

- Guests can RSVP, including dietary requirements and plus ones
- Guests can manage their own RSVPs using a secret link in an email (no user name / password needed)
- Responsive design on home page and RSVP pages
- Customizable [styling and wording](#Customization)
- [Active Admin](https://activeadmin.info/) interface to manage the attendee list
- Optional invisible [reCAPTCHA](https://www.google.com/recaptcha) integration to avoid spam
- Sets headers to avoid being indexed by search engines

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

The admin interface is on http://localhost:3000/admin

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

You can of course customize everything, but here are some places to start:

### Content

- [`config/locales/en.yml`](config/locales/en.yml)

  ```yml
  wedding_name: "Jack & Jill's Wedding"
  wedding_couple_names: 'Jack & Jill'
  wedding_date: 'Saturday, 1 January 2000'
  wedding_location: 'South Pole'
  photo_credits: 'Photo Credits: Pexels'
  ```

## Default photo credits

- https://www.pexels.com/photo/selective-focus-photography-of-two-penguins-689784/
- https://www.pexels.com/photo/cold-glacier-iceberg-melting-48178/
- https://www.pexels.com/photo/flock-of-penguins-1036155/
- https://www.pexels.com/photo/beautiful-flowers-bloom-blooming-blossom-548389/
