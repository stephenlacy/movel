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
      size: 298
      rotate: 180
      trackColor: ''
      scaleColor: ''
      barColor: (percent) ->
        ctx = @renderer.getCtx()
        canvas = @renderer.getCanvas()
        gradient = ctx.createLinearGradient(0, 0, canvas.width, 0)
        gradient.addColorStop 0, "#44decf"
        gradient.addColorStop 1, "#fff"
        return gradient
      lineWidth: 15
      lineCap: 'butt'

  componentWillReceiveProps: (props) ->
    @setState data: props.data
    gauge.update @state.data
  render: ->
    div ref: 'gaugeChart'

module.exports = View
