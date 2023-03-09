#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This script is a wrapper for the GPT-3 API.
# it will be used to return the polished and improved version of the input text.

import os
import openai
import datetime

# from gpt_config import api
from gpt_config import api
openai.organization = api.get("organization")
openai.api_key = api.get("api_key")
model = api.get("model")

# get input from the first argument
input_text = os.sys.argv[1]


messages=[
        {'role':"system", 'content': "you are a helpful assistant, and try to make your reply percise and concise, no extra word."},
        {'role':"user", 'content': f"{input_text}"}
        ]

Parameters = {
    "model": model,
    "messages":messages,
    # "temperature": 0
}


response = openai.ChatCompletion.create(**Parameters)

# example response
"""
{
 'id': 'chatcmpl-6p9XYPYSTTRi0xEviKjjilqrWU2Ve',
 'object': 'chat.completion',
 'created': 1677649420,
 'model': 'gpt-3.5-turbo',
 'usage': {'prompt_tokens': 56, 'completion_tokens': 31, 'total_tokens': 87},
 'choices': [
   {
    'message': {
      'role': 'assistant',
      'content': 'The 2020 World Series was played in Arlington, Texas at the Globe Life Field, which was the new home stadium for the Texas Rangers.'},
    'finish_reason': 'stop',
    'index': 0
   }
  ]
}
"""

if response:
    result = response["choices"][0]['message']['content']
    print(result.strip(), end="")
    # append both input and output to a file in ~/gpt3/history in the following format
    """
     [date]
     prompt: [prompt]
     input:
     output:
    """
    with open(os.path.expanduser("~/gpt3/chat_history"), "a") as f:
        # insert a horizontal separator including a datetime string in center
        f.write("-" * 20 + "{:%Y-%m-%d %H:%M:%S}".format(datetime.datetime.now()) + "-" * 20 + "\n")
        messages.append(response["choices"][0]['message'])
        # write the message as dialog
        for message in messages:
            f.write(f"{message['role']}: {message['content']}\n")
