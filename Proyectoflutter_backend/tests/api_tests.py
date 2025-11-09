import requests
import uuid
import time

BASE = 'http://192.168.1.6:8000'

def pretty_print(title, v):
    print('\n' + '='*10 + ' ' + title + ' ' + '='*10)
    try:
        import json
        print(json.dumps(v, indent=2, ensure_ascii=False))
    except Exception:
        print(v)


if __name__ == '__main__':
    import uuid
    import time
    import json
    from urllib import request, error

    BASE = 'http://127.0.0.1:8000'


    def pretty_print(title, v):
        print('\n' + '='*10 + ' ' + title + ' ' + '='*10)
        try:
            print(json.dumps(v, indent=2, ensure_ascii=False))
        except Exception:
            print(v)


    def http_post(path, payload):
        url = BASE + path
        data = json.dumps(payload).encode('utf-8')
        req = request.Request(url, data=data, headers={'Content-Type': 'application/json'})
        try:
            with request.urlopen(req, timeout=10) as resp:
                body = resp.read().decode('utf-8')
                return resp.getcode(), json.loads(body) if body else None
        except error.HTTPError as e:
            body = e.read().decode('utf-8')
            return e.code, body
        except Exception as e:
            return None, str(e)


    def http_get(path):
        url = BASE + path
        try:
            with request.urlopen(url, timeout=10) as resp:
                body = resp.read().decode('utf-8')
                return resp.getcode(), json.loads(body) if body else None
        except error.HTTPError as e:
            body = e.read().decode('utf-8')
            return e.code, body
        except Exception as e:
            return None, str(e)


    if __name__ == '__main__':
        unique = str(uuid.uuid4())[:8]
        nombre = f'API Test {unique}'
        correo = f'apitest_{unique}@example.com'
        contrasena = '12345678'

        payload = {
            'nombre': nombre,
            'correo': correo,
            'contrasena': contrasena,
            'vidas': 5,
            'nivel_actual': 1,
            'progreso': 0.0
        }

        code, res = http_post('/usuarios', payload)
        pretty_print('REGISTER status', {'code': code})
        if code != 200:
            pretty_print('REGISTER body', res)
            raise SystemExit('Register failed')
        user = res
        pretty_print('REGISTER response', user)
        user_id = user.get('id')

        code, res = http_post('/login', {'correo': correo, 'contrasena': contrasena})
        pretty_print('LOGIN status', {'code': code})
        if code != 200:
            pretty_print('LOGIN body', res)
            raise SystemExit('Login failed')
        pretty_print('LOGIN response', res)

        code, res = http_get(f'/estado_usuario/{user_id}/estado')
        pretty_print('ESTADO status', {'code': code})
        pretty_print('ESTADO response', res)

        code, res = http_get('/niveles')
        pretty_print('NIVELES status', {'code': code})
        if code != 200:
            pretty_print('NIVELES body', res)
            raise SystemExit('List niveles failed')
        pretty_print('NIVELES response', res)

        nivel_id = 1
        code, res = http_get(f'/niveles/{nivel_id}/pregunta')
        pretty_print('PREGUNTA status', {'code': code})
        if code != 200:
            pretty_print('PREGUNTA body', res)
            print('No pregunta para nivel 1, test ends here')
            raise SystemExit()
        pregunta = res
        pretty_print('PREGUNTA response', pregunta)

        opciones = pregunta.get('opciones') or []
        if not opciones:
            print('No opciones encontradas')
            raise SystemExit()
        opcion_id = opciones[0]['id']

        code, res = http_post('/respuestas', {'usuario_id': user_id, 'pregunta_id': pregunta['id'], 'opcion_seleccionada': opcion_id})
        pretty_print('RESPUESTA status', {'code': code})
        pretty_print('RESPUESTA response', res)

        print('\nAll API tests finished')
