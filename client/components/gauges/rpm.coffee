fission = require '../../app'
easyPie = require '../../vendor/easypie'

{div} = fission.React.DOM

gauge = {}

View = fission.view
  init: ->
    return data: 0
  mounted: ->
    @setState data: @props.data
    gauge = new easyPie @refs.gaugeChart.getDOMNode(),
      size: 250
      rotate: 180
      trackColor: '#262626'
      lineWidth: 25
      barColor: (percent) ->
        return '#44decf'
      lineCap: 'butt'

  componentWillReceiveProps: (props) ->
    @setState data: props.data
    gauge.update @state.data
  render: ->
    div ref: 'gaugeChart'

module.exports = View
