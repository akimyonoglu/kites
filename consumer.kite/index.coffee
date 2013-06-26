###
#
#  consumer Kite for Koding
#  Author: armagan
#
###
kite     = require "kite-amqp/lib/kite-amqp/kite.coffee"
manifest = require "./manifest.json"
natural = require "natural"
counter = 0
consumer = kite.worker manifest,

  consumeque:(options, callback)->
    console.log "options", options
    console.log counter++
    @db.hincrby "wordcount", "words", 1
    tokenizer = new natural.WordTokenizer();
    wordsList = tokenizer.tokenize("#{options.args[0]}")
    for word in wordsList
      @db.hincrby "testMap", word, 1, (err) ->
        if err
          console.error err

    if callback
      callback(false, true)

consumer.on 'running', ()->
  consumer.call 'start', [], ()->
    console.log "started"
    #process.exit 0
