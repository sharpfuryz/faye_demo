class window.LiveView
  constructor: ->
    $client = new Faye.Client('http://192.168.0.102:9292/faye')
    window.socket_client = $client
    $client.publish('/items', {text: 'Hi there'});
    $subscription = $client.subscribe('/items', (message)->
      # TODO: Decorate
      console.log message
      item = $('#'+message.id)
      if message.state == 'locked'
        item.addClass('locked')
      if message.state == 'unlocked'
        item.removeClass('locked')
      if message.state == 'hover'
        $('#'+message.id).addClass('hover')
      if message.state == 'remove_hover'
        $('#'+message.id).removeClass('hover')
    )
    console.log $subscription

    $('.item').hover(->
      $(@).addClass 'hover'
      window.socket_client.publish('/items',{id: $(@).attr('id'), state: 'hover'})
    ,->
      $(@).removeClass 'hover'
      window.socket_client.publish('/items',{id: $(@).attr('id'), state: 'remove_hover'})
    )
    $('.item').bind 'click', (e)->
      # TODO: Decorate and extract class Message or Intent
      item = $(e.target)
      id = item.attr('id')
      item.toggleClass('locked')
      if item.hasClass('locked')
        state = 'locked'
      else
        state = 'unlocked'
      object = {id: id, state: state}
      window.socket_client.publish('/items',object)