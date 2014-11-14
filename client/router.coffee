fission = require './app'

IndexView = require './pages/Index/Index.view'

router = fission.router
router.route '/',
  title: fission.config.name
  view: IndexView
  el: 'content'

module.exports = router
