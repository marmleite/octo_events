<!-- TABLE OF CONTENTS -->
## Table of Contents

- [Octo Events](#octo-events)
  - [1. Webhook Endpoint](#1-webhook-endpoint)
  - [2. Events Endpointv](#2-events-endpointv)
  - [3. Installation](#3-installation)
  - [4. Test it](#4-test-it)
  - [5. Stop](#5-stop)
  - [6. Restart](#6-restart)

# Octo Events

Octo Events is an application that listens to Github Events via webhooks and expose by an api for later use.

![alt text](imgs/octo_events.png)


## 1. Webhook Endpoint

The Webhook endpoint receives events from Github and saves them on the database:

**Request:**

> POST /events

```javascript
  { "sender": "{}"}
```

**Response:**

> 201 CREATED

 To know more about how it works read the following docs:

* Webhooks Overview: https://developer.github.com/webhooks/
* Creating Webhooks : https://developer.github.com/webhooks/creating/

## 2. Events Endpointv

The Events endpoint will expose the persist the events by an api that will filter by issue number

**Request:**

> GET /issues/1000/events

**Response:**

> 200 OK
```javascript
[
  { "action": "open", created_at: "...",},
  { "action": "closed", created_at: "...",}
]
```

## 3. Installation

**Requeriments**

* [Docker 19.03.6+](https://docs.docker.com/get-docker/)
* [docker-compose 1.17.1+](https://docs.docker.com/compose/install/)
* [Disable Docker sudo usage](https://docs.docker.com/engine/install/linux-postinstall/)


1. Create the project folder:

```sh
mkdir octo_events && cd octo_events
```

2. Download the project:

```sh
git clone git@bitbucket.org:recrutamento_jya_ruby/recrutamento-ruby-jya-marcelomarzolaleite_gmail.com.git .
```

3. Give permission
   Give permission to the user execute the script **setup**
```sh
chmod 755 setup
```

4. Setup
   It will run `docker-compose up`, create the data base and migrate. You can visit http://localhost:3000 to confirm it is up and running:
```sh
./setup
```

**Github Integration Instructions**

* Tip: You can use ngrok (https://ngrok.com/)  to install / debug the webhook calls, it generates a public url that will route to your local host:

   $ ./ngrok http 3000

![alt text](imgs/ngrok.png)

   GitHub

![alt text](imgs/add_webhook.png)

After that, add the secret token and the ngrok URL to `.env` file:
```
NGROK_HOST=url.ngrok.io
SECRET_TOKEN=secret_token
```

## 4. Test it

1. Give permission
   Give permission to the user execute the script **run**
```sh
chmod 755 test
```

2. Setup
   It will run the tests inside the running docker container:
```sh
./test
```

## 5. Stop

If you want to stop the project:
```sh
docker-compose stop
```

## 6. Restart

If you want to stop the project:
```sh
docker-compose start
```
