### Задача:

## Шаг 1. 

Создать минимальный сервис, который
- **отвечает на порту 8000**
- **имеет http-метод**
```
GET /health/ 
RESPONSE: {"status": "OK"} 
```

## Шаг 2. Cобрать локально образ приложения в докер.
- **Запушить образ в dockerhub**

## Шаг 3. Написать манифесты для деплоя в k8s для этого сервиса.

Манифесты должны описывать сущности: Deployment, Service, Ingress.

В Deployment могут быть указаны Liveness, Readiness пробы.

Количество реплик должно быть не меньше 2. Image контейнера должен быть указан с Dockerhub.

Хост в ингрессе должен быть arch.homework. В итоге после применения манифестов GET запрос на http://arch.homework/health должен отдавать 
```{“status”: “OK”}.```

Шаг 4. На выходе предоставить

1) ссылку на github c манифестами. Манифесты должны лежать в одной директории, так чтобы можно было их все применить одной командой kubectl apply -f .

2) url, по которому можно будет получить ответ от сервиса (либо тест в postmanе).

### Задание со звездой

В Ingress-е должно быть правило, которое форвардит все запросы с /otusapp/{student name}/* на сервис с rewrite-ом пути. Где {student name} - это имя студента.

Например: curl arch.homework/otusapp/aeugene/health -> рерайт пути на arch.homework/health

### Решение

Для запуска необходимо иметь установленный **minikube** и **kubectl**. Также для удобства используйте утилиту **make**

Порядок запуска:

1. Склонировать репозиторий
```shell
    git clone https://github.com/POMBNK/otus-k8s
``` 

2. Запустить Minikube
```shell
    make start
```

3. Активировать Ingress controller (nginx)
```shell
  minikube addons enable ingress
```

4. Применить манифесты
```shell
  make apply
```

5. Добавить в файл hosts пау 127.0.0.1 arch.homework


6. Создать маршрут к службам, развернутым с помощью type LoadBalancer, и установить для них вход в их ClusterIP
```shell
  make tunnel
```

7. Выполнить следующие curl запросы для проверки
```curl
curl 'http://arch.homework/health/' \
  -H 'Accept: application/json' 
```

Для доп задания:
```curl
curl 'http://arch.homework/otusapp/aspd/health/' \
  -H 'Accept: application/json' 
```