
EH = if window.EH then window.EH else {root:"/"}

CONFIG = if EH.CONFIG then EH.CONFIG else {}

randId = -> "EH_#{(+new Date())}_#{parseInt(Math.random()*10000)}_#{parseInt(Math.random()*10000)}"

DATA_KEY = "EH_#{randId()}"

JSONP_KEY = "jsonp_#{randId()}"

API_DOMAIN = if CONFIG.API_DOMAIN then CONFIG.API_DOMAIN else "test.ehanlin.com.tw:8989"

TRANSITION_END = (()->
  div = document.createElement('div')

  transitions =
    'WebkitTransition' : 'webkitTransitionEnd',
    'MozTransition'    : 'transitionend',
    'OTransition'      : 'oTransitionEnd otransitionend',
    'transition'       : 'transitionend'

  for name, val of transitions
    if div.style[name] != undefined
      return val
      
)()

