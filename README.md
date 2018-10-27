# Wedding with Rails

This is a simple rails app for managing the guest list for a wedding (or similar event). It's intended to be easy to customize.

## Features

- Guests can RSVP, including dietary requirements and plus ones
- Sends guests a confirmation email they can use to manage their RSVP
- Responsive design
- [Active Admin](https://activeadmin.info/) interface to manage the attendee list
- Optional invisible [reCAPTCHA](https://www.google.com/recaptcha) integration to avoid spam
- Sets headers to avoid being indexed by search engines

## Development

### Initial Setup

The simplest way to get started is to use [Docker](https://www.docker.com/).

```
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

## Default photo credits

- https://www.pexels.com/photo/selective-focus-photography-of-two-penguins-689784/
- https://www.pexels.com/photo/cold-glacier-iceberg-melting-48178/
- https://www.pexels.com/photo/flock-of-penguins-1036155/
- https://www.pexels.com/photo/beautiful-flowers-bloom-blooming-blossom-548389/
