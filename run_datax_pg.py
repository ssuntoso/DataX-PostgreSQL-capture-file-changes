import sys
import json
import datetime
import subprocess

datax_path = sys.argv[1]
config_path = sys.argv[2]
result_path = sys.argv[3]

with open(config_path) as config_file:
    config_data = json.load(config_file)

current_time = datetime.datetime.now(datetime.timezone.utc)

sql_query = config_data['job']['content'][0]['reader']['parameter']['connection'][0]['querySql'][0]
sql_query = sql_query.split(' ')
current_date_loc = sql_query.index("<")+1
sql_query[current_date_loc] = "'" + str(current_time) + "'"
sql_query.pop(current_date_loc+1)
sql_query = " ".join(sql_query)

config_data['job']['content'][0]['reader']['parameter']['connection'][0]['querySql'][0] = sql_query
config_data['job']['content'][0]['writer']['parameter']['path'] = result_path
config_json = json.dumps(config_data, indent=4)

with open(config_path, "w") as outfile:
    outfile.write(config_json)

# run DataX
cmd = 'python3 ' + datax_path + ' ' + config_path
returned_output = subprocess.call(cmd, shell=True)

sql_query = config_data['job']['content'][0]['reader']['parameter']['connection'][0]['querySql'][0]
sql_query = sql_query.split(' ')
current_date_loc = sql_query.index(">=")+1
sql_query[current_date_loc] = "'" + str(current_time) + "'"
sql_query.pop(current_date_loc+1)
sql_query = " ".join(sql_query)

config_data['job']['content'][0]['reader']['parameter']['connection'][0]['querySql'][0] = sql_query
config_json = json.dumps(config_data, indent=4)

with open(config_path, "w") as outfile:
    outfile.write(config_json)