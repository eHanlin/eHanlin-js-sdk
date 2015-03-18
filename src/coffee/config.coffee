
EH = if window.EH then window.EH else {root:"/"}

randId = -> "EH_#{(+new Date())}_#{parseInt(Math.random()*10000)}_#{parseInt(Math.random()*10000)}"

DATA_KEY = "EH_#{randId()}"

JSONP_KEY = "jsonp_#{randId()}"

