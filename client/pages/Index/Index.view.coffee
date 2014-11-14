fission = require '../../app'

clock = require '../../components/clock/view'

rpm = require '../../components/gauges/rpm'
throttle = require '../../components/gauges/throttle'

{div, h1, button, br, span, img, a} = fission.React.DOM



module.exports = ->
  fission.view
    init: ->
      o =
        rpm: 0
        vss: 0
        throttlepos: 0
        btStatus: false
        btText: 'CONNECT'
        btError: null
        opacity: 100
      return o
    mounted: ->

      fission.io.on 'bt', (data) =>
        @setState btStatus: data.bt

      fission.io.on 'bt:error', (data) =>
        @setState
          btError: data.error
          btText: 'TRY AGAIN'

      fission.io.on 'bt:success', =>
        @setState
          btError: null
          btText: 'CONNECTED'
          btStatus: true
          opacity: 0

      fission.io.on 'bt:data', (data) =>
        if !@state.btStatus
          @setState
            btError: null
            btText: 'CONNECTED'
            btStatus: true
            opacity: 0

        name = data.name

        if name == 'vss'
          @setState vss: data.value
        if name == 'rpm'
          @setState rpm: data.value*.01
        if name == 'throttlepos'
          @setState throttlepos: data.value*-1



    connectBt: ->
      @setState btText: 'CONNECTING'
      fission.io.emit 'bt:connect'

    render: ->
      div className: 'main index',
        clock()
        if !@state.btStatus
          div className: 'overlay',
            div
              className: 'connect'
              onClick: @connectBt
            ,
              div className: 'text',
                @state.btText
                if @state.btError?
                  div className: 'error', @state.btError

        div className: 'gauges',
          div className: 'throttle',
            throttle
              data: @state.throttlepos
          div className: 'rpm',
            rpm
              data: @state.rpm
            Math.round @state.rpm*100

          div className: 'vss',
            div className: 'text', @state.vss
