from flask import Flask, render_template, request
import json
import os
import logging
import openai

app = Flask(__name__)

'''
submit path
'''
@app.route("/submit", methods=['POST'])
def openai_post():
    model = request.form['model']
    temperature = float(request.form['temperature'])
    prompt_text = request.form['prompt']
    prompt_text = prompt_text[-2000:]
    prompt_text_fruncated = prompt_text[prompt_text.find("You:"):]

    # Set up a logger
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    logger.error("Sending prompt: " + prompt_text)

    openai.api_key = "sk-" + os.getenv("OA_K_1") + os.getenv("OA_K_2") 
    
    response = openai.Completion.create(
        model=model,
        prompt=prompt_text_fruncated,
        temperature=temperature,
        max_tokens=2000,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    response_text = response['choices'][0]['text']
    
    logger.error("response: " + response_text)

    prompt_text += response_text + "\n\nYou: "

    if request.user_agent.platform in ['android', 'iphone', 'ipad']:
        return render_template('mobile_index.html', prompt_text=prompt_text)
    else:
        return render_template('index.html', prompt_text=prompt_text)


'''
default desktop path
'''
@app.route("/", methods=['GET'])
def openai_get():
    if request.user_agent.platform in ['android', 'iphone', 'ipad']:
        return render_template('mobile_index.html', prompt_text="You: ")
    else:
        return render_template('index.html', prompt_text="You: ")


'''
default mobile path
'''
@app.route('/mobile', methods=['GET'])
def openai_mobile_get():
    return 'Mobile device detected'


if __name__ == "__main__":
    app.run(host="0.0.0.0",port=80, debug=True)
