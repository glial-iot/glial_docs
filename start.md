# Старт системы

## Как запустить Glue?

1. Установите [Tarantool](https://www.tarantool.io/en/download/) >1.9
1. Клонируйте репозиторий: ```git clone https://github.com/vvzvlad/glue.git && cd glue```
1. Установите дополнительные пакеты(для пакета mqtt нужен libmosquitto-dev): ```tarantoolctl rocks install http && tarantoolctl rocks install mqtt && tarantoolctl rocks install dump && tarantoolctl rocks install cron-parser```
1. Запустите серверную часть: ```./cycle_glue.sh``` (запустится HTTP сервер на порту 8080)
1. Установите и запустите панель управления [Glue Panel](https://github.com/vvzvlad/glue_panel)
1. При необходимости, укажите адрес HTTP сервера на странице настроек в панели управления, если он отличается от localhost:8080

## Переменные окружения

### HTTP_PORT
Можно задать порт, на котором запустится веб-сервер API c помощью переменной HTTP_PORT. Если переменная не указана, веб-сервер запустится на порту 8080.

```bash
HTTP_PORT=80 tarantool glue.lua
```

### TARANTOOL_WAL_DIR

С помощью переменной TARANTOOL_WAL_DIR можно указать директорию, отличную от стандартной(./db), в которой будет храниться WAL-лог базы данных. 

```bash
TARANTOOL_WAL_DIR=test_db tarantool glue.lua
```

### TARANTOOL_BIN_PORT

С помощью переменной TARANTOOL_BIN_PORT можно указать порт, на котором будет доступен интерфейс tarantool. Используете эту опцию, только если вы понимаете, что делаете. 

```bash
TARANTOOL_BIN_PORT=3333 tarantool glue.lua
```
