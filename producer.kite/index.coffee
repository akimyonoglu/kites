###
#
#  consumer Kite for Koding
#  Author: armagan
#
###
kite     = require "kite-amqp/lib/kite-amqp/kite.coffee"
manifest = require "./manifest.json"
lineReader = require 'line-reader'

producer = kite.worker manifest,

  start: (options, callback)->
    counter = 0
    que = []
    lineReader.eachLine '../sample.txt', (line, last) =>
      console.log counter++
      que.push line
      if last
        while que.length > 0
          mline = que.pop()
          console.log ">>>>>>", counter--
          @queue  "consumer", "consumeque", [mline], (err, ret)->
            console.log "queue command returned", arguments
        # if last
        #   console.log "file content sent to queue"

producer.on 'running', ()->
  producer.call 'start', [], ()->
    console.log "started"
    #process.exit 0
