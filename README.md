<div align="center">
  <h3 align="center">AntonOvesen.Services.Utilities</h3>
  <h6 align="center">A blazor web app containing Utilities i use. Maybe they are useful to you?</h6>
</div>

## Get Started
Get it at [Docker Hub](https://hub.docker.com/r/antonovesen/services-utilities)

`docker pull antonovesen/services-utilities`

`docker run -dp 80:8080 antonovesen/services-utilities:latest`

then just go to [localhost](http://localhost/)

## Features:

### Guid Converter
Converts from UUID to Base64 Guids. 
Made it since [toolslick](https://toolslick.com/conversion/data/guid) doesn't support converting multiple Guids at once.

Only supports Base64 <=> UUID currently since i only use it for converting [MongoDB Old BinData Guids](https://www.mongodb.com/docs/manual/reference/method/BinData/) to and from UUID.
