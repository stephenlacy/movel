fission = require '../../app'

{div} = fission.React.DOM

View = fission.view
  init: ->
    o =
      clock:
        time:
          h: ''
          m: ''
          s: ''
    return o
  mounted: ->
    @updateClock()
    setInterval @updateClock
    , 1000

  date:
    h: (date) ->
      h = date.getHours()
      if h > 12
        h = h-12
      return h
    m: (date) ->
      m = date.getMinutes()
      if m < 10
        m = "0#{m}"
      return m
    s: (date) ->
      s =  date.getSeconds()
      if s < 10
        s = "0#{s}"
      return s

  updateClock: ->
    date = new Date()
    @setState clock:
      time:
        h: @date.h date
        m: @date.m date
        s: @date.s date

  render: ->
    div className: 'clock',
      div className: 'hours', @state.clock.time.h
      ':'
      div className: 'minutes', @state.clock.time.m
      div className: 'seconds', @state.clock.time.s

module.exports = View
