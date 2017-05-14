# Credit Karma Score Notifier

Sends your Credit Karma score to the IFTTT Maker Service.

## Quick Start: Docker

```
docker pull emcniece/credit-karma-notify

docker run --name ck-notify \
 -e ck_email=user@domain.com \
 -e ck_password=password \
 -e if_event_name=credit_karma \
 -e if_key=password \
 -d emcniece/credit-karma-notify

```

## Quick Start: Docker-Compose

```sh
cp docker-compose.yml-sample docker-compose.yml
# Edit docker-compose.yml variables
docker-compose up
```

## Requirements

- PhantomJS > 1.9.1
- Python > 2.6

## Setup

### 1. Configure an IFTTT Maker channel
    1. https://ifttt.com/create
    1. Select "Maker Webhooks" then "Receive a Web Request"
    1. Event name: `credit_karma`
    1. Define action, set message: `CreditKarma report for {{Value3}}: {{Value1}} ({{Value2}})`
        - Value1: Credit Score
        - Value2: Score Rating (good/great/poor)
        - Value3: Date Pulled

### 2. Set variables and run the script

```sh
# Install NPM packages
npm install -g casperjs
npm install

# Copy .env-sample
cp .env-sample .env

# Edit .env, then source variables
source .env

# Run script
npm start
```
