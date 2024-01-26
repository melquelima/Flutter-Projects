import json

def mallowList(schema,lista):#coverte dados da api para formtado jdson
    sc = schema()
    return [json.loads(sc.dumps(x)) for x in lista if sc.dumps(x) != '{}']

def mallow(schema,obj):#coverte dados da api para formtado jdson
    sc = schema()
    return json.loads(sc.dumps(obj))