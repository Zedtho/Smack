import time
import anthropic
import subprocess
import input_output
import logging
import os
import sys
import tkinter as tk
from tkinter import simpledialog
import json
import threading
from dotenv import load_dotenv
from appdirs import AppDirs
from playsound import playsound
from filelock import FileLock, Timeout


from gui import start_GUI



"""Loading up environment variables and dictionaries from memory"""

clientanthropic = None

def load_everything():
    global clientanthropic
    dirs = AppDirs("Smack", "Smack project")
    user_config_path = dirs.user_config_dir
    os.makedirs(user_config_path, exist_ok=True)
    path = os.path.join(*os.path.split(__file__)[:-1])
    self_description = ""
    os.chdir(path)

    logging.basicConfig(level=logging.INFO)
    logging.basicConfig(filename='smack.log', level=logging.info)

    env_path = os.path.join(user_config_path, ".env")
    load_dotenv(env_path)
    anthropic_api_key = os.getenv('ANTHROPIC_API_KEY')

   

    wildcard_path = os.path.join(user_config_path, "wildcardlist.json")
    if os.path.exists(wildcard_path) and os.path.getsize(wildcard_path) > 0:
        with open(wildcard_path, "r") as file:
            data = json.load(file)
            if isinstance(data, dict):
                wildcardlist = data
            else:
                logging.info("Creating new wildcard dictionary")
                    
    else:
        with open(wildcard_path, "w") as file:
            logging.info("Creating new wildcard dictionary")
            wildcardlist = {"Safeword": True}
            json.dump(wildcardlist, file)

    self_descript_path = os.path.join(user_config_path, "self-description.txt")
    if os.path.exists(self_descript_path) and os.path.getsize(self_descript_path) > 0:
        with open(self_descript_path, "r") as f:
            self_description = f.read()
    else:
        with open(self_descript_path, "w") as file:
            logging.info("Creating new self-descript")
            self_description = ""
            f.write(self_description)
    
    
    whiteblacklist_path = os.path.join(user_config_path, "whiteblacklist.json")
    whiteblacklist = load_whiteblacklist(whiteblacklist_path)

    misc_path = os.path.join(user_config_path, "misc.json")
    misc_dict = load_misc(misc_path)
    config_dict = {
        'api-key': anthropic_api_key,
        'self-description': self_description,
        'wildcardlist': wildcardlist,
        'whiteblacklist': whiteblacklist,
        'path_whiteblacklist': whiteblacklist_path
    }
    config_dict.update(misc_dict)
    return config_dict

def query_model(content, service, plans, self_description):
    try:
        response = clientanthropic.messages.create(
            max_tokens = 3,
            model="claude-3-5-sonnet-20241022",
            temperature = 0,
            system = f"{self_description}, and today my plans are: {plans}. Please determine if a given activity is productive or not by looking at currently open window titles. Please reply only with 'Productive', 'Not productive' or 'Unsure'.",
            messages=[
            {
                "role": "user", "content": content
            }
        ]
        )

        response = response.content[0].text

        logging.info(response)
        if response == "Productive" or response == "Unsure":
            return True
        elif response == "Not Productive" or response == "Not productive":
            return False
        return True
    except anthropic.APIConnectionError as e:
        print("The server could not be reached")
        print(e.__cause__)  # an underlying Exception, likely raised within httpx
        return True

# Return False when it is not in wildcardlist, or is actually false (unproductive)
def query_wildcardlist(word, wildcardlist):
    logging.info("Querying wildcardlist")
    for key in wildcardlist.keys():
        if key.lower() in word.lower(): 
            return wildcardlist[key]
    return "NA"

def load_whiteblacklist(file_path):
    if os.path.exists(file_path) and os.path.getsize(file_path) > 0:
        with open(file_path, "r") as file:
            data = json.load(file)
            if isinstance(data, dict):
                return data
            else:
                logging.info(f"Creating new dictionary {file_path}")
                return {"Safeword": True}
    else:
        logging.info(f"Creating new dictionary {file_path}")
        return {"Safeword": True}
    
def load_misc(file_path):
    if os.path.exists(file_path) and os.path.getsize(file_path) > 0:
        with open(file_path, "r") as file:
            data = json.load(file)
            if isinstance(data, dict):
                return data
            else:
                logging.info(f"Creating new dictionary {file_path}")
                return {"no-cache": False, "pavlov": False}
    else:
        logging.info(f"Creating new dictionary {file_path}")
        return {"no-cache": False, "pavlov": False}

def save_dictionary(dictionary, file_path):
    if dict:
        with open(file_path, "w") as file:
            json.dump(dictionary, file)

def periodic_save(dictionary, file_path):
    while True:
        logging.info("Saving dictionary")
        save_dictionary(dictionary, file_path)
        time.sleep(20)

def resource_path(relative_path):
    """Get the absolute path to a resource, works for dev and for PyInstaller bundle."""
    if hasattr(sys, '_MEIPASS'):
        # PyInstaller creates a _MEIPASS temporary folder to store resources during execution
        return os.path.join(sys._MEIPASS, relative_path)
    return os.path.join(os.path.abspath("."), relative_path)

def main():
    global clientanthropic
    """First, we load all the variables and interact with the GUI"""
    config_dict = load_everything()
    wildcardlist, whiteblacklist = config_dict['wildcardlist'], config_dict['whiteblacklist']
    config_dict.update(start_GUI(config_dict["api-key"], config_dict["self-description"], config_dict["no-cache"], config_dict['pavlov']))
    plans, anthropic_api_key, self_description, add_to_wildcardlist = config_dict['plans'], config_dict['api-key'], config_dict['self-description'], config_dict['add-to-wildcardlist']
    if config_dict['no-cache']:
        whiteblacklist = {}
    else:
        save_thread = threading.Thread(target=periodic_save, args=(whiteblacklist, config_dict['path_whiteblacklist']))
        save_thread.start()
    
    clientanthropic = anthropic.Anthropic(api_key=anthropic_api_key)

    dirs = AppDirs("Smack", "Smack project")

    """Serializing config"""
    user_config_path = dirs.user_config_dir
    with open(os.path.join(user_config_path, ".env"), "w") as env_file:
        env_file.write("ANTHROPIC_API_KEY=" + anthropic_api_key)
    self_descript_path = os.path.join(user_config_path, "self-description.txt")
    with open(self_descript_path, "w") as f:
        f.write(self_description)
    wildcardlist.update(add_to_wildcardlist)
    wildcard_path = os.path.join(user_config_path, "wildcardlist.json")
    with open(wildcard_path, "w") as file:
        json.dump(wildcardlist, file)
    misc_config_path = os.path.join(user_config_path, "misc.json")
    with open(misc_config_path, "w") as file:
        misc_dict = {
            'no-cache': config_dict['no-cache'],
            'pavlov': config_dict['pavlov']
        }
        json.dump(misc_dict, file)

    
    """The main blocking loop"""
    bark = resource_path('doggo.mp3')
    print(f"{bark}")
    while True:
        content = input_output.read_title()
        logging.info(content)
        if content and not content in whiteblacklist and query_wildcardlist(content, wildcardlist) == "NA":
            logging.info("Querying Claude")
            whiteblacklist[content] = query_model(content, "Claude", plans, self_description)
        if query_wildcardlist(content, wildcardlist) == False or (query_wildcardlist(content, wildcardlist) == "NA" and not whiteblacklist[content]):
            logging.info("Killing")
            input_output.kill_window()
            if config_dict['pavlov']:
                try:
                    playsound(bark)
                except Exception as e:
                    print(f"Error playing sound: {e}")


        time.sleep(1)


if __name__ == '__main__':
    lock_file = 'smack.lock'
    lock = FileLock(lock_file)
    try:
        with lock.acquire(timeout=5):
            main()
    except Timeout:
        print("Another instance of the program is already running. Exiting.")
        sys.exit(1)  # Exit with a non-zero status code to indicate failure    
