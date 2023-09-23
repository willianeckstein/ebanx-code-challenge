# README

Dependencies:

- Ruby 3.2.2
- Rails 7.0.8

To start de development server:

```
rails server
```

If you want to start in production mode

```
rails server -e production
```

If you want to change the port of the server

```
rails server -p PORT_NUMBER
```

If you run it with Ngrock on development mode, you need to change the host configuration in de the config/environments/development.rb file:

```
config.hosts << THE_HOST_URL
```

