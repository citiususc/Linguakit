url="http://127.0.0.1:3001/v2.0/tagger"
request='{"text":"Esta é unha foto de Santiago de Compostela.", "output": "nec"}'

curl -s -X POST ${url} -d "${request}" | jq -r .[]
