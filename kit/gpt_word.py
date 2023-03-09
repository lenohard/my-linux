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
        {'role':"system", 'content': "you are a helpful assistant"},
        {'role':"user", 'content': f"""I want to improve my English. I will provide you with some text in any language including English. return only the words or phrase I request without additional ones. the following are examples. return at most 3 options ordered by their probability when there is more than one proper answer. always correct typos and grammatical errors in the sentence. do not return additional words, just return the words or phrases to replace mine.
         Examples:
             me: caussal
             you: causal/casual

             me: _ypo
             you: typo/...

             me: round,sports,球,eleven
             you: soccer/football/basketball

             me: 院子
             you: yard/compound/courtyard

             me: there is a [_, veicle, two wheels] in the yard leaning on the tree.
             you: there is a motorcycle/bicycle in the yard leaning on the tree.

             me: there are too much [_, the name of <> in a html] in this document.
             you: there are too much tags in this document.

             me: how to [re_, 改进] my expression to make it more 精确?
             you: how to refine my expression to make it more precise/accurate?

             me: I 深受 the suffering _ _ depression.
             you: I am deeply affected by the suffering of the depression.

            The text I provide is:
        {input_text} """}
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
