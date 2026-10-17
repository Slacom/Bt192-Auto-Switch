"""Local MT MCP transport; no settings/service changes or automatic retries."""
import json,urllib.request
URL='http://127.0.0.1:8787/mcp'
def rpc(method,params=None,timeout=300):
    body={'jsonrpc':'2.0','id':1,'method':method}
    if params is not None:body['params']=params
    req=urllib.request.Request(URL,data=json.dumps(body).encode(),headers={'Content-Type':'application/json','Accept':'application/json, text/event-stream'})
    with urllib.request.urlopen(req,timeout=timeout) as r:text=r.read().decode('utf-8','replace')
    if text.lstrip().startswith(('event:','data:','id:')):
        for line in text.splitlines():
            if line.startswith('data: '):return json.loads(line[6:])
        raise RuntimeError('MT SSE response had no data event')
    return json.loads(text)
def call(name,args):
    raw=rpc('tools/call',{'name':name,'arguments':args})
    if raw.get('error'):raise RuntimeError(raw['error'])
    v=raw['result'];d=v.get('structuredContent') or json.loads(v['content'][0]['text'])
    if v.get('isError') or not d.get('ok'):raise RuntimeError(d)
    return d['data']
