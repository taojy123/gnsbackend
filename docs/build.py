# Python3.7

import os
import re

os.chdir(os.path.dirname(__file__))

# npm i -g raml2html
# raml2html api.raml > api.html

# os.system('npm i -g raml2html')
os.system('raml2html api.raml > api.html')

print('raml to html finish')


content = open('api.html', encoding='utf8').read()

content = content.replace('API documentation', '')

bootstrap_css = '''
<style>%s</style>
<style>.glyphicon-lock:before { content: "*";} </style>
''' % open('res/bootstrap.min.css').read()
content = content.replace('<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">', bootstrap_css)

default_css = '''
<style>%s</style>
<style>.glyphicon-lock:before { content: "*";} </style>
''' % open('res/default.min.css').read()
content = content.replace('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/default.min.css">', default_css)

jquery_js = '''
<script>%s</script>
''' % open('res/jquery-1.11.0.min.js').read()
content = content.replace('<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>', jquery_js)

bootstrap_js = '''
<script>%s</script>
''' % open('res/bootstrap.min.js').read()
content = content.replace('<script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>', bootstrap_js)

# https://github.com/highlightjs/highlight.js/releases/tag/9.12.0
highlight_js = '''
<script>%s</script>
''' % open('res/highlight.js').read()
content = content.replace('<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>', highlight_js)

print('resource modify finish')

content = content.replace('<p><strong>Type</strong>: object</p>', '')
content = content.replace('<p><strong>Type</strong>: any</p>', '')

raml_content = open('api.raml', encoding='utf8').read()
rs = re.findall(r'baseUri:(.+)', raml_content)
if rs:
    host = rs[0].strip()
else:
    host = ''

uris = re.findall(r'<h4 class="modal-title" id="myModalLabel"><span class="badge badge_get">get</span> <span class="parent"></span>(.+?)</h4>', content)
for uri in uris:
    origin = '<h4 class="modal-title" id="myModalLabel"><span class="badge badge_get">get</span> <span class="parent"></span>%s</h4>' % uri
    url = host + uri
    target = '<h4 class="modal-title" id="myModalLabel"><a href="%s" class="badge badge_get">get</a> <span class="parent"></span>%s</h4>' % (url, uri)
    content = content.replace(origin, target)

print('content handle finish')

open('api.html', 'wb').write(content.encode('utf8'))

print('build finish!')

