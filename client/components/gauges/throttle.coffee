fission = require '../../app'
easyPie = require '../../vendor/easypie'

{div} = fission.React.DOM

gauge = {}

View = fission.view
  init: ->
    return data: 0
  mounted: ->
    gauge = new easyPie @refs.gaugeChart.getDOMNode(),
      size: 310
      rotate: 180
      trackColor: ''
      scaleColor: ''
      barColor: '#44decf'
      lineWidth: 32
      lineCap: 'butt'

  componentWillReceiveProps: (props) ->
    @setState data: props.data
    gauge.update @state.data
  render: ->
    div ref: 'gaugeChart'

module.exports = View
