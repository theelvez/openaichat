from flask import Flask, render_template, request
import json
import requests
import ptvsd
import os

app = Flask(__name__)

@app.route("/submit", methods=['POST'])
def openai_post():
    model = request.form['model']
    prompt = request.form['prompt']
    temperature = float(request.form['temperature'])

    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + "sk-" + os.getenv("OA_K_1") + os.getenv("OA_K_2") 
    }

    data = json.dumps({
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": 4000
    })

    url = "https://api.openai.com/v1/engines/{}/completions".format(model)
    response = requests.post(url, headers=headers, data=data)
    response_text = json.loads(response.text)['choices'][0]['text']

    return render_template('index.html', prompt_text=prompt, response_text=response_text)

@app.route("/openai", methods=['GET'])
def openai_get():
    return render_template('index.html')

ptvsd.enable_attach(address=('0.0.0.0', 5678), redirect_output=True)
ptvsd.wait_for_attach()

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=80, debug=True)
