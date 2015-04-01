
EH.XEHML
================================================================================
 
## parse( dom, cb )
> parse a dom element to create a plugin
>
> html:
```html
<div class="eh-score"
  data-eh-action="score"
  data-eh-comment-select='[{"val":"","text":"請選擇段落"},{"val":"全部","text":"全部"}]'
  data-eh-attr-user="peter"
  data-eh-attr-type="video"
  data-eh-attr-target="av-001"
  data-eh-attr-teacher="dog">
</div>
```
> javascript:
```js
EH.XEHML.parse( document.querySelector('div.eh-score') );
```

