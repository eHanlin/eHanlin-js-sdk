
eHanlinSDK
==============================

## Install node modules

```bash
npm install
```

## Support

* IE10+
* chrome
* firefox

## Getting started

init config
```js
var EH = {
  CONFIG:{
    API_DOMAIN:"http://yourdomain:8989/"
  }
};
```

add a plugin html
```html
<div class="eh-score"
     data-eh-action="score"
     data-eh-comment-select='[{"val":"","text":"請選擇段落"},{"val":"全部","text":"全部"}]'
     data-eh-attr-user="user_id"
     data-eh-attr-type="video"
     data-eh-attr-target="av-001"
     data-eh-attr-teacher="teacher_name">
</div>  
```

## Doc

* [api](//github.com/eHanlin/eHanlin-js-sdk/blob/master/doc/api.md)
* [plugin](//github.com/eHanlin/eHanlin-js-sdk/blob/master/doc/plugin.md)

## DEMO

```bash
gulp server
```

## Build

```bash
gulp
```

