from flask import Flask, render_template, request
import json
import requests
import os
import logging

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

    # Set up a logger
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    data = json.dumps({
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": 4000
    })

    logger.error("Sending prompt: " + prompt)

    url = "https://api.openai.com/v1/engines/{}/completions".format(model)
    response = requests.post(url, headers=headers, data=data)
    response_text = json.loads(response.text)['choices'][0]['text']
    
    logger.error("Response: " + response_text)

    return render_template('index.html', prompt_text=prompt, response_text=response_text)

@app.route("/openai", methods=['GET'])
def openai_get():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=80, debug=True)
