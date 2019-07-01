# Примеры драйверов

## Пример драйвера, работающего через HTTP

Пример драйвера, который получает значения о качестве воздуха с сервера в JSON и отправляет в шину. Проверки на корректность данных и http-код ответа опущены.

```lua
local function get_values()
   local client = require'http.client'.new();
   local http_result = client:post('http://example.com/sensors/pm/last.php')
   local decoded_data = require('json').decode(http_result.body)

   set_value("/air/pm25", decoded_data.pm25)
   set_value("/air/pm10", decoded_data.pm10)
end

local function main_loop()
   while true do
      get_values()
      fiber.sleep(60*5)
   end
end

function init()
   store.fiber_object = fiber.create(main_loop)
end

function destroy()
   if (store.fiber_object:status() ~= "dead") then
      store.fiber_object:cancel()
   end
end
```

## Пример адаптера для InfluxDB

Пример драйвера, который отправляет значения всех топиков в InfluxDB по http-коннектору. 

```lua
init, destroy, masks = function() end, function() end, {".+"}

local influx = {}
influx.INFLUX_ADDRESS = "http://localhost:8086"
influx.UTC_OFFSET = 0
influx.DATABASE_NAME = "glial_db"

local url_add_value = string.format('%s/write?db=%s&precision=ms', influx.INFLUX_ADDRESS, influx.DATABASE_NAME)
local url_create_db = string.format('%s/query', influx.INFLUX_ADDRESS)

function topic_update_callback(value, topic, time_local_s)
   local value_number = tonumber(value)
   if (value_number ~= nil) then
      local time_utc_ms
      local time_utc_s_string
      if (time_local_s ~= nil) then
         local time_utc_s = time_local_s-(influx.UTC_OFFSET*60*60)
         time_utc_ms = math.ceil(time_utc_s*1000)
      end
      local topic_no_spaces = topic:gsub(" ", "_")
      local data = string.format('%s value=%s %s', topic_no_spaces, value_number, time_utc_ms)
      local r = http_client:post(url_add_value, data, {timeout = 1})
      if (r.body ~= nil) then
         local data = json.decode(r.body)
         if (string.find(data.error, "database not found")) then
            local query = string.format('q=CREATE DATABASE %s', influx.DATABASE_NAME)
            http_client:post(url_create_db, query, {timeout = 1})
            log_warning('Database created:', influx.DATABASE_NAME)
         else
            log_error('Influxdb return error:', r.body)
         end
      else
         store.influx_count = (store.influx_count or 0) + 1
         update{topic = "/glial/export/tarantool-stat/influx_count", value = store.influx_count, shadow = true}   
      end
   end
end
```

## Пример драйвера, работающего через MQTT с обратным распространением данных

Пример драйвера c MQTT и обратным распространением данных: при изменении значения топика "/ud/1674/lora/commands" в bus, будет отправлено сообщение в MQTT.

```lua
local mqtt_host = "mosquitto"
local mqtt_port = 1883
local mqtt_name = "glue_".._script_name.."_"..require('system').random_string()
local mqtt_object
masks = {"/ud/1674/lora/commands"}

local function driver_mqtt_callback(message_id, topic, payload, qos, retain)
   if (payload == nil) then return end
   local data = json.decode(payload)
   local lora_data = {}
   _, _, lora_data.serial, lora_data.device_type  = string.find(topic, "devices/lora/(.+)/(.+)")
   if (data == nil or data.data == nil or data.status == nil) then return end
   if (lora_data.serial == nil or lora_data.device_type == nil) then return end

   update{topic = "/ud/1674/lora/"..lora_data.serial.."/".."temperature/1", value = tonumber(data.data.s1)}
   update{topic = "/ud/1674/lora/"..lora_data.serial.."/".."rssi", value = tonumber(data.status.rssi)}
   update{topic = "/ud/1674/lora/"..lora_data.serial.."/".."battery", value = tonumber(data.status.battery)}

end

function init()
   local conn = socket.tcp_connect(mqtt_host, mqtt_port, 2)
   if (conn ~= nil) then
      conn:close()
      mqtt_object = mqtt.new(mqtt_name, true)
      local mqtt_status, mqtt_err = mqtt_object:connect({host=mqtt_host, port=mqtt_port})
      if (mqtt_status ~= true) then
         error('MQTT error '..(mqtt_err or "unknown error"))
      else
         mqtt_object:on_message(driver_mqtt_callback)
         mqtt_object:subscribe('/devices/lora/#', 0)
      end
   else
      error('Connect to host '..mqtt_host..' failed')
   end
end

function topic_update_callback(value, topic, timestamp)
   mqtt_object:publish('devices/lora/commands', value, mqtt.QOS_0, mqtt.RETAIN)
end

function destroy()
   return false
end
```
