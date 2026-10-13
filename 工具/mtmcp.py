#!/usr/bin/env python3
"""MT 管理器 MCP 客户端（直连 http://127.0.0.1:8787/mcp，不经 DSH 的 MCP 配置）。

用法:
    mtmcp.py list                    列出全部工具
    mtmcp.py schema <工具名>          打印某个工具的入参 schema
    mtmcp.py call <工具名> '<json>'   调用工具
"""
import json
import sys
import urllib.request

URL = 'http://127.0.0.1:8787/mcp'
HEAD = {'Content-Type': 'application/json', 'Accept': 'application/json, text/event-stream'}


def rpc(method, params=None, timeout=180):
    body = {'jsonrpc': '2.0', 'id': 1, 'method': method}
    if params is not None:
        body['params'] = params
    req = urllib.request.Request(URL, data=json.dumps(body).encode(), headers=HEAD)
    with urllib.request.urlopen(req, timeout=timeout) as r:
        txt = r.read().decode('utf-8', 'replace')
    if not txt.strip():
        return None                      # 通知类请求无响应体
    if txt.lstrip().startswith(('event:', 'data:', 'id:')):
        for line in txt.splitlines():
            if line.startswith('data: '):
                return json.loads(line[6:])
        raise SystemExit('SSE 无 data 行:\n' + txt[:400])
    return json.loads(txt)


def main():
    rpc('notifications/initialized')
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'list'
    if cmd == 'list':
        res = rpc('tools/list')
        tools = res.get('result', {}).get('tools', [])
        print('工具数: %d' % len(tools))
        for t in tools:
            print('  %-38s %s' % (t['name'], (t.get('description') or '').split('\n')[0][:90]))
    elif cmd == 'schema':
        res = rpc('tools/list')
        for t in res.get('result', {}).get('tools', []):
            if t['name'] == sys.argv[2]:
                print(json.dumps(t.get('inputSchema', {}), ensure_ascii=False, indent=2))
                return
        raise SystemExit('没有这个工具: %s' % sys.argv[2])
    elif cmd == 'call':
        args = json.loads(sys.argv[3]) if len(sys.argv) > 3 else {}
        res = rpc('tools/call', {'name': sys.argv[2], 'arguments': args})
        out = res.get('result', res)
        for c in out.get('content', []) if isinstance(out, dict) else []:
            print(c.get('text', json.dumps(c, ensure_ascii=False)))
        if isinstance(out, dict) and 'content' not in out:
            print(json.dumps(out, ensure_ascii=False, indent=2)[:4000])
        if out.get('isError'):
            print('[isError=true]')
    elif cmd == 'callfile':
        args = json.load(open(sys.argv[3]))
        res = rpc('tools/call', {'name': sys.argv[2], 'arguments': args})
        out = res.get('result', res)
        for c in out.get('content', []) if isinstance(out, dict) else []:
            print(c.get('text', json.dumps(c, ensure_ascii=False)))
        if isinstance(out, dict) and 'content' not in out:
            print(json.dumps(out, ensure_ascii=False, indent=2)[:4000])
        if out.get('isError'):
            print('[isError=true]')
    else:
        raise SystemExit(__doc__)


if __name__ == '__main__':
    main()
