# cbrapp

## Usage
  * `git clone git@github.com:AleksandrKirienko/cbrapp.git`
  * `cd cbrapp`
  * `docker-compose build`
  * `docker-compose up`
  * `docker exec -it cbrapp_web_1 bash`
  * inside container console run `rails db:repare`
  * visit (http://localhost:3000/rate_delta)
## Maybe need to run
  * `sudo systemctl stop postgresql`
  * `/etc/init.d/redis-server stop`
  * or something like this to avoid port conflicts with locally running services
