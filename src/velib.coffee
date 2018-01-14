# Description
#   A hubot script to search for velibs bikes in Paris
#
# Configuration:
#   HUBOT_GOOGLE_API_KEY - Google API to search the coordinates of the place
#
# Commands:
#   hubot velibs in <place> - Returns the numbers 
#
# Author:
#   cristianpb

module.exports = (robot) ->
  robot.respond /hello/, (res) ->
    res.reply "hello!"

  robot.hear /orly/, (res) ->
    res.send "yarly"

  robot.respond /((velibs) )?in (.+)/i, (msg) ->
    mode        = msg.match[2]
    place      = msg.match[3]
    key         = process.env.HUBOT_GOOGLE_API_KEY

    url         = "https://maps.googleapis.com/maps/api/geocode/json"
    query       =
      address:     place
      key:         key


    robot.http(url).query(query).get()((err, res, body) ->
      jsonBody = JSON.parse(body)
      lat = jsonBody.results[0].geometry.location.lat
      lng = jsonBody.results[0].geometry.location.lng

      #sub_url = "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&geofilter.distance=48.8520930694%2C2.34738897685%2C300"
      sub_url = "https://opendata.paris.fr/api/records/1.0/search/"
      sub_url += "?dataset=velib-disponibilite-en-temps-reel"
      arr = [lat, lng, 500].join("%2C")
      sub_url += "&geofilter.distance=" + arr

      #sub_query       =
      #  dataset:     velib-disponibilite-en-temps-reel
      #  geofilter:
      #    distance :  arr

      robot.http(sub_url).get()((err, res, body) ->
        jsonBody = JSON.parse(body)
        nhits = jsonBody.nhits
        if !nhits
          msg.send "No near stations"
          return
        records = jsonBody.records
        names = records.map (item) -> item.fields.name + ': ' + item.fields.numbikesavailable + ' over ' + item.fields.capacity
        capacity_str = names.join('\n')
        

        msg.send "There are #{nhits} stations: \n#{capacity_str}"
      )
    )
