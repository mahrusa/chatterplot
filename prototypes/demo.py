from llama_index import SimpleDirectoryReader, GPTListIndex, GPTSimpleVectorIndex, LLMPredictor, PromptHelper
from langchain import OpenAI
import sys
import os

os.environ["OPENAI_API_KEY"] = "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"

def createVectorIndex(path):
    # specify variables so the model isnt overwhelmed
    max_input = 4096
    tokens = 256
    chunk_size = 600
    max_chunk_overlap = 20

    prompt_helper = PromptHelper(max_input, tokens, max_input, max_chunk_overlap, chunk_size_limit=chunk_size)

    # define the LLM
    llmPredictor = LLMPredictor(llm=OpenAI(temperature=0, model_name="text-ada-001", max_tokens=tokens))

    # load data
    data = SimpleDirectoryReader(path).load_data()

    # create vector index
    vectorIndex = GPTSimpleVectorIndex(documents=data, llm_predictor=llmPredictor, prompt_helper=prompt_helper)
    vectorIndex.save_to_disk('vectorIndex.json')
    return vectorIndex

def answerMe(vectorIndex):
    vector_index = GPTSimpleVectorIndex.load_from_disk(vectorIndex)
    while True:
        prompt = input("How may I help you?")
        response = vector_index.query(prompt, response_mode="compact")
        print(f"Response: () \n")